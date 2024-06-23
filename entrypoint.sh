#!/bin/sh

# Skip timezone settings
echo "Skipping timezone settings"

# Execute the original entrypoint script if needed
if [ -f /assets/functions/00-container ]; then
    source /assets/functions/00-container
fi

# Run the specified command
exec "$@"
