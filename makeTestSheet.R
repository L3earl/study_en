### 전처리 된 단어들의 뜻과 예문을 네이버 사전에서 스크래핑하여, data.frame 형태로 엑셀로 저장

## 전처리 된 단어를 불러옴
temp.text <- paste0('import("', output.folder, '/words.frequency_', filename.url, '.xlsx")')
data.words <- eval(parse(text=temp.text))

## 불러온 단어를 1번부터 온라인 사전에 넣고, 뜻을 긁어와 list (vectors) 로 만든 후, 합쳐서 데이터 프레임으로 만듬
data.words.1 <- as.data.frame(data.words[,1], stringsAsFactors = FALSE)

meaning.data <- function(x){
  url <- paste0('http://dic.daum.net/search.do?q=' , x, '&dic=eng&search_first=Y')
  temp.html <- read_html(url) 
  
  error.1 <- html_nodes(temp.html, ".tit_speller")
  if(length(error.1) != 0){
    return(NA)
  }
  
  temp.txt <- html_nodes(temp.html, ".search_box .cleanword_type .txt_search")
  
  if(length(temp.txt) == 0){
    return(NA)
  }
  
  meanings <- html_text(temp.txt)
  
  result <- append(x, meanings, after = 2)
  return(result)
}

# 함수 실행
temp.list <- apply(as.data.frame(data.words.1[,1]), 1, meaning.data)  

# 함수 결과인 리스트를 합쳐서 데이터 프레임으로 만듬
foo <- 10
temp.dtfm <- t(sapply(temp.list, '[', 1:foo))
colnames(temp.dtfm) <- c(1:ncol(temp.dtfm))
  
words.meaning <- temp.dtfm[(!(is.na(temp.dtfm[,1])) & grepl('[^a-zA-Z]', temp.dtfm[,2])), ]
  
temp.text <- paste0('export(words.meaning, "', output.folder, '/testSheet_', filename.url, '.xlsx")')
eval(parse(text=temp.text))
##
