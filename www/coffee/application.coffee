$(document).ready ->
  console.log "Initialized Properly"
  myApplication = new LOAF.ApplicationView
    el: $(".bcrumbs-wrapper")

window.LOAF = {}

LOAF.auth1 =
  consumerKey: "7KuRO73ZwWmHITKyZtYDiQ",
  consumerSecret: "PZQhVsM_Uq2AeuoTTs5hOIeaYgU",
  accessToken: "23Nr-ApBWYlaEBMu1xRiU9gytbVUPf91",
  accessTokenSecret: "DLXRb5e66205o-3-PxgsAZ55b-Q",
  serviceProvider:
    signatureMethod: "HMAC-SHA1"

LOAF.auth =
  consumerKey: "AEUkUwiC9VSIRHH6fL9Uyw"
  consumerSecret: "5y3UJ59898NrNHD9zVny6UO2xT0"
  accessToken: "UNsiNW4lTp-Z3BkAWlkcb0S-4cuyvOEg"
  accessTokenSecret: "yvQuPozWOXLuG5ts584MMefOR20"
  serviceProvider:
    signatureMethod: "HMAC-SHA1"
