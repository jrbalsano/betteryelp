####################################################################
# USE THIS FILE TO DEMONSTRATE HOW TO USE YOUR IMPLEMENTED CLASSES #
#                                                                  #
#          DO NOT INCLUDE IT IN THE FINAL PRODUCT                  #
####################################################################

####
# YelpList
####
# BackBone collection used to get results from the server. Has two types, 
# "term" and "category". Term means that the results in the list are from a
# keyword search. Category means that the results in the list are from a
# category search.

# To create a new YelpList, use the constructor
# The empty array is necessary to denote that there are no models being
# used to initialize it, otherwise the term or category would be interpreted
# as a model instead of an option.

myList = new LOAF.YelpList # List without a type
mySearch = new LOAF.YelpList [], term: "cookies" # List to search for cookies
myCategory = new LOAF.YelpList [], category: "active" # Category "active"

# To download results from yelp call

myList.fetch()

# To get the next page of results, call

myList.fetch(page: 2)

# You can see if your models downloaded properly by checking out

myList.models

# or

myList.size()

# DUE NOTE: If a model already exists in the collection, it will not be added
# twice. Ex:

#Assume all above has already occurred
myList.size() # returns 40
myList.fetch(page: 2)
myList.size() # still returns 40

#End YelpList
####

####
# FsJsonObject
####
# This is a custom object that handles writing JSON objects to the FileSystem.
# It also supports reading objects from the FileSystem using the HTML5
# FileSystem API. Because the FileSystem API is asynchronous, all calls to this
# object except for the get call are asynchronous.
#
# Start by writing something to the server. The FsJsonObject defaults to
# writing to the file "Breadcrumbs.txt"

myObject =
  a: 12
  b: 14
  c: 16

myJson = new LOAF.FsJsonObject
  read: false # since we are not reading an object, set this false
  # onReady is called once the browser has obtained permission to
  # write to the filesystem.
  onReady: (fsObject) ->
    console.log("Ready to go")
    # Now we can write an object.
    # The function passed as an argument here is called only if the object was
    # successfully written
    jsObject.writeObject myObject, ->
      console.log("Write success.")
      # Now let's try loading the results into a new FsJsonObject
      newJsonObject = new LOAF.FsJsonObject
        read: true # read defaults to true so this isn't really necessary
        onReady: (newFsObject) -> # Called once read is completed succesfully
          console.log fsObject.getObject()

# Ideally, we should never be reading and then writing so close to each other
# so we won't have all these nested callbacks. 
# Lastly, there are other options accessible for use when creating a new object
# Here they are explicitly used with their default values.

myJson = new LOAF.FsJsonObject
  read: true # Whether or not to read from the file
  size: 5120 # How many bytes to request from the browser
  fileName: "Breadcrumbs.txt" # The filename to write to/read from
  onReady: -> # The function to call once initialized.

# End FsJsonObject
####


####
# ListsList
####
# This is a custom object that can be used to contain all the lists a user has
# made or alternatively all of the lists that have been generated via searches.
# It supports three methods: initialization, adding list, removing list,
# and getting an array of the lists.
#
# To initialize

myList1 = new YelpList
myList2 = new YelpList
myList3 = new YelpList
myList4 = new YelpList
somelists = [myList1, myList2, myList3]
listsWrapper = newLOAF.Lists
  lists: somelists

# To add to the list

listsWrapper.addList myList4

# To remove from the list
listsWrapper.removeList myList2

# To get the lists
listsWrapper.getLists # -> [myList1, myList3, myList4]

# End of ListsList
####
