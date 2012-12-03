// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  LOAF.FsJsonObject = (function() {

    function FsJsonObject(options) {
      this._onGranted = __bind(this._onGranted, this);

      var _this = this;
      options = options || {};
      options.size = options.size || 5120;
      options.fileName = options.fileName || "Breadcrumbs.json";
      options.read = options.read || true;
      options.onReady = options.onReady || function() {};
      this.options = options;
      window.requestFileSystem = window.requestFileSystem || window.webkitRequestFileSystem;
      window.webkitStorageInfo.requestQuota(window.PERSISTENT, this.options.size, function(grantedbytes) {
        window.requestFileSystem(window.PERSISTENT, _this.options.size, function(fs) {
          return _this._onGranted(fs);
        });
        return _this.onError;
      }, this._onError);
    }

    FsJsonObject.prototype.getObject = function() {
      return this._jsonObject;
    };

    FsJsonObject.prototype.writeObject = function(object, successCallback) {
      var fileEntryHandler, fileWriterHandler,
        _this = this;
      if (this.fs) {
        this._jsonObject = object;
        successCallback = successCallback || function() {};
        fileWriterHandler = function(fileWriter) {
          var bb, json_string;
          window.BlobBuilder = window.BlobBuilder || window.WebKitBlobBuilder;
          bb = new BlobBuilder();
          json_string = JSON.stringify(_this._jsonObject);
          bb.append(json_string);
          fileWriter.write(bb.getBlob('text/plain'));
          return successCallback();
        };
        fileEntryHandler = function(fileEntry) {
          return fileEntry.createWriter(fileWriterHandler, _this._onError);
        };
        return this.fs.root.getFile(this.options.fileName, {
          create: true
        }, fileEntryHandler, this._onError);
      }
    };

    FsJsonObject.prototype._onGranted = function(fs) {
      var fileEntryHandler, fileHandler,
        _this = this;
      this.fs = fs;
      if (this.options.read) {
        fileHandler = function(file) {
          var reader, _fsJsonObject;
          reader = new FileReader();
          _fsJsonObject = _this;
          reader.onloadend = function(e) {
            _fsJsonObject._fileRead(this.result);
            return _fsJsonObject.options.onReady(_fsJsonObject);
          };
          return reader.readAsText(file);
        };
        fileEntryHandler = function(fileEntry) {
          return fileEntry.file(fileHandler, _this._onError);
        };
        return this.fs.root.getFile(this.options.fileName, {
          create: true
        }, fileEntryHandler, this._onError);
      } else {
        return this.options.onReady(this);
      }
    };

    FsJsonObject.prototype._fileRead = function(output) {
      debugger;      if (output) {
        return this._jsonObject = JSON && JSON.parse(output) || $.parseJSON(output);
      }
    };

    FsJsonObject.prototype._onError = function(e) {
      var msg;
      switch (e.code) {
        case FileError.QUOTA_EXCEEDED_ERR:
          msg = 'Local storage quota exceeded';
          break;
        case FileError.NOT_FOUND_ERR:
          msg = 'Local storage file not found';
          break;
        case FileError.SECURITY_ERR:
          msg = 'A security error occurred';
          break;
        case FileError.INVALID_MODIFICATION_ERR:
          msg = 'You do not have permission to save results';
          break;
        case FileError.INVALID_STATE_ERR:
          msg = 'Invalid state was encountered';
          break;
        default:
          msg = 'Unknown Error';
          console.log(e);
      }
      return console.log("Error: " + msg);
    };

    return FsJsonObject;

  })();

}).call(this);
