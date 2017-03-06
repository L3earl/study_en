
shinyUI(fluidPage(

  titlePanel("영단어 반복학습"),
  hr(),
  
  fluidRow(
    column(3,
           textOutput('word'),
           data.words[k,1]
    ),
    
    column(3,
           p(textOutput('meaning'))
    ),
    
    column(1,
           actionButton("nextBtn", label = "다음")
    ),
    
    column(1,
           actionButton("backwordBtn", label = "뒤로")
    )
  )
  
))

print(paste(k, 'ui'))