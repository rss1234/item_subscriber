find_picotin <- function(links) {
  
  picotin <- "https://www.hermes.com/us/en/product/picotin-lock"
  # picotin <- "https://www.hermes.com/us/en/product/chaine"  //chaine包可用作本程序测试
  
  result <- NA_character_
  
  if(any(grepl(picotin, links))) {
    result <- paste("We have picotin! Link: ", 
                    paste(links[grepl(picotin, links)], collapse = " \r "),
                    collapse = " \r ")
  }
  
  return(result)
  
}