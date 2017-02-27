### 전처리 된 단어들의 뜻과 예문을 네이버 사전에서 스크래핑하여, data.frame 형태로 엑셀로 저장
## 같은 단어인지 확인함 (acase sensitive)

## 품사를 확인함


## 해당 단어의 URL에서 상세 URL을 찾아내서 접속
meaning.data <- function(x){
  main.url <- paste0('http://endic.naver.com/search.nhn?sLn=kr&searchOption=all&query=' , x)
  main.html <- read_html(main.url)
  
  temp <- html_nodes(main.html, "body .word_num .list_e2 .first span a")[1]
  
  temp2 <- strapplyc(as.character(temp), paste0('(/.*query=', x, ')'), simplify = TRUE)
  words.url <- paste0('http://endic.naver.com', temp2)
  words.html <- read_html(words.url)
  temp3 <- html_nodes(words.html, '.list_a3 .meanClass .align_line')
  temp4 <- strapplyc(as.character(temp3), paste0('(<span class="fnt_k.*</span>)\r'), simplify = TRUE)
  temp5 <- gsub('\\[',',', temp4)
  result <- gsub('[^가-힣(),]', '', temp5)
  
  return(result)
}

meaning.data('function')

test <- apply(as.data.frame(data.words[,1]), 1, meaning.data)



test <- 'function'
tc<- 'piece'

url <- paste0('http://endic.naver.com/search.nhn?sLn=kr&searchOption=all&query=' , tc)
test <- read_html(url) 

test2 <- html_nodes(test, "body .word_num .list_e2 .first span a")[1]
head(test2)
test2

t3 <- strapplyc(as.character(test2), paste0('(/.*query=', tc, ')'), simplify = TRUE)
url2 <- paste0('http://endic.naver.com', t3)
t4 <- read_html(url2)
t5 <- html_nodes(t4, '.list_a3 .meanClass .align_line')
t5


ddt <- html_text(t5)
kkng <- gsub('\\t ', '/', ddt)
kkn2 <- gsub('[[:cntrl:]]', '', kkng)
qq<- gsub('[" ]', '', kkn2)
qq2 <- gsub('/', ' ', qq)
qq3 <- gsub('예문닫기', '', qq2)
qq4 <- gsub('^ {1}', '', qq3)
qq5 <- gsub(' ${1}', '', qq4)

#############
td<- 'method'

url <- paste0('http://dic.daum.net/search.do?q=' , td, '&dic=eng&search_first=Y')
test <- read_html(url) 

test2 <- html_nodes(test, ".search_box .cleanword_type .txt_search")
head(test2)
test2

html_text(test2)

t3 <- strapplyc(as.character(test2), paste0('(/.*query=', tc, ')'), simplify = TRUE)
url2 <- paste0('http://endic.naver.com', t3)
t4 <- read_html(url2)
t5 <- html_nodes(t4, '.list_a3 .meanClass .align_line')
t5


ddt <- html_text(t5)
kkng <- gsub('\\t ', '/', ddt)
kkn2 <- gsub('[[:cntrl:]]', '', kkng)
qq<- gsub('[" ]', '', kkn2)
qq2 <- gsub('/', ' ', qq)
qq3 <- gsub('예문닫기', '', qq2)
qq4 <- gsub('^ {1}', '', qq3)
qq5 <- gsub(' ${1}', '', qq4)

############

ddt2 <- gsub('[[:cntrl:]]', '', ddt)



t6 <- strapplyc(as.character(t5), paste0('(<span class="fnt_k.*</span>)\r'), simplify = TRUE)
t6

t7 <- gsub('\\[',',', t6)
t7

t8 <- gsub('[^가-힣(),]', '', t7)
t8

#내가 수집하길 원하는 페이지 주소 
url <- "http://endic.naver.com/search.nhn?sLn=kr&query=game&searchOption=entry_idiom" 
mainPage <- read_html(url) #해당 url 페이지의 html tag를 가져와서 parsing함.

#parsing한 데이터 에서 css가 '' 인 것을 찾아라.
pageInfo <- html_nodes(mainPage, "body p .fnt_k05")

head(pageInfo)
str(pageInfo)

pageInfo %>% html_text()



#rm(list = ls(all = TRUE))
gc()

rnorm
?rnorm
help.search('rnorm')
args('rnorm')
help.search('NLP')
