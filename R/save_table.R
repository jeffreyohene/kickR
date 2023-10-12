#' Save a DataFrame in Multiple Formats
#'
#' This function allows you to save a DataFrame in various formats such as
#' JSON, CSV, XLSX, and RDS.
#'
#' @name save_table
#'
#' @param df The DataFrame to be saved.
#' @param filename The name (excluding file extension) for the saved file.
#' @param format A character vector specifying the formats to save the DataFrame in. The available options are "json", "csv", "xlsx", and "rds".
#'
#' @return This function saves the DataFrame in the specified formats.
#'
#' @importFrom jsonlite write_json
#' @importFrom openxlsx write.xlsx
#' @importFrom utils write.csv
#'
#' @export
#'
# Install and load jsonlite for JSON format
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}

# Install and load openxlsx for XLSX and XLS formats
if (!requireNamespace("openxlsx", quietly = TRUE)) {
  install.packages("openxlsx")
}

save_table <- function(df, filename, format = c("json", "csv", "xlsx", "rds")) {
  format <- tolower(format)

  if ("json" %in% format) {
    jsonlite::write_json(df, file = paste0(filename, ".json"))
    cat("Table saved as '", paste0(filename, ".json"), "'\n")
  }

  if ("csv" %in% format) {
    utils::write.csv(df, file = paste0(filename, ".csv"), row.names = FALSE)
    cat("Table saved as '", paste0(filename, ".csv"), "'\n")
  }

  if ("xlsx" %in% format) {
    openxlsx::write.xlsx(df, paste0(filename, ".xlsx"))
    cat("Table saved as '", paste0(filename, ".xlsx"), "'\n")
  }

  if ("rds" %in% format) {
    saveRDS(df, paste0(filename, ".rds"))
    cat("Table saved as '", paste0(filename, ".rds"), "'\n")
  }
}
