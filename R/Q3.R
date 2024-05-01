#' Unscale Function
#'
#' This function reverses the centering and scaling applied to a vector,
#' either by using provided center and scale values or by retrieving
#' the original values if the vector was scaled with R's scale() function.
#'
#' @param x Numeric vector to unscale.
#' @param center Numeric scalar indicating the centering factor (optional).
#' @param scale Numeric scalar indicating the scaling factor (optional).
#' @return Numeric vector with centering and scaling reversed.
#' @export
#' @examples
#' unscale(c(1, 2, 3), center = 2, scale = 1.5)
unscale <- function(x, center = NULL, scale = NULL) {
  # Use attribute values if center and scale are not provided
  if (is.null(center)) center <- attr(x, "scaled:center")
  if (is.null(scale)) scale <- attr(x, "scaled:scale")

  # Apply reverse transformations if parameters are available
  if (!is.null(center)) {
    if (length(center) == 1) {
      x <- x + center
    } else {
      stop("Length of 'center' must be 1")
    }
  }

  if (!is.null(scale)) {
    if (length(scale) == 1) {
      x <- x * scale
    } else {
      stop("Length of 'scale' must be 1")
    }
  }

  return(x)
}
