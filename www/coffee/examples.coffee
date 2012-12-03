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
###
