

```markdown
# BMI510_Final_Project_RPack

`BMI510_Final_Project_RPack` is a collection of R functions designed to assist in statistical analysis and data manipulation, particularly useful for researchers and data scientists. This package includes functions for calculating log likelihoods, generating survival curves, unscale standardized data, principal component analysis, standardizing variable names, calculating minimum sample sizes for statistical tests, and interacting with RedCap API for data reports.

## Installation

Install the development version of `BMI510_Final_Project_RPack` from GitHub:

```r
setwd("your install path/bmi510")
devtools::document()
devtools::install(".")
```

## Functions

### `logLikBernoulli`

Calculate the parameter p that maximizes the log-likelihood for Bernoulli distributed data.

```r
logLikBernoulli(data)
```

### `survCurv`

Calculate and plot a survival curve using non-parametric estimation.

```r
survCurv(status, time)
```

### `unscale`

Reverse the centering and scaling applied to a vector.

```r
unscale(x, center, scale)
```

### `pcApprox`

Approximate data based on the number of principal components.

```r
pcApprox(x, npc)
```

### `standardizeNames`

Standardize variable names in a dataframe to small camel case.

```r
standardizeNames(data)
```

### `minimumN`

Calculate minimum sample size for a two-sample t-test to achieve 80% power.

```r
minimumN(x1, x2)
```

### `downloadRedcapReport`

Download a report from RedCap using the RedCap API.

```r
downloadRedcapReport(redcapTokenName, redcapUrl, redcapReportId)
```

## Usage

Here are some examples of how to use the functions in the package:

## Usage

Here are some examples of how to use the functions in the package:

```r
# Example for logLikBernoulli
# Calculate the maximum log-likelihood p value for given Bernoulli data
logLikBernoulli(c(1, 0, 0, 0, 1, 1, 1))

# Example for survCurv
# Calculate and plot a survival curve
survCurv(c(1, 0, 1, 0, 1), c(5, 8, 12, 15, 20))

# Example for unscale
# Reverse scaling and centering applied to a vector
unscale(c(1, 2, 3), center = 2, scale = 1.5)

# Example for pcApprox
# Approximate data matrix using principal components
data(mtcars)
approx_data <- pcApprox(mtcars, 2)
print(approx_data)

# Example for standardizeNames
# Standardize variable names in a data frame
library(tibble)
data <- tibble(`First name` = c("John", "Jane"), `Last name` = c("Doe", "Doe"), `AGE (years)` = c(28, 22))
standardized_data <- standardizeNames(data)
print(standardized_data)

# Example for minimumN
# Calculate minimum sample sizes needed for statistical power in a t-test
sample1 <- rnorm(20, mean = 10, sd = 2)
sample2 <- rnorm(20, mean = 12, sd = 2)
minimumN(sample1, sample2)

# Example for downloadRedcapReport
# Download a report from RedCap
# Ensure your RedCap API token is set in the environment before using this example
Sys.setenv(REDCAP_TOKEN = "your_actual_token_here")
downloadRedcapReport("REDCAP_TOKEN", "https://redcap.yourinstitution.edu/api/", "12345")


