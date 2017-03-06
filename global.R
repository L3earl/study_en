options(java.parameters = "-Xmx16000m")

library(rvest)
library(rio)
library(KoNLP)
library(dplyr)
library(data.table)
library(gsubfn)
library(openNLP)
library(NLP)
library(shiny)

## 웹의 내용을 불러오는 경우
# 불러올 웹의 주소(URL)를 입력해 주세요. ex) https://www.nytimes.com/
url.1 <- 'https://www.nytimes.com/'

# 결과를 저장할 폴더 경로를 지정해 주세요. ex) /Users/earllee1/Google drive/output/광고로 영어공부/단어 크롤링&공부/output
output.folder <- 'output'

# 여기서부터는 입력 필요없이 실행하면 됩니다. 
filename.url <- gsub('/', '', substr(url.1, 1, 100), fixed = TRUE)

temp.text <- paste0('import("', output.folder, '/testSheet_', filename.url, '.xlsx")')
data.test <- eval(parse(text=temp.text))

# 필요한 폴더를 생성합니다. (이미 있으면 경고만 나오고 지나감)
dir.create(output.folder)
##


v <- reactiveValues(index = 1) # 일종의 loadHandler
k <- 1

print(paste(k, 'golbal'))
