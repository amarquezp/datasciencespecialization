NOAA TOP TEN DISASTERS
========================================================
author: Antonio Marquez Palacios
date: April 26, 2018
autosize: true

NOAA's database
========================================================
NOAA's Storm database is available [here](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2)
For information about how data is collected and description about the variables, please refer [here](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)

This presentation focuses on the top ten most harmful natural disasters captured by NOAA

- TORNADOS
- FLOOD
- EXCESSIVE HEAT
- ICE STORM
- LIGHTNING
- HEAT
- FLASH FLOOD
- TSTM WIND
- WINTER STORM
- THUNDERSTORM WIND

Application Usage
========================================================

To access the application please refer to the this [URL](https://amarquezp.shinyapps.io/noaasWeatherDisasters/)

There is a combo box (select Input) component at the left side of the screen, where the Top Ten most harmful events
are listed. Please select one and the corresponding Victims' map will be displayed at the right side.
Do a mouse-over each state to see the number of victims for that event.


NOAA's data exploration and preparation
========================================================
To shorten the code, this presentation uses an previously processed data set. If you want to check the exploratory data analysis and data preparation, please refer to this [link](http://rpubs.com/amarquezp/noaas_da)



```r
# Read the file
NOAAS_DT      <- read.csv(FILENAME, header = TRUE, sep = ",",  quote = "\"")

# Get the harmful events
noaas_harmful_evts  <- NOAAS_DT %>% group_by(EVTYPE) %>% arrange(desc(VICTIMS))
noaas_harmful_evts <- data.frame(lapply(noaas_harmful_evts, as.character), stringsAsFactors = FALSE )
noaas_harmful_evts <- noaas_harmful_evts[1:10,1]
noaas_evtype_victims <- NOAAS_DT[NOAAS_DT$EVTYPE == 'TORNADO', ] %>% group_by(EVTYPE, STATE) %>% arrange(desc(VICTIMS))
```

Plot a map using plot_ly
========================================================


```r
 # Calculate the total of victims
 # Get the harmful events

  map_options <- list(
    scope = 'usa',
    showland = T,
    landcolor = toRGB("gray90"),
    showcountries = F,
    subunitcolor = toRGB("white")
  )

  borders <- list(color = toRGB("red"))

 p <- plot_ly(noaas_evtype_victims, z=noaas_evtype_victims$VICTIMS, locations= noaas_evtype_victims$STATE,
            type='choropleth', locationmode= 'USA-states', color=noaas_evtype_victims$VICTIMS, colors='Blues',
            marker=list(line= borders)) %>% layout(title = paste('US TORNADO Victims'), geo=map_options)
```

