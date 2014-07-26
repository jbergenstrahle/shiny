library(shiny)

df2 = chickwts

feedtype = unique(chickwts$feed)

shinyUI(fluidPage(
  
  titlePanel(h3("Chicken Weights by Feed Type")),
  
  sidebarLayout(
  
  sidebarPanel(
    h5("Feed type study"),
    checkboxGroupInput('feed', 'Select the feed types to include:', feedtype, selected = "horsebean"),
    selectInput('plottype', 'Plottype:', choices = c("Box plot","Violin plot", "Dot plot")),
    radioButtons('color', 'Colorize:', choices=c("No","Yes")),
    submitButton(text = "Plot"),
   
    h5("Weight and stress level prediction"),
    selectInput('feed2', 'Feed:', choices = feedtype),
    selectInput('keepMethod', 'Keeping method:', choices = c("Free-range", "Yarding", "Caged")),
    h6("Added amount of hormones:"),
    numericInput('h1', 'H1IOV455 g/day', 0, min=0,
                 max=200, step=5),
    numericInput('superM', 'Super-MutatedXXX g/day', 0, min=0,
                 max=50, step=1),
    numericInput('belgianC', 'BelgianChicken g/day', 0, min=0,
                 max=50, step=1),
    submitButton(text = "Predict")
  ),
    mainPanel(
    tabsetPanel(
      tabPanel("Data view",                
               plotOutput('plot'),
               verbatimTextOutput('prediction')
               ),
      tabPanel("Help",
               helpText(
                 p("The app is divided in two steps:"),
                 p(strong("Plotting:")),
                 p("The user can plot the real data from the data packade chickwts. Choose the feed types to include and the plot style to be presented. You can also choose to colorize your plot."),                  
                 p(strong("Prediction:")),
                 p("The user can predict just how big and juicy their chicken will be, as well as the resulting stress level. Choose the feed type, keeping method and state the amount of added hormones"),
                 
                 p("The algorithm supports the following intervals for the hormone values:"),
                 p("H1: 0-200 g/day, SuperM: 0-50 g/day, BelgianC: 0-50g/day"),
                p(strong("Data package reference:")),
                code(a("chickenwts", href="http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/chickwts.html")),
                p(br()),
                img(src="chicken.jpg", height = 100, width = 100)
  )
)
)
)
)
))
