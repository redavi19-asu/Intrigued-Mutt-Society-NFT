# Intrigued Mutt Society NFT

Local preview
- Serve statically (examples): `python -m http.server 4173` then open http://localhost:4173/
- Flow should remain: landing image -> door video -> mancave loop.

Notes on current UX
- Modal panels replace toasts, hotspots show glow, and a sound toggle starts muted by default.
- Mobile tap hints show on touch devices; URL hash `#mancave` deep-links to the interactive loop.
- Loader waits for landing image and both MP4s before enabling interactions.

MP4 compression tip (web-friendly)
- Re-encode with H.264, faststart, and yuv420p for wide playback support:
- `ffmpeg -i INPUT.mp4 -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -movflags +faststart -c:a aac -b:a 128k OUTPUT.mp4`