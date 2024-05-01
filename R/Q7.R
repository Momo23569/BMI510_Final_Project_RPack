library(httr)
library(readr)
library(dplyr)

#' Download a report from RedCap
#'
#' Retrieves a RedCap report using the RedCap API, with parameters specified by the user.
#' The API token is fetched from the user's environment using Sys.getenv().
#' @param redcapTokenName The name of the environment variable storing the RedCap API token.
#' @param redcapUrl The URL of the RedCap API endpoint.
#' @param redcapReportId The ID of the RedCap report to be retrieved.
#' @return A tibble containing the data from the RedCap report.
#' @examples
#' # Make sure to set your environment variable before using this example
#' # Sys.setenv(REDCAP_TOKEN = "your_actual_token_here")
#' downloadRedcapReport("REDCAP_TOKEN", "https://redcap.yourinstitution.edu/api/", "12345")
#' @export
downloadRedcapReport <- function(redcapTokenName, redcapUrl, redcapReportId) {
  # Fetch the API token from environment
  token <- Sys.getenv(redcapTokenName)
  if (token == "") {
    stop("API token not found in environment. Please set the token in .REnviron.")
  }
  
  # Define the data to be sent in the POST request
  formData <- list(
    token = token,
    content = 'report',
    format = 'csv',
    report_id = redcapReportId,
    csvDelimiter = ',',
    rawOrLabel = 'raw',
    rawOrLabelHeaders = 'raw',
    exportCheckboxLabel = 'false',
    returnFormat = 'csv'
  )
  
  # Make the POST request
  response <- POST(redcapUrl, body = formData, encode = "form")
  
  # Check if the request was successful
  if (response$status_code != 200) {
    stop("Failed to download report. Status code: ", response$status_code)
  }
  
  # Read the content of the response as text
  content <- content(response, "text")
  
  # Convert CSV content to a tibble
  tibble_data <- read_csv(content)
  
  return(tibble_data)
}
