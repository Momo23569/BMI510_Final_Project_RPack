# Ensure libraries are installed and loaded outside of the function
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(dplyr)
library(ggplot2)

#' Calculate and Plot a Survival Curve
#'
#' This function takes a numerical vector `status` indicating event occurrence
#' (1 for event, 0 for censored) and a numerical vector `time` indicating the
#' time to event or censoring, then calculates and plots the survival curve using
#' a non-parametric estimator.
#'
#' @param status Numerical vector of event occurrences (1 = event, 0 for censored).
#' @param time Numerical vector of times to event or censoring.
#' @return Plot of the survival curve.
#' @importFrom ggplot2 ggplot geom_step labs
#' @importFrom dplyr data_frame arrange group_by summarise mutate
#' @examples
#' survCurv(c(1, 0, 1, 0, 1), c(5, 8, 12, 15, 20))
#' @export
survCurv <- function(status, time) {
  # Combine status and time into a data frame
  data <- data.frame(status = status, time = time)

  # Sort data by time
  data <- data %>% arrange(time)

  # Calculate number of events and censored cases at each time point
  survival_data <- data %>%
    group_by(time) %>%
    summarise(n_events = sum(status == 1),
              n_censored = sum(status == 0),
              .groups = 'drop')  # Ensure groups are dropped after summarisation

  # Calculate survival probabilities
  survival_data <- survival_data %>%
    mutate(surv_prob = cumprod(1 - n_events / sum(n_events + n_censored)))

  # Plot the survival curve
  ggplot(survival_data, aes(x = time, y = surv_prob)) +
    geom_step() +
    labs(title = "Survival Curve",
         x = "Time",
         y = "Survival Probability")
}


#' #' Calculate and plot a survival curve S(t)
#' #'
#' #' This function takes a numerical vector `status` indicating event occurrence
#' #' (1 for event, 0 for censored) and a numerical vector `time` indicating the
#' #' time to event or censoring. It then calculates and plots the survival curve.
#' #' @name survCurv
#' #' @param status Numerical vector of event occurrences (1 = event, 0 = censored)
#' #' @param time Numerical vector of times to event or censoring
#' #' @return Plot of the survival curve
#' #' @examples
#' #' survCurv(c(1, 0, 1, 0, 1), c(5, 8, 12, 15, 20))
#' #' @export
#' library(dplyr)
#' library(ggplot2)
#' survCurv <- function(status, time) {
#'   # Combine status and time into a data frame
#'   data <- data.frame(status = status, time = time)
#'
#'   # Sort data by time
#'   data <- data %>% arrange(time)
#'
#'   # Calculate number of events and censored cases at each time point
#'   survival_data <- data %>%
#'     group_by(time) %>%
#'     summarise(n_events = sum(status == 1),
#'               n_censored = sum(status == 0))
#'
#'   # Calculate survival probabilities
#'   survival_data <- survival_data %>%
#'     mutate(surv_prob = cumprod(1 - n_events / sum(n_events + n_censored)))
#'
#'   # Plot the survival curve
#'   ggplot(survival_data, aes(x = time, y = surv_prob)) +
#'     geom_step() +
#'     labs(title = "Survival Curve",
#'          x = "Time",
#'          y = "Survival Probability")
#' }
#'

# # Example usage
# status <- c(1, 0, 1, 0, 1)
# time <- c(5, 8, 12, 15, 20)
# survCurv(status, time)
#
#
#
# # URL for the dataset
# url <- "https://jlucasmckay.bmi.emory.edu/global/bmi510/Labs-Materials/survival.csv"
#
#
#
#
# # Read the CSV file directly from the URL
# survival_data <- read.csv(url)
# print(head(survival_data))
# # Check the first few rows of the dataset
# head(survival_data)
#
# # Check the structure of the dataset to understand the column names and types
# str(survival_data)
#
# # Extract the status and time columns
# # Replace 'status_column_name' and 'time_column_name' with the actual column names from the dataset
# status <- survival_data$status
# time <- survival_data$time
# # Call the survCurv function
# survCurv(status, time)



# # Sample data
# status <- c(1, 0, 1, 0, 1)
# time <- c(5, 8, 12, 15, 20)
#
# # Call the function
# survCurv(status, time)
