$(document).ready ->
  console.log "Running"
  LOAF.mySearch = new LOAF.YelpList [], term: "cookies"
  LOAF.mySearch.fetch()
  LOAF.myCategory = new LOAF.YelpList [], category: "active"
  LOAF.myCategory.fetch()
  LOAF.myCategory.fetch(page: 2)
  LOAF.myCategory.fetch(page: 2)

window.LOAF = {}

LOAF.auth = 
  consumerKey: "7KuRO73ZwWmHITKyZtYDiQ",
  consumerSecret: "PZQhVsM_Uq2AeuoTTs5hOIeaYgU",
  accessToken: "23Nr-ApBWYlaEBMu1xRiU9gytbVUPf91",
  accessTokenSecret: "DLXRb5e66205o-3-PxgsAZ55b-Q",
  serviceProvider:  
    signatureMethod: "HMAC-SHA1"
  

