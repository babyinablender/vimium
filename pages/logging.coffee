$ = (id) -> document.getElementById id

document.addEventListener "DOMContentLoaded", ->
  $("vimiumVersion").innerText = Utils.getCurrentVersion()

  chrome.storage.local.get "installDate", (items) ->
    $("installDate").innerText = items.installDate.toString()

  branchRefRequest = new XMLHttpRequest()
  branchRefRequest.addEventListener "load", ->
    branchRefParts = branchRefRequest.responseText.split "refs/heads/", 2
    if branchRefParts.length == 2
      $("branchRef").innerText = branchRefParts[1]
    else
      $("branchRef").innerText = "HEAD detatched at #{branchRefParts[0]}"
    $("branchRef-wrapper").classList.add "no-hide"
  branchRefRequest.open "GET", chrome.extension.getURL ".git/HEAD"
  branchRefRequest.send()

