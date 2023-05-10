---
layout: experiments
title: Create a blog from a conversation
categories: tech
description: Creating a blog post from a talk or podcast.
lead_image: blog/video_to_blog.png
---
##### This blog post is still a work in progress, please check back later for more updates.

<p><img src="/assets/images/blog/video_to_blog.png" alt="Teams" class="responsive" /></p>

I was talking to our marketing team at Sequoia, one of the things they do is to look at podcasts or talks we record then extract

* Key momnents
* Quotable quotes
* Blog posts

But what else? 

For that we utilise many SaaS tools to transcribe, then read through those and the convert them to appropriate format. This is very time
consuming process, and I was thinking if we can automate this process. Come to think of it, if we break it down to smaller steps, it is
pretty straight forward. Also with help of AI or LLM models we can actually do a better job when we keep humans in the loop. In this case
AI can act as a first pass, and then humans can review and correct the output.

I know that there are a lot of tools out there to help, I wanted to see if we can do it locally using open source tools.

Some of the basic tasks we can perform are:

* Extract audio from video
* Transcribe audio to text
* Extract key moments
* Extract quotable quotes
* Generate blog post
* Generate social media posts
* Generate video snippets
* Generate audio snippets
* Generate images
* Create subtitles
* Translate and provide subtitles in different languages
* Extract SEO tags
* Extract SEO keywords
* Extract SEO descriptions
* ... and so on!

##### The possibilities are endless, So lets get started with following tasks

* Extract audio from video (Use ffmpeg)
* Transcribe audio to text with Diarization (Speaker identification) so that we know who spoke when 
* Then provide that audio snippets to [Whisper](https://openai.com/research/whisper) 
* Match the audio segments to text segments and tag them with speaker names.
* Generate combined transcript, and provide it to ChatGPT
* And ask ChatGPT to generate a blog post from the transcript.

And we are done! We have a blog post from a talk or podcast. Now to real work and some code.

The code for this is available at [ajeygore/Video2Blog](https://github.com/ajeygore/VideoToBlog) at [Github](https://github.com)


### Packages and Software

* [ffmpeg](https://ffmpeg.org/) - Extract audio from video
* [PyTorch](https://pytorch.org/) - Deep Learning Framework
* [PyDub](https://pypi.org/project/pydub/) - Audio manipulation
* [hmmlearn](https://hmmlearn.readthedocs.io/en/latest/) - Hidden Markov Models in Python
* [imagemagick](https://imagemagick.org/index.php) - Image manipulation
* [soundfile](https://pypi.org/project/SoundFile/) - Read and write sound files
* [libsndfile](https://pypi.org/project/libsndfile/) - C library for reading and writing sound files
* [whisper](openai.com/research/whisper) - Speech recognition/transcription model
* [Chat GPT4](chat.openai.com) - GPT4 based chatbot
* [Anaconda](https://www.anaconda.com/) - Python distribution
* [Pyannote](https://github.com/pyannote/pyannote-audio) - Speaker Diarization

### Installing various packages

To install pytorch, please read details on my [Running PyTorch on M1/M2 Mac](https://ajeygore.in/content/Running-PyTorch-on-M1-M2-arm) blog post.

But for now following code snippets should do the trick.


    #Install dependencies
    brew install ffmpeg
    brew install imagemagick
    brew install libsndfile

    #Create conda environment
    conda create -n video2blog python=3.8
    conda activate video2blog

    #Install packages
    conda install hmmlearn
    pip install pydub

    #Install pytorch
    conda install pytorch-nightly::pytorch torchvision torchaudio -c pytorch-

    #Install pyannote (This version has latest patches to run on ARM chipsets
    pip install -qq https://github.com/pyannote/pyannote-audio/archive/develop.zip
    
    #And export DYLD_LIBRARY_PATH so that on ARM we pick up libraries from /opt/homebrew/lib
    export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"

### Extract audio from video

    ffmpeg -i video.mp4 -acodec pcm_s16le -ac 1 -ar 16000 out.wav

### Use Pyannote for diarization
    pipeline = Pipeline.from_pretrained('pyannote/speaker-diarization',
                                    use_auth_token="<Your Hugging Face Authortization Token>")

    audio_input_file = {'uri': 'blabal', 'audio': './out.wav'}
    dz = pipeline(audio_input_file)
    
    with open("diarization.txt", "w") as text_file:
    text_file.write(str(dz))

### Create individual speaker segments

Second step is to create individual speaker segments, so that we can pass them to Whisper model.

    from pydub import AudioSegment
    from pydub.silence import split_on_silence

    sound_file = AudioSegment.from_wav("out.wav")
    audio_chunks = split_on_silence(sound_file, 
        # must be silent for at least half a second
        min_silence_len=500,

        # consider it silent if quieter than -16 dBFS
        silence_thresh=-16
    )

    for i, chunk in enumerate(audio_chunks):
        out_file = "chunk{0}.wav".format(i)
        print ("exporting", out_file)
        chunk.export(out_file, format="wav")




### References

I have used code from various palces, but here is incomplete list of the articles I went through.
- Article for speaker diarization
  - [Speaker Diarization](https://www.assemblyai.com/blog/top-speaker-diarization-libraries-and-apis/)
  - [LabLab Article](https://lablab.ai/t/whisper-transcription-and-speaker-identification)
- Whisper
  - [OpenAI Whisper](https://github.com/openai/whisper)
  - [Jupyter notebook doing almost same things](https://github.com/lablab-ai/Whisper-transcription_and_diarization-speaker-identification-/blob/main/transcribtion_diarization.ipynb)
- Diarization
  - https://blog.ml6.eu/who-spoke-when-choosing-the-right-speaker-diarization-tool-3d7a115c524b
  - https://www.ml6.eu/knowhow/who-spoke-when-choosing-the-right-speaker-diarization-tool
  - https://speechbrain.github.io/tutorial_basics.html
    - https://github.com/speechbrain/speechbrain/discussions/1651
  - Colab https://colab.research.google.com/drive/12bg3aUdr9mTfOGqcB5pSMABoIKPgiwcM?usp=sharing
  - https://medium.com/saarthi-ai/who-spoke-when-build-your-own-speaker-diarization-module-from-scratch-e7d725ee279
  - https://docs.openvino.ai/latest/notebooks/212-pyannote-speaker-diarization-with-output.html
  - https://medium.com/analytics-vidhya/speaker-diarisation-89c963fa4fe8\
  - https://github.com/rvipandey/SpeakerDiarisation/blob/main/SpeakerDiarization.ipynb



