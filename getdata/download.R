downloadAndRead <- function(url, file, ...) {
  if (!file.exists(file)) {
    download.file(url, file, method="curl")
  }
  
  extension = substr(file, nchar(file) - 3, nchar(file))
  
  if (extension == ".csv") {
    read.csv(file, ...)
  } else if (extension == ".xml") {
    library("XML")
    xmlParse(file, ...)
  } else if (extension == "html" | extension == ".htm") {
    library("XML")
    htmlParse(file, ...)
  } else if (extension == ".jpg" | extension == "jpeg") {
    library("jpeg")
    jpeg::readJPEG(file, ...)
  }
}