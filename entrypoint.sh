#!/bin/sh

# Custom startup script

# Log message indicating skipping of original container init script
echo "Skipping /assets/functions/00-container due to syntax errors"

# Run the specified command
exec "$@"
