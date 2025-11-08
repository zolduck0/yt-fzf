# yt-fzf

Downloads your videos entirely through the terminal.

<https://github.com/user-attachments/assets/84aba4e1-a2ac-4851-aa66-8398a60363ac>

## Dependencies

* curl
* [yt-dlp](https://github.com/yt-dlp/yt-dlp)
* [fzf](https://github.com/junegunn/fzf)
* Your own API key (You can get one at [Google Cloud](https://console.cloud.google.com/)
* mpv (Optional, if you want to play the videos you download)

#### 

Current this script only downloads .mp3. This is simply a personal configuration that works best for me. You can make it download videos by removing `-x --audio-format mp3` at line 50. (I may turn this into an option later).
