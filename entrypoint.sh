#!/bin/sh

# Create a temporary script that comments out the timezone settings
TEMP_SCRIPT=$(mktemp)

sed 's|cp /usr/share/zoneinfo/.*|# Skipping timezone setting|; s|echo .* > /etc/timezone|# Skipping timezone setting|' /assets/functions/00-container > $TEMP_SCRIPT

# Source the modified script
. $TEMP_SCRIPT

# Clean up the temporary script
rm -f $TEMP_SCRIPT

# Run the specified command
exec "$@"
