$(document).ready ->
  console.log "Initialized Properly"
  myApplication = new LOAF.ApplicationView()

window.LOAF = {}

LOAF.auth =
  consumerKey: "7KuRO73ZwWmHITKyZtYDiQ",
  consumerSecret: "PZQhVsM_Uq2AeuoTTs5hOIeaYgU",
  accessToken: "23Nr-ApBWYlaEBMu1xRiU9gytbVUPf91",
  accessTokenSecret: "DLXRb5e66205o-3-PxgsAZ55b-Q",
  serviceProvider:
    signatureMethod: "HMAC-SHA1"
