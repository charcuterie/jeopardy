remove_nas <- function(df) {
  df[!is.na(df)]
}

get_categories <- function(page) {
    page %>%
    html_nodes("td[class=category_name]") %>%
    html_text()
}

get_rounds <- function(page) {
    page %>%
    html_nodes("div") %>%
    html_attr("onmouseover") %>%
    remove_nas() %>%
    str_extract("[A-Z]+")
}

get_coords <- function(page) {
    page %>%
    html_nodes("div") %>%
    html_attr("onmouseover") %>%
    remove_nas() %>%
    str_extract("\\d_\\d")
}

get_columns <- function(page) {
    page %>%
    get_coords() %>%
    substring(1, 1)
}

get_rows <- function(page) {
    page %>%
    get_coords() %>%
    substring(3, 3)
}

get_clues <- function(page) {
    page %>%
    html_nodes("div") %>%
    html_attr("onmouseout") %>%
    remove_nas() %>%
    str_match("stuck', '(.*)'\\)") %>%
    extract(, 2)
}

get_responses <- function(page) {
    page %>%
    html_nodes("div") %>%
    html_attr("onmouseover") %>%
    remove_nas() %>%
    str_match("correct_response\">(.*)</em>") %>%
    extract(, 2)
}

get_dates <- function(page) {
    page %>%
    html_nodes("head") %>%
    html_text() %>%
    str_extract("[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]") %>%
    as.Date
}