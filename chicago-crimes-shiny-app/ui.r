library(shiny)
library(leaflet)
library(ggmap)
crimes_vector <- c("ARSON" = "ARSON", "ASSAULT" = "ASSAULT", "BATTERY" = "BATTERY", "BURGLARY" = "BURGLARY", 
                  "CRIM SEXUAL ASSAULT" = "CRIM SEXUAL ASSAULT", "CRIMINAL DAMAGE" = "CRIMINAL DAMAGE", "CRIMINAL TRESPASS" = "CRIMINAL TRESPASS", "DECEPTIVE PRACTICE" = "DECEPTIVE PRACTICE",
                  "GAMBLING" = "GAMBLING", "HOMICIDE" = "HOMICIDE", "HUMAN TRAFFICKING" = "HUMAN TRAFFICKING", "INTERFERENCE WITH PUBLIC OFFICER" = "INTERFERENCE WITH PUBLIC OFFICER",
                  "INTIMIDATION" = "INTIMIDATION", "KIDNAPPING" = "KIDNAPPING", "LIQUOR LAW VIOLATION" = "LIQUOR LAW VIOLATION", "MOTOR VEHICLE THEFT" = "MOTOR VEHICLE THEFT",
                  "NARCOTICS" = "NARCOTICS", "OBSCENITY" = "OBSCENITY", "OFFENSE INVOLVING CHILDREN" = "OFFENSE INVOLVING CHILDREN", "OTHER OFFENSE" = "OTHER OFFENSE",
                  "PROSTITUTION" = "PROSTITUTION", "PUBLIC INDECENCY" = "PUBLIC INDECENCY", "PUBLIC PEACE VIOLATION" = "PUBLIC PEACE VIOLATION", "ROBBERY" = "ROBBERY",
                  "SEX OFFENSE" = "SEX OFFENSE", "STALKING" = "STALKING", "THEFT" = "THEFT", "WEAPONS VIOLATION" = "WEAPONS VIOLATION")
crimes_checked <- c("ASSAULT", "BATTERY", "BURGLARY", "CRIM SEXUAL ASSAULT", "CRIMINAL DAMAGE", "CRIMINAL TRESPASS", "HOMICIDE", "INTIMIDATION",
                    "KIDNAPPING", "MOTOR VEHICLE THEFT", "NARCOTICS", "OFFENSE INVOLVING CHILDREN", "PUBLIC PEACE VIOLATION", "ROBBERY",
                    "SEX OFFENSE", "STALKING", "THEFT", "WEAPONS VIOLATION")
days_vector <- c("Sunday" = "Sunday", "Monday" = "Monday", "Tuesday" = "Tuesday", "Wednesday" = "Wednesday", "Thursday" = "Thursday", "Friday" = "Friday", "Saturday" = "Saturday")
days_checked <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday") 
periods_vector <- c("MIDNIGHT - 6:00 A.M." = "early_morning", "6:00 A.M. - NOON" = "morning", 
                    "NOON - 6:00 P.M." = "afternoon", "6:00 P.M. - MIDNIGHT" = "evening")
periods_checked <- c("early_morning", "morning", "afternoon", "evening")
plots_facets_vector <- c("day of week" , "time of day" , "crime category" )
years_vector <- c("2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001")
locations_vector <- c("Congress Pkwy and State St, Chicago", "N Ashland Ave and West Lake St, Chicago", "S Ashland Ave and W Cermak Rd, Chicago",
                      "N Harlem Ave and West Bryn Mawr Ave, Chicago", "University of Chicago, Chicago", "S Story Island Ave and E 79th St, Chicago",
                      "W 79th St and S State St, Chicago", "Hyde Park, Chicago", "S State St and W 31st St, Chicago", "N Clark St and W Devon Ave, Chicago",
                      "Illinois Institute of Technology, Chicago", "University of Illinois at Chicago, Chicago", "Chicago State University, Chicago",
                      "Northeastern illinois University, Chicago", "N Mason Ave and N Northwest Hwy, Chicago", "N Austin Ave and W Irving Park Rd, Chicago",
                      "W Irving Park Rd and N Pulaski Rd, Chicago", "W Irving Park Rd and N Damen Ave, Chicago", "N Cicero Ave and W North Ave, Chicago",
                      "Wrigley Field, Chicago", "Guarantee Rate Field, Chicago", "North Lawndale, Chicago")

shinyUI(fluidPage(
  titlePanel(h3("Chicago Crime Map"), windowTitle = "Chicago Crime Map"),
  sidebarLayout (
    sidebarPanel(
           textInput("address",label=h4("Enter location or click on map"),
                     value=sample(locations_vector, size=1, replace=TRUE) ),
           
           sliderInput("radius",label=h4("Radius in miles"),
                       min=0.5,max=2.0,value=1.0, step=0.5),
           actionButton("goButton", "Search", style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
           selectInput("year", label = h4("Year"), years_vector),
           checkboxGroupInput("crimes", label = h4("Crime Type"), choices = crimes_vector, selected = crimes_checked, inline = TRUE),
           checkboxGroupInput("days_of_week", label = h4("Days of Week"), choices = days_vector, selected = days_checked, inline = TRUE),
           checkboxGroupInput("time_periods", label = h4("Time Periods"), choices = periods_vector, selected = periods_checked, inline = TRUE),
           selectInput("plots_facets", label = h4("Facet density maps and bar plots by"), plots_facets_vector),
           HTML('<a href="https://github.com/carlosror/chicago_crimes" target="_blank"><img src = "github_icon.png" alt = "xyz"></a>
                 <a href="https://twitter.com/LrnDataScience" target="_blank"><img src = "twitter_icon.png" alt = "xyz"></a>')
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Map", leafletOutput("map",width="auto",height="640px")),
            tabPanel("Data", dataTableOutput("DataTable")),
            tabPanel("Barplots", plotOutput("barplots", width = "auto", height="640px")),
            tabPanel("Density Maps (Patience)", plotOutput("density_maps", width = "auto", height="640px")),
            tabPanel("Table", verbatimTextOutput("table")),
            tabPanel("Notes", htmlOutput("notes"))
            # tabPanel("Debug", verbatimTextOutput("debug"))
        )
    )
)))