function getCurrentTabUrl(callback) {  
    var queryInfo = {
      active: true, 
      currentWindow: true
    };
  
    chrome.tabs.query(queryInfo, function(tabs) {
      var tab = tabs[0]; 
      var url = tab.url;
      var title = tab.title;
      callback(url,title);
    });
  }
  
  function copyURL(statusText, title) {
    document.addEventListener('copy',
    function(event) {

            event.clipboardData.setData('text/html', '<a href="'+statusText+'">'+ title +'</a>'); 
            event.clipboardData.setData('text', statusText);
            event.preventDefault();
        }
    );
    document.execCommand('copy');
  }
  
  function renderURL(statusText, title) {
    document.getElementById('urlLabel').textContent = "Copied";
    let domain = (new URL(statusText));
    copyURL(statusText, title + " " + "( " + domain.hostname + " )" );
  }

  
  document.addEventListener('DOMContentLoaded', function() {
    getCurrentTabUrl(function(url,title) {
      renderURL(url,title);
      renderCustomButton(url);
    });
  });

  function renderCustomButton(url) {
    document.getElementById("customTitleButton").addEventListener('click', function() {
        customTitle = document.getElementById("customTitle").value;
        copyURL(url, customTitle);
    });
    }

