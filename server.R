library(shiny)
#source("app-1/helpers.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output){
  output$txt1=renderUI(
    if(input$type=='single'){
      withMathJax(h3("(Single) Exponential Smoothing"),helpText("If \\(z_t,\\ t=1,\\ldots,n\\) is a time series, then exponentially smoothed series \\(y_t,\\ t=1,\\ldots,n\\) is defined by
                  $$y_1=z_1;\\ y_t=\\alpha z_t+(1-\\alpha)y_{t-1},\ t=2,\\ldots,n$$
                    Parameter \\(\\alpha\\) is the smoothing parameter. If it is not between 0 and 1, then the computation does not correspond to smoothing any more."),
        helpText("See also",a(href="http://en.wikipedia.org/wiki/Exponential_smoothing","http://en.wikipedia.org/wiki/Exponential_smoothing")))
    }else{
      withMathJax(h3("Double (Holt's) Exponential Smoothing"),helpText("If \\(z_t,\\ t=1,\\ldots,n\\) is original series, the double exponential smoothing is defined by
$$y_t=\\alpha z_t+(1-\\alpha)(y_{t-1}+b_{t-1}),\ b_t=\\beta (y_t-y_{t-1})+(1-\\beta) b_{t-1}$$
with suitable starting values for \\(y_1\\) and \\(b_1\\). Parameters \\(\\alpha\\) and \\(\\beta\\) are the smoothing parameters. If \\(\\alpha\\) and \\(\\beta\\) are not between 0 and 1, the resulting \"smoothed\" series may behave starngely or it may \"blow up\"."),
                      helpText("See also",a(href="http://en.wikipedia.org/wiki/Exponential_smoothing","http://en.wikipedia.org/wiki/Exponential_smoothing")))}
    )
  
  output$plot1=renderPlot({
    series=get(input$tseries)
    alpha=input$alpha
    if(input$type=="simple"){
      tmp=filter(alpha*series,filter=c(1-alpha),method="recursive",init=series[1])
    }else{
      beta=input$beta
      tmp=series
      b=series[2]-series[1]
      for(i in 2:length(series)){
        tmp[i]=alpha*series[i]+(1-alpha)*(tmp[i-1]+b)
        b=beta*(tmp[i]-tmp[i-1])+(1-beta)*b
      } 
    }
    #lines(tmp,col="red",lwd=2)
    ts.plot(series,tmp,col=c("black","red"))
    title(main=paste("Original series (black) and smoothed series (red) of data set",input$tseries))
  })
})