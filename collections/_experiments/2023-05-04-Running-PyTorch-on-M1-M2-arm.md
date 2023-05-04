---
layout: post
title: PyTorch on M1/M2 ARM
published: true
categories: tech
description: Running PyTorch on M1/M2 ARM.
lead_image: blog/torch_apple.png
---

<p><img src="/assets/images/blog/torch_apple.png" alt="Teams" class="responsive" /></p>

macOS M1 machine come with GPU and ML/AI framework [Metal](https://developer.apple.com/metal/). 

Apple's M1 arm based chips in the latest MacBooks, are designed to be a powerful and efficient processor for running machine learning workloads. The macos-metal and macos-tensorflow frameworks enable running TensorFlow 2 on M1 machines, which provides even better performance than running it on traditional x86 processors because it's SoC rather than having different components plugging in together - read more [here](https://www.apple.com/sg/newsroom/2022/03/apple-unveils-m1-ultra-the-worlds-most-powerful-chip-for-a-personal-computer/)

Getting it right is little bit tricky, but here are simple things you can do get it write.

NOTE: Please note that Code snippets wrap in small screen, and also take care that code snippets are for reference only, and may not work as is in the future.

To get started with PyTorch, PyTorch website has a very good configuration tool at [https://pytorch.org/](Pytorch Homepage)

<p><img src="/assets/images/blog/torch_configuration.png" alt="PyTorch Configuration" class="responsive" /></p>

This gives us a command line to install pytorch, we will start with Anaconda installation, since it is easier to manage packages and environments.

* Install [Anaconda](https://www.anaconda.com/products/individual) and then create a new environment

      conda create -n pytorch python=3.8

* Activate pytorch environment

      conda activate pytorch
  
* Install pytorch using the command from the website

      conda install pytorch-nightly::pytorch torchvision torchaudio -c pytorch-nightly

* PyTorch might complain about libraries not being available, because they might be available in different homebrew prefix (especially imagemagick etc)

      brew install imagemagick
      brew install libsndfile

* Homebrew which is the de facto installer on MacOS uses /opt/homebrew/lib for the M1 architecture instead of the /usr/local/lib which was used in Intel Macs to mitigate that either you add environment variable to your shell's profile or use following command before running your commands

      export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"

Above command should cause pytorch not to complain about symbol not found or library not found errors.

And with the above steps, you are ready to go run pytorch on M1/M2 ARM Macs. Also, please note these commands might change later once PyTorch completes the full port to M1/M2 ARM machines.