#' Calculate Minimum Sample Size for a Two-Sample t-Test
#'
#' This function calculates the minimum sample size needed to achieve 80% power at a significance level of 0.05 for a two-sample t-test.
#' It uses the `pwr::pwr.t2n.test` function and can handle one or two samples of preliminary data.
#'
#' @param x1 A numeric vector containing the first sample of preliminary data.
#' @param x2 An optional numeric vector containing the second sample of preliminary data. If not provided, a one-sample t-test scenario is assumed.
#' @return A list containing the computed minimum sample sizes for each group.
#' @importFrom pwr pwr.t2n.test
#' @export
#' @examples
#' sample1 <- rnorm(20, mean = 10, sd = 2)
#' sample2 <- rnorm(20, mean = 12, sd = 2)
#' minimumN(sample1, sample2)
minimumN <- function(x1, x2 = NULL) {
  if (!is.null(x2)) {
    # Calculate effect size for two samples
    n1 <- length(x1)
    n2 <- length(x2)
    s1 <- sd(x1)
    s2 <- sd(x2)
    mean1 <- mean(x1)
    mean2 <- mean(x2)
    
    # Compute pooled standard deviation
    sp <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2) / (n1 + n2 - 2))
    
    # Effect size (Cohen's d)
    d <- (mean1 - mean2) / sp
  } else {
    # Calculate effect size for one sample against a hypothetical mean (e.g., 0 or a specific target)
    n1 <- length(x1)
    s1 <- sd(x1)
    mean1 <- mean(x1)
    hypothesized_mean <- 0  # Modify as needed based on specific use-case
    
    # Effect size (Cohen's d for one sample)
    d <- (mean1 - hypothesized_mean) / s1
  }
  
  # Calculate power for t-test
  power_analysis <- pwr::pwr.t.test(d = d, sig.level = 0.05, power = 0.80, type = if (is.null(x2)) "one.sample" else "two.sample")
  
  # Return the minimum sample size required
  return(list(n = ceiling(power_analysis$n)))
}
