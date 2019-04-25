#   http://r-pkgs.had.co.nz/

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

# for Ref Class.
create_dep_model_rc = function(base_src = '127.0.0.1:5000'){
  return(DepretClass$new(base_src))
}


# for s3 class
create_dep_model_s3 <- function(base_src = '127.0.0.1:5000') {

  value <- list(base_src = base_src)
  # class can be set using class() or attr() function
  attr(value, "class") <- "depretclass_s3"
  value
}

blackbox_post = function(obj, query){
  # str(obj)
  resp <- POST(obj$base_src, body=list(query = query), encode="json")
  unlist(content(resp, as = "parsed"))
}

predict.depretclass_s3 = function(obj, input = NULL){
  features = lapply(names(input), function(x) input[[x]])
  names(features) = names(input)
  # str(features)
  blackbox_post(obj, features)
}

