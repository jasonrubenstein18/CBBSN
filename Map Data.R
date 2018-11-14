install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

library(readr)
scouted_players <- read_csv("/Users/jasonrubenstein/Desktop/CBBSN/CBSN/College Spatial Analysis - Scouted_Players.csv")
agency_data <- read_csv("/Users/jasonrubenstein/Downloads/Agency Research - Expanded List-2.csv")
northeast_scouts <- read_csv("/Users/jasonrubenstein/Downloads/2019 Northeast Scouts - RTG.csv")
Draft <- read_csv("/Users/jasonrubenstein/Desktop/CBBSN/Draftees.csv")
historical_draft <- read_csv("/Users/jasonrubenstein/Desktop/CBBSN/draft_w_location.csv")
dodgers <- subset(Draft, Draft$TEAM == "Dodgers")
shoowin_teams <- read_csv("/Users/jasonrubenstein/Desktop/ShooWin/Misc/Teams List.csv")

labs <- data.frame(
	lon = dodgers$Long,
	lat = northeast_scouts$Lat,
	names = c("Northeast Scouts"),
	stringsAsFactors = FALSE)  

gg1 + 
	geom_point(data = labs, aes(x = northeast_scouts$Long, y = northeast_scouts$Lat), color = "black", size = 1) +
	geom_point(data = labs, aes(x = northeast_scouts$Long, y = northeast_scouts$Lat), color = "black", size = 1)



usa <- map_data("usa")
dim(usa)
head(usa)
tail(usa)

ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
	coord_fixed(1.3)

#####   No fill usa #####

ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "green") +
	coord_fixed(1.3)



#####  Fill in colors #####
gg1 <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "gray", color = "orange") + 
	coord_fixed(1.3)
gg1



labs <- data.frame(
	lon = shoowin_teams$Long,
	lat = shoowin_teams$Lat,
	names = c("Shoowin Teams"),
	stringsAsFactors = FALSE)  

gg1 + 
	geom_point(data = labs, aes(x = shoowin_teams$Long, y = shoowin_teams$Lat), color = "black", size = 2) +
	geom_point(data = labs, aes(x = shoowin_teams$Long, y = shoowin_teams$Lat), color = "yellow", size = 2)

states <- map_data("state")
dim(states)
ggplot(data = states) + 
	geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
	geom_point(data = labs, aes(x = shoowin_teams$Long, y = shoowin_teams$Lat), color = "black", size = 1) +
	geom_point(data = labs, aes(x = shoowin_teams$Long, y = shoowin_teams$Lat), color = "black", size = 1) +
	coord_fixed(1.3) +
	guides(fill=FALSE)

####### Astros ########
library(readr)
Draftees <- read_csv("/Users/jasonrubenstein/Downloads/Agency Research - 2016-17 Draftees (1).csv")

Phillies <- subset(Draftees, Draftees$`Team Name` == "Phillies")

ggast <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "brown", color = "orange") + 
	coord_fixed(1.3)
ggast



labsast <- data.frame(
	lon = Phillies$Lon,
	lat = Phillies$Lat,
	names = c("Draftees"),
	stringsAsFactors = FALSE)  

ggast + 
	geom_point(data = labsast, aes(x = Phillies$Lon, y = Phillies$Lat), color = "gold", size = 2) +
	geom_point(data = labsast, aes(x = Phillies$Lon, y = Phillies$Lat), color = "black", size = 2)



# Phillies
Phillies <- subset(Draftees, Draftees$`Team Name` == "Phillies")
# Dodgers
Dodgers <- subset(Draftees, Draftees$`Team Name` == "Dodgers")
# Blue Jays
Blue_Jays <- subset(Draftees, Draftees$`Team Name` == "Blue Jays")
# Tigers
Tigers <- subset(Draftees, Draftees$`Team Name` == "Tigers")
			   



####### Boras #####
library(readr)
Agencies <- read_csv("~/Desktop/CBBSN/CBSN/Agencies.csv")

Boras <- subset(Agencies, Agencies$Agency == "Boras Corporation")

ggwass <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "orange", color = "orange") + 
	coord_fixed(1.3)
ggwass



labsbor <- data.frame(
	lon = Boras$Lon,
	lat = Boras$Lat,
	names = c("Boras Clients"),
	stringsAsFactors = FALSE)  

ggwass + 
	geom_point(data = labsbor, aes(x = Boras$Lon, y = Boras$Lat), color = "gold", size = 2) +
	geom_point(data = labsbor, aes(x = Boras$Lon, y = Boras$Lat), color = "black", size = 2)


