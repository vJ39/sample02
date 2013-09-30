#!/usr/local/bin/bash
start_server \
--port=5000 \
-- \
plackup \
-s Starlet \
--max-workers=50 \
--enable-auto-restart \
--auto-restart-interval=10 \
--kill-old-delay=1 \
-R \
pc.psgi
