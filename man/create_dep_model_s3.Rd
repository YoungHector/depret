\name{create_dep_model_s3}
\alias{create_dep_model_s3}
\title{create a s3 model for depret, compatible with packages such as iml.}
\usage{
create_dep_model_s3(base_src)
}
\description{
returns a model with predict func.
}
\examples{
new_model = create_dep_model_s3(base_src)
predictor = Predictor$new(new_model, data = iris[,1:4], y = iris$Species)
...
}
