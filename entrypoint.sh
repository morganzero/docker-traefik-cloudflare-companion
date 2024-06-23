#!/bin/sh

# Skip timezone setting by redefining the related commands
sed -i 's|cp /usr/share/zoneinfo/.*|echo "Skipping timezone setting"|' /assets/functions/00-container
sed -i 's|echo .* > /etc/timezone|echo "Skipping timezone setting"|' /assets/functions/00-container

# Execute the original script
if [ -f /assets/functions/00-container ]; then
    . /assets/functions/00-container
fi

# Run the specified command
exec "$@"
