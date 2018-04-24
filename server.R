#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny); library(stringr); library(tm)
print(getwd())
bg <- readRDS("bigram.RData"); tg <- readRDS("trigram.RData"); 
names(bg)[names(bg) == 'word1'] <- 'w1'; names(bg)[names(bg) == 'word2'] <- 'w2';
names(tg)[names(tg) == 'word1'] <- 'w1'; names(tg)[names(tg) == 'word2'] <- 'w2'; names(tg)[names(tg) == 'word3'] <- 'w3';
message <- "" ## cleaning message

## Function predicting the next word
predictWord <- function(the_word) {
  word_add <- stripWhitespace(removeNumbers(removePunctuation(tolower(the_word),preserve_intra_word_dashes = TRUE)))
  the_word <- strsplit(word_add, " ")[[1]]
  n <- length(the_word)

  ########### check Bigram
  if (n == 1) {the_word <- as.character(tail(the_word,1)); functionBigram(the_word)}
  
  ################ check trigram
  else if (n == 2) {the_word <- as.character(tail(the_word,2)); functionTrigram(the_word)}
  
}
########################################################################
functionBigram <- function(the_word) {
  # testing print(the_word)
  if (identical(character(0),as.character(head(bg[bg$w1 == the_word[1], 2], 1)))) {
    message<<-"If no word found the most used pronoun 'it' in English will be returned" 
    as.character(head("it",1))
  }
  else {
    message <<- "Trying to Predict the Word using Bigram Matrix  "
    as.character(head(bg[bg$w1 == the_word[1],2], 1))
    
    # testing print of bg$w1, the_word[1]
  }
}
########################################################################
functionTrigram <- function(the_word) {
  if (identical(character(0),as.character(head(tg[tg$w1 == the_word[1]
                                                  & tg$w2 == the_word[2], 3], 1)))) {
    as.character(predictWord(the_word[2]))
    
  }
  else {
   message<<- "Trying to Predict the Word using Trigram Matrix "
    as.character(head(tg[tg$w1 == the_word[1]
                         & tg$w2 == the_word[2], 3], 1))
    
  }
}
## ShineServer code to call the function predictWord
shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- predictWord(input$inputText)
    output$sentence2 <- renderText({message})
    result
  });
  output$sentence1 <- renderText({
    input$inputText});
}
)