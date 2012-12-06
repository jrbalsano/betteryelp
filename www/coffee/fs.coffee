class LOAF.FsJsonObject
  constructor: (options) ->
    options = options || {}
    options.size = options.size || 5 * 1024 * 1024 # default size to 5 MiB
    options.fileName = options.fileName || "Breadcrumbs.json" # default to Breadcrumbs.json
    options.read = options.read || true # default to reading the file automatically
    options.onReady = options.onReady || -> # Function to be called when ready
    @options = options
    window.requestFileSystem = window.requestFileSystem || window.webkitRequestFileSystem
    window.webkitStorageInfo.requestQuota window.PERSISTENT,
      @options.size
      (grantedbytes) =>
        window.requestFileSystem window.PERSISTENT, @options.size, (fs) =>
          @_onGranted(fs)
        @onError
      @_onError

  getObject: ->
    @_jsonObject || {}


  writeObject: (object, successCallback) ->
    if @fs
      @_jsonObject = object
      successCallback = successCallback || ->

      fileWriterHandler = (fileWriter) =>
        window.BlobBuilder = window.BlobBuilder || window.WebKitBlobBuilder
        bb = new BlobBuilder()
        json_string = JSON.stringify(@_jsonObject)
        bb.append json_string
        fileWriter.write bb.getBlob('text/plain')
        successCallback()

      fileEntryHandler = (fileEntry) =>
        fileEntry.createWriter fileWriterHandler, @_onError

      @fs.root.getFile @options.fileName, {create: true}, fileEntryHandler, @_onError

  _onGranted: (fs) =>
    @fs = fs
    if @options.read
      fileHandler = (file) => # Function to handle a file
        reader = new FileReader() # Create a new reader
        _fsJsonObject = @
        reader.onloadend = (e) -> # A function for when file finished loading
          _fsJsonObject._fileRead(this.result) # Call fs's _fileRead function on the contents
          _fsJsonObject.options.onReady _fsJsonObject
        reader.readAsText file

      fileEntryHandler = (fileEntry) =>
        fileEntry.file fileHandler, @_onError

      @fs.root.getFile @options.fileName, {create: true}, fileEntryHandler, @_onError
    else
      @options.onReady @

  _fileRead: (output) ->
    debugger
    @_jsonObject = JSON && JSON.parse(output) || $.parseJSON(output) if output

  _onError: (e) ->
    switch e.code
      when FileError.QUOTA_EXCEEDED_ERR then msg = 'Local storage quota exceeded'
      when FileError.NOT_FOUND_ERR then msg = 'Local storage file not found'
      when FileError.SECURITY_ERR then msg = 'A security error occurred'
      when FileError.INVALID_MODIFICATION_ERR then msg = 'You do not have permission to save results'
      when FileError.INVALID_STATE_ERR then msg = 'Invalid state was encountered'
      else
        msg = 'Unknown Error'
        console.log e
    console.log "Error: #{msg}"
