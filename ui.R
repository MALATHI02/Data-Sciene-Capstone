#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)

## SHINY UI
shinyUI(
  fluidPage(
    titlePanel("DATA SCIENCE CAPSTONE - USING NLP TO PREDICT WORDS"),
    sidebarLayout(
      sidebarPanel(
        helpText("ENTER A WORD, TEXT OR A SENTENCE TO PREVIEW NEXT WORD PREDICTION"),
        hr(),
        textInput("inputText", "ENTER THE TEXT / WORD / SENTENCE HERE",value = ""),
        hr(),
        helpText("After the text input, the predict next word will appear in the right hand box.
                 For e.g enter the word 'happy' in the text input and predict word will display
                 'happy birthday'."), 
        hr()
      ),
      mainPanel(
        h2("PREDICT NEXT WORD"),
        verbatimTextOutput("prediction"),
        strong("WORD / TEXT / SENTENCE ENTERED:"),
        strong(code(textOutput('sentence1'))),
        br(),
        strong("USING N-GRAMS TO SHOW NEXT WORD:"),
        strong(code(textOutput('sentence2'))),
        hr()
      )
    )
  )
)