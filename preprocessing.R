test <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table)
str(test)
tt2 <- unlist(test, use.names = FALSE)
str(tt2)
tt2[1]
tt3 <- tolower(tt2)
str(tt3)
sum(nchar(tt3[c(4200:4300)]))
sum(nchar(tt3[c(4800:4900)]))
sum(nchar(tt3[c(4900:5000)]))

test <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table) 
sum(nchar(unlist(test)))
test <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table) %>% rbindlist() 
sum(nchar(unlist(test)))
test <- raw.data.list %>% lapply(readLines) %>% lapply(as.data.table) %>% rbindlist() %>% tolower()
sum(nchar(test))

tt4 <- gsub('[^a-z ]', '', tt3)
str(tt4)

## Some text.
system.time({
s <- tt4

s <- as.String(s)

## Need sentence and word token annotations.
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
a2 <- annotate(s, list(sent_token_annotator, word_token_annotator))

pos_tag_annotator <- Maxent_POS_Tag_Annotator()
pos_tag_annotator
a3 <- annotate(s, pos_tag_annotator, a2)
a3
## Variant with POS tag probabilities as (additional) features.
head(annotate(s, Maxent_POS_Tag_Annotator(probs = TRUE), a2))

## Determine the distribution of POS tags for word tokens.
a3w <- subset(a3, type == "word")
tags <- sapply(a3w$features, `[[`, "POS")
tags
table(tags)
## Extract token/POS pairs (all of them): easy.
test3 <- sprintf("%s/%s", s[a3w], tags)

## Extract pairs of word tokens and POS tags for second sentence:
a3ws2 <- annotations_in_spans(subset(a3, type == "word"),
                              subset(a3, type == "sentence")[2L])[[1L]]
sprintf("%s/%s", s[a3ws2], sapply(a3ws2$features, `[[`, "POS"))
})

head(a3w)
test2 <- subset(a3, features == 'POS')
head(test2)
str(test2)
test2
?sapply
a3$features

test4 <- strsplit(test3,"/")

str(test3)

table(tags)
t5 <- s[a3w[which(tags == c('JJ'))]]
tdw <- unique(s[a3w])
str(tdw)
head(tdw)
table(tdw)
