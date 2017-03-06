### 데이터 전처리 과정

## 웹의 내용을 불러오는 경우
# 해당 url의 텍스트를 가져와 영문, 띄어쓰기를 빼고 삭제
url.2 <- url.1 %>% read_html() %>% html_text() %>% tolower()
url.3 <- gsub('[^a-z ]', ' ', url.2)
raw.data.words <- gsub('\\', ' ', url.3, fixed = TRUE)
##


## PC 내에 있는 데이터를 불러와 사용하는 경우, 소문자 변환, 띄어쓰기와 영문을 뺀 나머지 삭제 (- 같은 것을 삭제하였기 때문에, 몇몇 단어들은 뜻을 정확히 전달 못 할 수 있음)
if(FALSE){
raw.data.list <- dir(list.dirs(), pattern = 'en.txt', full.names = TRUE)

temp.data <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table) %>% 
            unlist(use.names =FALSE) %>%  tolower()

temp.data2 <- gsub('[^a-z ]', '', temp.data)
raw.data.words <- gsub('\\', '', temp.data2, fixed = TRUE)
}
##

  
## 데이터를 word 단위로 자르고, 품사 Tag를 붙힘. openNLP 패키지의 example 사용
s <- as.String(raw.data.words)

# Need sentence and word token annotations.
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
a2 <- annotate(s, list(sent_token_annotator, word_token_annotator))

pos_tag_annotator <- Maxent_POS_Tag_Annotator()
a3 <- annotate(s, pos_tag_annotator, a2)

# Determine the distribution of POS tags for word tokens.
a3w <- subset(a3, type == "word")
tags <- sapply(a3w$features, `[[`, "POS")

# 뭔지 모르는 내용, 나중에 힌트 얻을 때 실행시켜보면 좋을 듯 하다
if(FALSE){
# Extract token/POS pairs (all of them): easy.
test3 <- sprintf("%s/%s", s[a3w], tags)

# Extract pairs of word tokens and POS tags for second sentence:
a3ws2 <- annotations_in_spans(subset(a3, type == "word"),
                              subset(a3, type == "sentence")[2L])[[1L]]
a3ws3 <- sprintf("%s/%s", s[a3ws2], sapply(a3ws2$features, `[[`, "POS"))
}
##


## 어떤 품사로 구분된 단어를 쓸지 확인
if(FALSE){
gw <- 'NN'
t5 <- s[a3w[which(tags == gw)]] 
unique(t5)
table(tags)
}
##


## 단어장에 필요한 태그가 붙은 단어만 따로 뽑아내고, 3글자 이상의 단어만 뽑아내어, 빈도순으로 정렬, data.frame 형식
tag.words <- s[a3w[which(tags == 'IN' | tags == 'JJ' | tags == 'JJR' | tags == 'JJS'
                         | tags == 'NN' | tags == 'NNP' | tags == 'NNPS' | tags == 'NNS'
                         | tags == 'RB' | tags == 'VB' | tags == 'VBP' | tags == 'VBZ')]]

temp.tw <- as.data.frame(tag.words[nchar(tag.words) >= 3])
colnames(temp.tw) <- 'words'
temp.tw$num <- 1

temp.tw2 <- aggregate(num ~ words, temp.tw, sum)
words.frequency <- arrange(temp.tw2, desc(num))
##


## 
temp.text <- paste0('export(words.frequency, "', output.folder, '/words.frequency_', filename.url, '.xlsx")')
eval(parse(text=temp.text))


## 추가로 할 수 있는 전처리
# s, es, os 로 끝나는 단어 찾아서 해당 문자 제거 후, 같은 단어가 있는지 확인, 있다면 해당 단어들에서 s들 삭제
# ves -> f/fe, ies -> y, es -> rm, s -> rm



