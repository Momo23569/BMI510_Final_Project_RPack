#' Calculate the parameter p that maximizes the log-likelihood for Bernoulli distributed data
#'
#' This function performs a grid-based search across possible values of p (from 0 to 1, in steps of 0.001)
#' to find the value that maximizes the log-likelihood of observing the given data assuming a Bernoulli distribution.


#' @param data A vector of 0s and 1s.
#' @return The value of p that maximizes the log-likelihood.
#' @examples
#' logLikBernoulli(c(1, 0, 0, 0, 1, 1, 1))
#' @export
logLikBernoulli <- function(data) {
  likelihood <- function(p, data) {
    sum(dbinom(data, size = 1, prob = p, log = TRUE))
  }

  # Define a grid of p values
  p_grid <- seq(0, 1, by = 0.001)

  # Calculate log-likelihood for each p in the grid
  log_likes <- sapply(p_grid, likelihood, data = data)

  # Find the p that maximizes the log likelihood
  best_p <- p_grid[which.max(log_likes)]
  return(best_p)
}
