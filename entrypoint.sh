#!/bin/sh

# Custom startup script that skips timezone setting

# Function to skip timezone settings
timezone_override() {
    echo "Skipping timezone setting"
}

# Override functions in /assets/functions/00-container
if [ -f /assets/functions/00-container ]; then
    sed -i 's|cp /usr/share/zoneinfo/.*|echo "Skipping timezone setting"|' /assets/functions/00-container
    sed -i 's|echo .* > /etc/timezone|echo "Skipping timezone setting"|' /assets/functions/00-container
fi

# Execute the original script if it exists
if [ -f /assets/functions/00-container ]; then
    . /assets/functions/00-container
fi

# Run the specified command
exec "$@"
