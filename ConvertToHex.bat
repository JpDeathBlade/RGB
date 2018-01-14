SET DECCOLOR=%~1

:: Width and Height of the image/video.
SET WIDTH=3840
SET HEIGHT=2160

:: Length of the video in seconds.
SET /a DURATION=%DECCOLOR%%% 300 + 600
SET FRAMERATE=60

:: Grab hex value.
call cmd /c exit %DECCOLOR%
SET HEXCOLOR=%=exitcode:~-6%

:: Create an image of a solid color.
magick convert -size %WIDTH%x%HEIGHT% xc:white -fill #%HEXCOLOR% -opaque white %HEXCOLOR%.jpg

:: Convert the image into a video of %DURATION% seconds.
ffmpeg -loop 1 -i %HEXCOLOR%.jpg -c:v libx264 -r %FRAMERATE% -t %DURATION% -pix_fmt yuv420p %HEXCOLOR%.mp4

:: Delete the image now that we no longer need it.
del %HEXCOLOR%.jpg

:: Upload the video to YouTube.
python youtube-upload --title="#%HEXCOLOR%" --description="This is #%HEXCOLOR%" --category=Entertainment --tags="16777216, RGB, R, G, B, Project, HEX, Hexadecimal, HTML, Color, Colors, Colour, Colours, Code, Codes, 4K, 60, FPS, %HEXCOLOR%" --privacy=public %HEXCOLOR%.mp4

:: Now that the movie is uploaded, remove the file.
del %HEXCOLOR%.mp4

echo %DECCOLOR% > LastColorToRun.txt
