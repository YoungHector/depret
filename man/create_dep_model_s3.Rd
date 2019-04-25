\name{create_dep_model_s3}
\alias{create_dep_model_s3}
\title{S3 Deployed ML Model}
\usage{
create_dep_model_s3(base_src)
}
\description{
This function returns a model with predict function, compatible with packages such as iml.
}
\examples{
new_model = create_dep_model_s3(base_src)
predictor = Predictor$new(new_model, data = iris[,1:4], y = iris$Species)
...
}
