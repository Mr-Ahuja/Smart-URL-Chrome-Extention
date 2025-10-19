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
You need a ZIP of the extension contents (no `.git` or local tooling):

Windows PowerShell example:

- Create a clean folder (optional):
  - `New-Item -Type Directory -Force dist | Out-Null`
- Zip only required files (manifest, popup, scripts, icons, docs):
  - `Compress-Archive -DestinationPath dist/curls-1.0.0.zip -Force -Path @("manifest.json","popup.html","popup.js","icons","PRIVACY.md","README.md","CHANGELOG.md","store-listing")`

Notes:
- Exclude `.git`, `scripts` (unless you want to include the store listing folder only), and any temp files
- The Web Store accepts ZIP uploads; no build step is needed

## Publishing Steps (Chrome Web Store Developer Dashboard)
1) Create a developer account at the Chrome Web Store Developer Dashboard
   - Pay the one‑time registration fee if you haven’t already
2) Click “New item” and upload your ZIP (e.g., `dist/curls-1.0.0.zip`)
3) Fill Listing Details
   - Title: `Copy URL Smartly – CURLs`
   - Short description (<=132 chars): “Copy a clean, labeled link of the current tab (HTML + plain text).”
   - Detailed description: use `store-listing/description.txt` content
   - Category: Productivity
   - Icons: already included via the ZIP (`icons/icon128.png` required)
   - Screenshots: add at least one (1280×800 or 640×400); include the popup
   - Privacy policy: link to your hosted `PRIVACY.md` or GitHub repo file
4) Permissions Review
   - Declared: `activeTab`, `tabs` (minimal)
   - Justification: needed to read active tab’s URL/title when the popup opens
5) Save Draft and Run Checks
   - Fix any warnings surfaced by the dashboard
6) Submit for Review
   - Optionally select visibility (public/unlisted) and regions
   - Expect review to take from hours to a few days
7) After Approval
   - Share the store link or set to public
   - For updates, bump `version` in `manifest.json`, re‑zip, and submit a new version

## Roadmap / Ideas
- Optional domain toggle (append/remove domain)
- Configurable auto‑copy behavior
- Keyboard shortcut to copy without opening the popup

## Support
Open an issue at the repository.
