#!/bin/sh

# Define a wrapper function to skip timezone settings
timezone_override() {
    echo "Skipping timezone setting"
}

# Source the original script but skip timezone settings
if [ -f /assets/functions/00-container ]; then
    . /assets/functions/00-container
fi

# Replace timezone setting calls with the override in the sourced script
sed -i 's|cp /usr/share/zoneinfo/.*|timezone_override|' /assets/functions/00-container
sed -i 's|echo .* > /etc/timezone|timezone_override|' /assets/functions/00-container

# Execute the modified script
. /assets/functions/00-container

# Run the specified command
exec "$@"
