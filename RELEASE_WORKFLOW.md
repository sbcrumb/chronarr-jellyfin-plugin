# Automated Release Workflow

This repository uses GitHub Actions to automatically create releases when you push a version tag.

## How It Works

The workflow:
1. Triggers when you push a tag like `v2.0.0.0`
2. Finds the pre-built ZIP in `releases/v2.0.0.0/`
3. Calculates the MD5 checksum
4. Creates a GitHub release
5. Uploads the ZIP file

## Release Steps

### 1. Build Plugin Privately (in your dev repo)

```bash
cd /path/to/Chronarr-Jellyfin-Plugin
./build-release.sh
```

This builds the DLL with your license system intact.

### 2. Copy ZIP to Public Repo

```bash
# Example for v2.0.1.0
VERSION="2.0.1.0"
mkdir -p releases/v$VERSION
cp ../Chronarr-Jellyfin-Plugin/Release-DLL/$VERSION/chronarr-jellyfin-plugin_$VERSION.zip releases/v$VERSION/
```

### 3. Commit and Push

```bash
git add releases/v$VERSION/
git commit -m "Add release build for v$VERSION"
git push origin main
```

### 4. Create and Push Tag

```bash
git tag v$VERSION
git push origin v$VERSION
```

### 5. Wait for Automation

GitHub Actions will automatically:
- Create the release
- Upload the ZIP
- Calculate and display the checksum in release notes

Check progress: `https://github.com/sbcrumb/chronarr-jellyfin-plugin/actions`

### 6. Update manifest.json

After the release is created, get the checksum from the release notes and update:

```bash
# The helper script shows you the format
./update-manifest.sh $VERSION <checksum-from-release>

# Then manually edit manifest.json to add the new version entry
# Commit and push manifest.json
git add manifest.json
git commit -m "Update manifest for v$VERSION"
git push origin main
```

## Quick Reference

```bash
# Full workflow
VERSION="2.0.1.0"

# 1. Build (in dev repo)
cd /path/to/Chronarr-Jellyfin-Plugin && ./build-release.sh

# 2. Copy to public repo
cd /path/to/chronarr-jellyfin-plugin.git
mkdir -p releases/v$VERSION
cp ../Chronarr-Jellyfin-Plugin/Release-DLL/$VERSION/chronarr-jellyfin-plugin_$VERSION.zip releases/v$VERSION/

# 3. Commit ZIP
git add releases/v$VERSION/
git commit -m "Add release build for v$VERSION"
git push origin main

# 4. Tag and push
git tag v$VERSION
git push origin v$VERSION

# 5. Wait for GitHub Actions to complete (~1 minute)

# 6. Get checksum from release page, then update manifest
# Edit manifest.json manually, then:
git add manifest.json
git commit -m "Update manifest for v$VERSION"
git push origin main
```

## Troubleshooting

**Workflow fails with "ZIP file not found"**
- Make sure you committed and pushed the ZIP before pushing the tag
- Verify the ZIP is at `releases/vX.X.X.X/chronarr-jellyfin-plugin_X.X.X.X.zip`

**Checksum doesn't match**
- Download the ZIP from the GitHub release
- Calculate locally: `md5sum chronarr-jellyfin-plugin_X.X.X.X.zip`
- Use that checksum in manifest.json
