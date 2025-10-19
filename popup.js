async function getActiveTab() {
  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  return tab;
}

function copyURL(url, title) {
  // Copy both HTML anchor and plain text
  document.addEventListener(
    'copy',
    (event) => {
      event.clipboardData.setData('text/html', `<a href="${url}">${title}</a>`);
      event.clipboardData.setData('text/plain', url);
      event.preventDefault();
    },
    { once: true }
  );
  document.execCommand('copy');
}

function setStatus(msg) {
  const el = document.getElementById('status');
  if (el) el.textContent = msg || '';
}

function indicateCopy(btn) {
  if (!btn) return;
  const original = btn.textContent;
  btn.classList.add('copied');
  btn.textContent = 'Copied ✓';
  setStatus('Copied to clipboard');
  setTimeout(() => {
    btn.classList.remove('copied');
    btn.textContent = original;
    setStatus('');
  }, 1200);
}

async function main() {
  try {
    const tab = await getActiveTab();
    if (!tab || !tab.url) {
      setStatus('No active tab');
      return;
    }
    const url = tab.url;
    const title = tab.title || 'Link';

    // Auto-copy on open with domain suffix
    copyURL(url, `${title} (${new URL(url).hostname})`);
    const btn = document.getElementById('customTitleButton');
    indicateCopy(btn);

    // Wire custom copy
    const input = document.getElementById('customTitle');
    if (btn && input) {
      input.value = title;
      btn.addEventListener('click', () => {
        const t = input.value?.trim() || title;
        copyURL(url, t);
        indicateCopy(btn);
      });
    }
  } catch (e) {
    setStatus('Error');
  }
}

document.addEventListener('DOMContentLoaded', main);
