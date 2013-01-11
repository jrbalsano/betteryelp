$(document).ready ->
  console.log "Initialized Properly"
  LOAF.appView = new LOAF.ApplicationView
    el: $(".bcrumbs-wrapper")

window.LOAF = {}

LOAF.auth =
  serviceProvider:
    signatureMethod: "HMAC-SHA1"
