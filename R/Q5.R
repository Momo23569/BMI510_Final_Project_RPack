#' Standardize Variable Names in a Tibble
#'
#' This function standardizes the variable names in a tibble or dataframe by first cleaning the names using
#' janitor::make_clean_names and then converting them to "small camel" case using snakecase::to_small_camel_case.
#'
#' @param data A tibble or dataframe whose variable names you want to standardize.
#' @return A tibble or dataframe with standardized variable names.
#' @importFrom janitor make_clean_names
#' @importFrom snakecase to_any_case
#' @export
#' @examples
#' library(tibble)
#' data <- tibble(`First name` = c("John", "Jane"), `Last name` = c("Doe", "Doe"), `AGE (years)` = c(28, 22))
#' standardized_data <- standardizeNames(data)
#' print(standardized_data)
standardizeNames <- function(data, case_type = "lower_camel") {
  # Check if data is a dataframe/tibble
  if (!is.data.frame(data)) {
    stop("Input must be a dataframe or tibble.")
  }

  # Clean names using janitor
  clean_names <- janitor::make_clean_names(names(data))

  # Convert to specified case using snakecase
  converted_names <- snakecase::to_any_case(clean_names, case = case_type)

  # Rename the variables in the data
  data <- dplyr::rename_with(data, .fn = ~ converted_names)

  return(data)
}
