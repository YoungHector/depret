#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

# Use R code to connect deployed machine-learning model or api.
# depret -- Deployed-model interpretion.
library('httr')

DepretClass = setRefClass(
  'depretclass',

  fields = list(
    # src url.
    base_src = 'ANY',
    # Feature data(not raw) is required in some interpreting methods.
    data = 'ANY'
  ),

  methods = list(

    initialize = function(base_src = '127.0.0.1:5000'){

      base_src <<- base_src
    },

    blackbox_post = function(query){

      resp <- POST(base_src, body=list(query = query), encode="json")
      unlist(content(resp, as = "parsed"))
    },

    predict = function(input = NULL){

      features = lapply(names(input), function(x) input[[x]])
      names(features) = names(input)
      # str(features)
      blackbox_post(features)

    }
  )
)
