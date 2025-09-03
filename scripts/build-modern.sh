#!/bin/bash

# Modern Jekyll Site Build Script
echo "🚀 Building modern Jekyll site..."

# Clean previous build
echo "🧹 Cleaning previous build..."
bundle exec jekyll clean

# Build the site
echo "📦 Building site..."
JEKYLL_ENV=production bundle exec jekyll build

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully!"
    echo "📁 Site generated in _site/"
    echo ""
    echo "🌟 Modern features implemented:"
    echo "   ✅ Updated Bootstrap 5.3.2"
    echo "   ✅ Modern CSS with CSS Custom Properties"
    echo "   ✅ Dark/Light theme toggle"
    echo "   ✅ Responsive design with modern cards"
    echo "   ✅ Hero sections with gradients"
    echo "   ✅ Modern navigation with mobile menu"
    echo "   ✅ Improved typography and spacing"
    echo "   ✅ Enhanced accessibility"
    echo "   ✅ Modern blog post layouts"
    echo "   ✅ Updated talks and experiments pages"
    echo ""
    echo "🎉 Your modern Jekyll site is ready!"
else
    echo "❌ Build failed!"
    exit 1
fi
