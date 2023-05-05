---
layout: experiments
title: TensorFlow 2 on M1/M2 Macs 
published: true
categories: tech
description: Getting started with TensorFlow2. Installing and Running it on Apple M1 (ARM) (ARM64) Machines.
lead_image: metal_tensorflow.png
---

<p><img src="/assets/images/metal_tensorflow.png" alt="Teams" class="responsive" /></p>

<hr>
##### I ran into issues when getting started with Tensorflow 2.0 on macOS M1, this post may help others who are trying to get started with TensorFlow 2.0 on Apple M1 Macs. This post is a work in progress and will be updated as I learn more. 
<hr>

macOS M1 machine come with GPU framework, [Metal](https://developer.apple.com/metal/) supports new M1 CPUs with Graphics capabilities as well. 
Over the last 2 years, Apple has been working towards making M1 platform more accessible for Machine Learning.

Also Running machine learning frameworks on laptops with smaller loads has several benefits. One of the main benefits is the ability to work on projects on-the-go, without being tied to a dedicated workstation or server. Additionally, on laptops smaller loads typically have less power consumption.

Apple's M1 arm based chips, which is used in the latest MacBooks, is designed to be a powerful and efficient processor for running machine learning workloads. The macos-metal and macos-tensorflow frameworks enable running TensorFlow 2 on M1 machines, which provides even better performance than running it on traditional x86 processors because it's SoC rather than having different components plugging in together - read more [here](https://www.apple.com/sg/newsroom/2022/03/apple-unveils-m1-ultra-the-worlds-most-powerful-chip-for-a-personal-computer/)

Anyway, getting it right is little bit tricky, but here are simple things you can do get it write.

NOTE: Please note that Code snippets wrap in small screen, and also take care that code snippets are for reference only, and may not work as is in the future.


* Follow the [guide](https://developer.apple.com/metal/tensorflow-plugin/) at Apple's Metal page
* Execute 

      conda list | grep tensorflow

* It should produce something like this

      tensorflow-deps           2.9.0                         0    apple
      tensorflow-estimator      2.11.0                   pypi_0    pypi
      tensorflow-macos          2.11.0                   pypi_0    pypi
      tensorflow-metal          0.7.0                    pypi_0    pypi

* if you see tensorflow-deps version not matching up with tensorflow-macos, then you need to match it.

      python -m pip install tensorflow-macos==2.9.0

* Next check tensorflow-metal version, it should match up with tensorflow-macos on [this](https://developer.apple.com/metal/tensorflow-plugin/) page under releases section, eg for 2.9.0 it should be 0.5.0

      python -m pip install tensorflow-metal==0.5.0

* Executing 'conda list | grep tensor-flow' command should produce same list with matching versions

      tensorflow-deps           2.9.0                         0    apple
      tensorflow-estimator      2.9.0                    pypi_0    pypi
      tensorflow-macos          2.9.0                    pypi_0    pypi
      tensorflow-metal          0.5.0                    pypi_0    pypi


* Now you can run the sample code from [verify section at the same page](https://developer.apple.com/metal/tensorflow-plugin/) and save it as test-tf.py

      python test-tf.py

* If you see something like this, you are good to go!

      Metal device set to: Apple M1 Max
    
      systemMemory: 64.00 GB
      maxCacheSize: 24.00 GB
    
      2023-01-14 12:53:04.405180: I tensorflow/core/common_runtime/pluggable_device/pluggable_device_factory.cc:305] 
      Could not identify NUMA node of platform GPU ID 0, defaulting to 0. Your kernel may not have been built with NUMA support.
      
      2023-01-14 12:53:04.405322: I tensorflow/core/common_runtime/pluggable_device/pluggable_device_factory.cc:271] 
      Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 0 MB memory) 
      -> physical PluggableDevice (device: 0, name: METAL, pci bus id: <undefined>)

      2023-01-14 12:53:05.154778: W tensorflow/core/platform/profile_utils/cpu_utils.cc:128] 
      Failed to get CPU frequency: 0 Hz
      Epoch 1/5
      /Users/<username>/miniconda/lib/python3.10/site-packages/tensorflow/python/util/dispatch.py:1082: 
      UserWarning: "`sparse_categorical_crossentropy` received `from_logits=True`, 
      but the `output` argument was produced by a sigmoid or softmax activation and thus does not represent logits. 
      Was this intended?" return dispatch_target(*args, **kwargs)

      2023-01-14 12:53:06.921552: I tensorflow/core/grappler/optimizers/custom_graph_optimizer_registry.cc:113] 
      Plugin optimizer for device_type GPU is enabled.
      782/782 [==============================] - 43s 51ms/step - loss: 4.7827 - accuracy: 0.0628
      Epoch 2/5
      782/782 [==============================] - 41s 53ms/step - loss: 4.3533 - accuracy: 0.1088
      Epoch 3/5
      782/782 [==============================] - 42s 53ms/step - loss: 3.8121 - accuracy: 0.1608
      Epoch 4/5
      782/782 [==============================] - 42s 53ms/step - loss: 3.6318 - accuracy: 0.1849
      Epoch 5/5
      782/782 [==============================] - 42s 53ms/step - loss: 3.5975 - accuracy: 0.2096

* You can ignore NUMA error, since M1 is UMA (Unified Memory Architecture) and not NUMA (Non-Uniform Memory Access) architecture. Also you can ignore 'Failed to get CPU frequency: 0 Hz' warning, since Metal doesn't have a CPU frequency tensorflow implementation.
