
shinyServer(
    function(input, output) {
      
      # v <- reactiveValues(index = 1) # 일종의 loadHandler
      
      observeEvent(input$nextBtn, {
        #v$index <- v$index + 1
        k <<- k + 1
        print(paste(k, '<<-'))
      })
      
      observeEvent(input$backwordBtn, {
        #v$index <- v$index - 1 
        k <- k - 1
        print(paste(k, '<-'))
        
      })
      
      output$word <- renderText({ 
        #data.words[v$index, 1]
        #v$index
      })
      
      output$meaning <- renderText({ 
        #words.length <- length(data.words[v$index,]) - sum(is.na(data.words[v$index,]))
        #paste(data.words[v$index, c(2:words.length)])
      })
    }
)


