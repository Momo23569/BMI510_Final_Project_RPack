#' Principal Component Approximation of Data
#'
#' This function returns an approximation of the data matrix `x` based on the number of principal
#' components specified by `npc`. The approximation will be rescaled and recentered to match the
#' original data's scale and center.
#'
#' @param x A numeric matrix or data frame where rows are observations and columns are variables.
#' @param npc The number of principal components to use for the approximation.
#' @return A numeric matrix of the same dimensions as `x`, approximated using the first `npc` principal components.
#' @export
#' @examples
#' data(mtcars)
#' approx_data <- pcApprox(mtcars, 2)
#' print(approx_data)
pcApprox <- function(x, npc) {
  # Check if input data is a matrix, if not, convert it
  if (!is.matrix(x)) {
    x <- as.matrix(x)
  }

  # Perform scaling: center and scale
  mx <- scale(x) # mean centering and scaling
  mean_x <- attr(mx, "scaled:center")
  std_x <- attr(mx, "scaled:scale")

  # PCA using svd (singular value decomposition)
  svd_x <- svd(mx)
  d <- svd_x$d
  u <- svd_x$u
  v <- svd_x$v

  # Keep only the first npc components
  d[npc + 1:length(d)] <- 0

  # Reconstruct the matrix with reduced components
  approx <- u %*% diag(d) %*% t(v)

  # Rescale and recenter to original scale
  approx <- sweep(approx, 2, std_x, `*`)  # rescale
  approx <- sweep(approx, 2, mean_x, `+`)  # recenter

  return(approx)
}
