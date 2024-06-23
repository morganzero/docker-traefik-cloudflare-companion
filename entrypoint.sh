#!/bin/sh

# Override any timezone setting functions
if [ -f /assets/functions/00-container ]; then
    sed -i 's|cp /usr/share/zoneinfo/.*|echo "Skipping timezone setting"|' /assets/functions/00-container
    sed -i 's|echo .* > /etc/timezone|echo "Skipping timezone setting"|' /assets/functions/00-container
fi

# Continue with the original entrypoint
if [ -f /assets/functions/00-container ]; then
    source /assets/functions/00-container
fi

# Execute the specified command
exec "$@"
