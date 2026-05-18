// Post page behaviors: reading-progress bar, table-of-contents render +
// scrollspy, share-link copy. Vanilla, no dependency.
(function () {
  'use strict';

  const article = document.querySelector('[data-post-article]');
  if (!article) return;

  // ---- Reading progress bar ------------------------------------------------
  const progressBar = document.querySelector('[data-reading-progress]');
  if (progressBar) {
    const update = () => {
      const rect = article.getBoundingClientRect();
      const total = rect.height - window.innerHeight;
      if (total <= 0) {
        progressBar.style.width = '100%';
        return;
      }
      const scrolled = Math.max(0, -rect.top);
      const pct = Math.min(100, (scrolled / total) * 100);
      progressBar.style.width = pct + '%';
    };
    update();
    window.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', update, { passive: true });
  }

  // ---- Table of contents ---------------------------------------------------
  const tocEl = document.querySelector('[data-post-toc]');
  if (tocEl) {
    const listEl = tocEl.querySelector('[data-toc-list]');
    const navEl = tocEl.querySelector('.post-toc__nav');
    const toggleBtn = tocEl.querySelector('.post-toc__toggle');
    let items = [];
    try {
      items = JSON.parse(tocEl.getAttribute('data-post-toc') || '[]');
    } catch (e) {
      items = [];
    }

    if (items.length && listEl) {
      const frag = document.createDocumentFragment();
      items.forEach((item) => {
        const li = document.createElement('li');
        li.className = 'level-' + item.level;
        li.dataset.tocAnchor = item.id;
        const a = document.createElement('a');
        a.href = '#' + item.id;
        a.textContent = item.title;
        li.appendChild(a);
        frag.appendChild(li);
      });
      listEl.appendChild(frag);

      // Mobile/expand toggle
      if (toggleBtn && navEl) {
        const onWide = () => window.matchMedia('(min-width: 1200px)').matches;
        toggleBtn.addEventListener('click', () => {
          if (onWide()) return;
          const open = toggleBtn.getAttribute('aria-expanded') === 'true';
          toggleBtn.setAttribute('aria-expanded', String(!open));
          if (!open) {
            navEl.removeAttribute('hidden');
          } else {
            navEl.setAttribute('hidden', '');
          }
        });
        // Always open on wide viewports
        const syncForViewport = () => {
          if (onWide()) {
            navEl.removeAttribute('hidden');
            toggleBtn.setAttribute('aria-expanded', 'true');
          }
        };
        syncForViewport();
        window.addEventListener('resize', syncForViewport, { passive: true });
      }

      // Scrollspy
      const targets = items
        .map((i) => document.getElementById(i.id))
        .filter(Boolean);
      const linkByHash = {};
      listEl.querySelectorAll('li').forEach((li) => {
        linkByHash[li.dataset.tocAnchor] = li;
      });
      if (targets.length && 'IntersectionObserver' in window) {
        const visibleIds = new Set();
        const observer = new IntersectionObserver((entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              visibleIds.add(entry.target.id);
            } else {
              visibleIds.delete(entry.target.id);
            }
          });
          // Pick the topmost visible heading
          let activeId = null;
          for (const target of targets) {
            if (visibleIds.has(target.id)) {
              activeId = target.id;
              break;
            }
          }
          Object.values(linkByHash).forEach((li) => li.classList.remove('is-active'));
          if (activeId && linkByHash[activeId]) {
            linkByHash[activeId].classList.add('is-active');
          }
        }, { rootMargin: '-80px 0px -65% 0px', threshold: 0 });
        targets.forEach((t) => observer.observe(t));
      }
    } else {
      // No items resolved → hide the TOC entirely
      tocEl.remove();
    }
  }

  // ---- Copy-link share button ---------------------------------------------
  document.querySelectorAll('[data-copy-url]').forEach((btn) => {
    btn.addEventListener('click', async () => {
      const url = btn.getAttribute('data-copy-url') || window.location.href;
      const original = btn.querySelector('span')?.textContent;
      try {
        if (navigator.clipboard && navigator.clipboard.writeText) {
          await navigator.clipboard.writeText(url);
        } else {
          const ta = document.createElement('textarea');
          ta.value = url;
          document.body.appendChild(ta);
          ta.select();
          document.execCommand('copy');
          document.body.removeChild(ta);
        }
        if (original && btn.querySelector('span')) {
          btn.querySelector('span').textContent = 'Copied!';
          setTimeout(() => {
            if (btn.querySelector('span')) btn.querySelector('span').textContent = original;
          }, 1600);
        }
      } catch (e) {
        // ignore
      }
    });
  });
})();
