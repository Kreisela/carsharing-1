## Directory festlegen
setwd("C:/Users/Martin/Documents/Workaholic/TUD_Verkehr/Rohdaten/floating/2016/drivenow/")
## Liste mit csv-Dateien erstellen
filenames <- list.files(pattern = "\\.csv$") 

## new Filenames
file_new <- paste("utf/", filenames, sep="")

for (i in 1:length(filenames)){
  ffcs <- read.table(filenames[i],
                     sep=",",
                     dec=".",
                     header = FALSE,
                     na.strings=c("NA","null","null, null",", null"," ","","0,0","0.000000","0.000000, 0.000000", "False", "True"),
                     quote = "\"",
                     fileEncoding= "utf8")
  
  # Convert date/time format
  ffcs$V1 <- strptime(ffcs$V1, format = "%Y-%m-%d_%H-%M")
  ffcs$V2 <- strptime(ffcs$V2, format = "%Y-%m-%d_%H-%M")
  
  #Convert fuelstatus to percent
  ffcs$V10 <- ffcs$V10*100
  ffcs$V11 <- ffcs$V11*100
  
  # Remove last column with distance
  ffcs$V21 <- NULL
  ffcs$V15 <- NULL
  
  ## Disable exponential notation
  options(scipen=15) 
  
  write.table(ffcs,file = file_new[i],
              fileEncoding= "utf8",
              quote=FALSE,
              row.names=FALSE,
              col.names = FALSE,
              sep = ";",
              dec = ".") 
}

