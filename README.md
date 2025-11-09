# yt-fzf

Downloads your videos entirely through the terminal using [fzf](https://github.com/junegunn/fzf) and [yt-dlp](https://github.com/yt-dlp/yt-dlp).

<https://github.com/user-attachments/assets/84aba4e1-a2ac-4851-aa66-8398a60363ac>

## Installation

Look at [dependencies](##Dependencies) to get all the other stuff needed to run yt-fzf. Otherwise, run this in your Linux machine:

```
curl -L -o install.sh https://raw.githubusercontent.com/zolduck0/yt-fzf/master/install.sh \
  && chmod +x install.sh && ./install.sh && rm install.sh
```

## Dependencies

* curl
* [yt-dlp](https://github.com/yt-dlp/yt-dlp)
* [fzf](https://github.com/junegunn/fzf)
* Your own API key (You can get one at [Google Cloud](https://console.cloud.google.com/))
* mpv (Optional, if you want to play the videos you download)

## Usage

You can type `yt-fzf -h` for help:

```
yt-fzf [option]
yt-fzf - Downloads videos (.mp4 by default).
-a - Downloads audio only (.mp3 by default).
-h for help.
```

Upon install a config file is created at `.config/yt-fzf/`. There you can change `DOWNLOAD_DIR` to a folder you'd like your downloaded files to go.

Although the name is similar, this project wasn't inspired by [yt-fzf](https://github.com/pystardust/ytfzf). You should still check it out though.
