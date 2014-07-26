library(shiny)
library(ggplot2)
library(ggthemes)

df2 = chickwts

plotF = function(feedtype, plottype, color){

  df3 = subset(df2, feed %in% feedtype)
  df3$feed = factor(df3$feed) #To remove priv. factor levels
  if (color == "No"){
    plot = ggplot(df3, aes(x=feed, y=weight))
  }
  else if (color == "Yes"){
    plot = ggplot(df3, aes(x=feed, y=weight, color=feed))
  }
  
  if (plottype == "Box plot"){
    plot + geom_boxplot()+
    theme_bw(base_size = 12, base_family = "Helvetica")
  }
  else if (plottype == "Violin plot"){
    plot + geom_violin()+
    theme_bw(base_size = 12, base_family = "Helvetica")
  }
  else if (plottype == "Dot plot"){
    plot + geom_point()+
    theme_bw(base_size = 12, base_family = "Helvetica")
  }
}

pred = function(feed2, keep, h1, superM, belgianC){
  
  df3 = subset(df2, feed %in% feed2)
  df3$feed = factor(df3$feed)
  meanSub = subset(df3, feed==feed2)
  
  if(keep=="Free-range"){
   x2=1}
  else if (keep=="Yarding"){
   x2=0.8}
 else {
   x2=0.5}
  
  weightPred = mean(meanSub$weight)+10*(x2)+(0.01*h1+0.08*superM+0.2*belgianC)^2
  stressPred = - 100*x2 - 0.1*h1 + 1*superM + 2*belgianC
  if (stressPred>50)
    stressLvl = "Acute panic"
  else if (stressPred > 0)
    stressLvl = "Elevated despair"
  else if (stressPred > -60)
    stressLvl = "Noticeably unsettled"
  else if (stressPred > -79)
    stressLvl = "Inner calm"
  else if (stressPred > -110)
    stressLvl = "Life is good"
  else
    stressLvl = "Apathetic"
    
  preds = c("Weight prediction: ",weightPred, " Stress level prediction: ", stressLvl)
}

shinyServer(
  function(input,output)
    {
    output$plot = renderPlot({plotF(input$feed, input$plottype, input$color)})
  
    output$prediction = renderText({pred(input$feed2, input$keepMethod, input$h1, input$superM, input$belgianC)})
    })

