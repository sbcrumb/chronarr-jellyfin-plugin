# Chronarr Jellyfin Plugin

This plugin automatically synchronizes TV episode and movie DateCreated to preserve import dates in Jellyfin.

## Installation

Add this repository to your Jellyfin server:

1. Navigate to **Dashboard → Plugins → Repositories**
2. Click the **+** button to add a new repository
3. Enter the repository URL:
   ```
   https://raw.githubusercontent.com/sbcrumb/chronarr-jellyfin-plugin/main/manifest.json
   ```
4. Go to **Plugins → Catalog** and install **Chronarr**
5. Restart Jellyfin

## What it does

The Chronarr plugin syncs PremiereDate to DateCreated for TV episodes and movies, ensuring Jellyfin displays the correct import date from the Chronarr database instead of scan dates.

## Requirements

- Jellyfin 10.8.0 or higher
- Chronarr webhook service running

## Support

For issues and support, please visit the main Chronarr project repository.

## License

This plugin is provided as-is. See the license terms in the Chronarr project.
