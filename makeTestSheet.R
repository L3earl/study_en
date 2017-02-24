
### 데이터 전처리
## raw 데이터를 가공하여 3글자 이상이며, 특수기호/숫자가 안 들어간 단어만 뽑아서 정렬
raw.data.list <- dir(list.dirs(), pattern = 'en.txt', full.names = TRUE)

d1 <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table) %>% rbindlist() %>% tolower() %>% extractNoun() 

d2 <- gsub('[^a-z]', '', d1)
d3 <- as.data.frame(d2[nchar(d2) >= 3])
colnames(d3) <- 'words'
d3$num <- 1

d4 <- aggregate(num ~ words, d3, sum)
data.words <- arrange(d4, desc(num))

### 전처리 끝


### 단어장에 들어갈 내용들을 네이버 사전을 통해 수집
## 같은 단어인지 확인함 (acase sensitive)

## 품사를 확인함


## 해당 단어의 URL에서 상세 URL을 찾아내서 접속
tc <- 'function'
tc

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