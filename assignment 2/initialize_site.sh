#!/bin/sh

if[ -n "$SITE_URL" ]; then
    echo "Downloading site: $SITE_URL"
    cd /usr/share/nginx/html
    
    # Remove default nginx html files
    rm -rf *
    
    # Download the complete site
    wget -E -k -p "$SITE_URL"
    
    # Wget creates a directory named after the hostname. 
    # We find it and move its contents directly to the web root.
    DOWNLOAD_DIR=$(ls -d */ 2>/dev/null | head -n 1)
    if [ -n "$DOWNLOAD_DIR" ]; then
        mv "$DOWNLOAD_DIR"* .
        rm -rf "$DOWNLOAD_DIR"
    fi
else
    echo "No SITE_URL provided. Serving default Nginx page."
fi