##### Octagon
library(readr)
Agencies <- read_csv("~/Desktop/CBBSN/CBSN/Agencies.csv")

Oct <- subset(Agencies, Agencies$Agency == "Octagon")

ggwass <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "orange", color = "orange") + 
	coord_fixed(1.3)
ggwass



labsoct <- data.frame(
	lon = Oct$Lon,
	lat = Oct$Lat,
	names = c("Octagon Clients"),
	stringsAsFactors = FALSE)  

ggwass + 
	geom_point(data = labsoct, aes(x = Oct$Lon, y = Oct$Lat), color = "gold", size = 2) +
	geom_point(data = labsoct, aes(x = Oct$Lon, y = Oct$Lat), color = "black", size = 2)

##### Excel
library(readr)
Agencies <- read_csv("~/Desktop/CBBSN/CBSN/Agencies.csv")

Exc <- subset(Agencies, Agencies$Agency == "Excel Sports Management")


ggwass <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "green", color = "orange") + 
	coord_fixed(1.3)
ggwass



labsexc <- data.frame(
	lon = Exc$Lon,
	lat = Exc$Lat,
	names = c("Excel Clients"),
	stringsAsFactors = FALSE)  

ggwass + 
	geom_point(data = labsoct, aes(x = Oct$Lon, y = Oct$Lat), color = "gold", size = 2) +
	geom_point(data = labsoct, aes(x = Oct$Lon, y = Oct$Lat), color = "black", size = 2)








##### Current Scout Analysis #####
Scouts <- read_csv("~/Desktop/CBBSN/CBSN/Scouts.csv")

ggscout <- ggplot() + 
	geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "darkgreen", color = "white") + 
	coord_fixed(1.3)
ggscout



labsscouts <- data.frame(
	lon = Scouts$Long,
	lat = Scouts$Lat,
	names = c("CBBSN Scouts"),
	stringsAsFactors = FALSE)  

ggscout + 
	geom_point(data = labsscouts, aes(x = Scouts$Long, y = Scouts$Lat), color = "black", size = 2) +
	geom_point(data = labsscouts, aes(x = Scouts$Long, y = Scouts$Lat), color = "yellow", size = 2)


library(maps)
library(mapdata)
library(ggplot2)
state<- map_data("state")
world<- map_data("world")

#scouts world
SCOUTSFULL<-read.csv("file:///C:/Users/Zane/Documents/Baseball/CBBSN/Analytics/Scout info 11-2-18.csv",header=TRUE,sep=',',strip.white=TRUE,na.strings="EMPTY")

#map of all CBBSN scouts including international
ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = SCOUTSFULL, aes(x = long_school_1, y = lat_school_1), color = SCOUTSFULL$Color2, size = SCOUTSFULL$Size, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Scouts")

#map of all CBBSN scouts colored by region
ggplot() + geom_polygon(data = world, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = SCOUTSFULL, aes(x = long_school_1, y = lat_school_1), color = SCOUTSFULL$Color, size = SCOUTSFULL$Size, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Scouts")

#just US scouts
usscouts <- subset(SCOUTSFULL, SCOUTSFULL$Size == 1)

#map of all US CBBSN scouts colored by region
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = usscouts, aes(x = long_school_1, y = lat_school_1), color = usscouts$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN US Coverage by Region")

Northeast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Northeast")
Southeast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Southeast")
Midwest <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Midwest")
Southwest <- subset(SCOUTSFULL, SCOUTSFULL$Region == "Southwest")
WestCoast <- subset(SCOUTSFULL, SCOUTSFULL$Region == "West Coast")

#Regions, colored by scouts

#Northeast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Northeast, aes(x = long_school_1, y = lat_school_1), color = Northeast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Northeast Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Southeast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Southeast, aes(x = long_school_1, y = lat_school_1), color = Southeast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Southeast Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Midwest
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Midwest, aes(x = long_school_1, y = lat_school_1), color = Midwest$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Midwest Coverage") + guides(fill = guide_legend(reverse=TRUE))

#Southwest
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = Southwest, aes(x = long_school_1, y = lat_school_1), color = Southwest$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN Southwest Coverage") + guides(fill = guide_legend(reverse=TRUE))

#West Coast
ggplot() + geom_polygon(data = state, aes(x=long, y = lat, group = group),fill=NA,color="grey")+coord_fixed(1.3)+
  geom_point(data = WestCoast, aes(x = long_school_1, y = lat_school_1), color = WestCoast$Color, size = 2, shape=19) +
  theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(panel.background = element_rect(fill = 'black')) +
  ggtitle("CBBSN West Coast Coverage") + guides(fill = guide_legend(reverse=TRUE))

