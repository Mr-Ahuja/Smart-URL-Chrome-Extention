# Copy URL Smartly – CURLs

A minimal, privacy‑friendly Chrome Extension to copy a clean, labeled link of your current tab to the clipboard as both HTML and plain text. Designed to be super fast with a compact, modern popup.

## What It Does
- One‑click copy of the active tab’s link
  - HTML format: `<a href="URL">Title (domain)</a>` for rich editors (Gmail, Docs)
  - Plain text: `URL` for plain editors (Notepad, terminal)
- Auto‑copy on popup open
- Custom title input + Copy button
- Live feedback on copy (button changes to “Copied ✓”, subtle status text)
- Consistent branding: white monogram logo in toolbar, listing, and popup

## UI and Design
- Compact transparent popup with a single rounded container (glass‑like surface)
- Outlined primary button; turns green on copy
- Dark theme first; adapts to light automatically via `prefers-color-scheme`
- “By” credit: The Chosen One – Preetam Ahuja (link on the name)

## How It Works
- Permission: `activeTab`, `tabs` only
- When the popup opens, the extension reads the active tab’s URL/title and copies both HTML and plain text to the clipboard. You can then set a custom title and copy again.
- Clipboard is written using standard DOM copy events within the popup context.

## Files
- `manifest.json` — Manifest V3, action icon, permissions, metadata
- `popup.html` — Minimal UI and styles
- `popup.js` — Logic for reading the tab, copying, and UI feedback
- `icons/` — App icons (PNG) and vector originals (SVG)
  - `smart-url-white.svg` — white stroke monogram used in popup
  - `icon16.png`, `icon24.png`, `icon32.png`, `icon48.png`, `icon128.png` — toolbar/listing icons (white on transparent)
- `PRIVACY.md` — Zero data collection policy
- `CHANGELOG.md` — Release notes
- `store-listing/` — Long description and submission notes
- `scripts/render-icons.ps1` — Optional script to regenerate PNGs from SVG

## Local Install (Unpacked)
1) Go to `chrome://extensions`
2) Enable Developer mode
3) Click “Load unpacked” and select this folder
4) Pin the extension (toolbar puzzle icon → pin “Copy URL Smartly – CURLs”)

## Testing
- Open any normal `http/https` page
- Click the toolbar icon; it auto‑copies
- Paste into a rich editor (HTML link) and a plain editor (plain URL)
- Type a custom title, click Copy; button shows “Copied ✓” briefly
- Troubleshooting
  - Some internal pages (`chrome://*`) don’t expose URL/title
  - Check errors via the extension’s “Errors” link in `chrome://extensions`

## Icon Regeneration (Optional)
If you tweak the SVG and want fresh PNGs:
- Run: `powershell -ExecutionPolicy Bypass -File scripts/render-icons.ps1`
- This renders 16/24/32/48/128 PNGs into `icons/`
- Reload the extension and re‑pin the toolbar icon to refresh the cache

## Privacy
- No analytics, no tracking, no external network requests
- Only reads active tab URL/title at popup open
- See `PRIVACY.md`

## Versioning
- Update `version` in `manifest.json` for each release (e.g., 1.0.1 → 1.0.2)
- Update `CHANGELOG.md`

## Packaging for the Chrome Web Store
Use the provided script to create a clean ZIP with only the required files.

- npm run package
  - This runs `scripts/package.ps1` and outputs `dist/curls-<version>.zip` using the version from `manifest.json`.
- Or run directly:
  - powershell -ExecutionPolicy Bypass -File scripts/package.ps1

The ZIP includes: `manifest.json`, `popup.html`, `popup.js`, `icons/`, `PRIVACY.md`, `README.md`, `CHANGELOG.md`, `store-listing/`.



## Support Page (GitHub Pages)
A single-page support site is included under `docs/`.

Enable GitHub Pages
- Repo Settings → Pages
- Source: Deploy from a branch
- Branch: `master` (or your default), Folder: `/docs`
- Save. Your site will be published to a URL like:
  - `https://<your-username>.github.io/Smart-URL-Chrome-Extention/`

Update CTAs
- To change the email CTA, edit `docs/index.html` and update the `mailto:` link.
- Profile CTA already points to `https://preetam.thechosenone.in/`.

Support page: https://Mr-Ahuja.github.io/Smart-URL-Chrome-Extention/

