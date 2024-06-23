#!/bin/sh

# Override the timezone setting functions
timezone_override() {
  echo "Skipping timezone setting"
}

export -f timezone_override

# Execute the original script with overridden functions
source /assets/functions/00-container 2>/dev/null || echo "00-container script not found"

# Replace timezone setting calls with the override
sed -i 's|cp /usr/share/zoneinfo/.*|timezone_override|' /assets/functions/00-container
sed -i 's|echo .* > /etc/timezone|timezone_override|' /assets/functions/00-container

# Run the original entrypoint script if needed
exec "$@"
