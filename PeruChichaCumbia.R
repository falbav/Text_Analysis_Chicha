###############################################################################
# This script will run  a text / sentimental analysis
# Fabiola Alba Vivar
# Cambridge, 2019

############################################################
## Instaing Packages

#updateR()  # if required

#install.packages('devtools')
#install.packages("dplyr")
#install.packages("udpipe")
#install.packages("readxl")
#install.packages("wesanderson")
#install.packages("extrafont")
#install.packages("readtext")
#install.packages(plyr)
#install.packages("wordcloud2")
#install.packages("tidytext")
#install.packages("SentimentAnalysis")

# Using the Package:
library(extrafont)
library(devtools)
library(stringr)
library(foreign)
library(ggplot2)
library(scales)
library(readxl)
library(udpipe)
library(readtext)
library(wesanderson)
library(plyr)
library(dplyr)
library(tm)
library(RColorBrewer)
library(SnowballC)
library(wordcloud2)
library(gridExtra) #viewing multiple plots together
library(wordcloud2) 
library(tidytext)
library(SentimentAnalysis)
#library(remotes)
#install_github("EmilHvitfeldt/textdata")
#install_github("juliasilge/tidytext")
# devtools::install_github("tidyverse/ggplot2")

## Setting Working Directory
setwd("C:/Users/falba/Dropbox/Published Documents/Music/Peru Chicha/")

## Importing data
playlist <- read_excel("peruvian_chicha.xls")
playlist<-mutate(playlist, Oldie = ifelse(Year<2000,'Old','New'))


# Colors for Plots
my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00")

theme_lyrics <- function() 
{
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_blank(), 
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "none")
}

###############################################################################
## Main Fun Facts

## Years 
png("SongsHist.png") 
hist(playlist$Year, 
     main=" ", 
     xlab="Year", 
     ylab="Frequency of Songs",
     border="white", 
     col="aquamarine3",
     breaks=40,
     prob = TRUE)
dev.off() 

#hist(playlist$Year)

## Lenght 
trackDuration <-playlist$TrackDuration/1000
playlist <- mutate(playlist, TrackDuration=TrackDuration/1000)

png("DurationHist.png") 
hist(trackDuration, 
     main=" ", 
     xlab="Frequency of Song Duration (sec)",
     border="white", 
     col="aquamarine3",
     prob = TRUE)
dev.off() 

## Lenght Song Over Year
###############################
df.dur <- playlist %>% group_by(Year) %>% summarize(Mean = mean(TrackDuration))

png("DurHistYears.png") 
ggplot(data=df.dur, aes(x=Year, y=Mean)) +
  geom_bar(stat='identity', fill="aquamarine3")+
  theme(legend.position = "none", 
                                 plot.title = element_text(hjust = 0.5),
                                 panel.grid.major = element_blank()) +
  xlab("Year") + 
  ylab("Track Duration") +
  coord_flip()
dev.off() 


### Overlapping Histograms: let's create two samples
samp.old<-filter(playlist, Year<2000)
samp.new<-filter(playlist, Year>2000)

dur.old<-samp.old$TrackDuration
dur.new<-samp.new$TrackDuration

# New songs are 45 sec longer than old ones in average 
p2 <- hist(dur.new, breaks=10, xlab="Track Duration (sec)",  main=" ")
p1 <- hist(dur.old, breaks =10,  main=" ")                     

png("DurHistOver.png") 
plot( p1, col=rgb(1,0,0,0.5),border=F, xlab="Track Duration (sec)", main=" ")  # first histogram
plot( p2, col=rgb(0,0.9,0.6,0.5), border=F, add=T)
legend(x= "topright", legend=c("New", "Old"),
       fill=c(rgb(1,0,0,0.5),rgb(0,0.9,0.6,0.5) ), horiz=FALSE, cex=0.8)
dev.off() 


## Text Analysis from Songs Lyrics ##

# How many songs have lyrics?
table(samp.new$Lyrics) #52%
table(samp.old$Lyrics) #50%

playlist <- mutate(playlist, lyrics=Lyrics=="Yes")

## Keeping Songs With lyrics
samp.lyrics<-filter(playlist, lyrics==TRUE)

# Extracting lyrics variable
lyrics<-samp.lyrics$LyricsText

# function to remove special characters
removeSpecialChars <- function(x) gsub("[^a-zA-Z0-9 ]", " ", x, ignore.case = "?")

# remove special characters
samp.lyrics$LyricsText<- sapply(samp.lyrics$LyricsText, removeSpecialChars)
lyrics<- sapply(lyrics,removeSpecialChars)

# convert everything to lower case
samp.lyrics$LyricsText<-  sapply(samp.lyrics$LyricsText, tolower)
lyrics<- sapply(lyrics,tolower)
summary (samp.lyrics)


## Text analytics
undesirable_words<-c("y","lo","la","por","vas", "con","son","una","uno","del","mis","ese","esto", "este", "se", "que",
                     "los","llena","las", "para", "las","fue", "esos", "tiene", "esta", "porque", "pero", "nos", 
                     "como","eso", "vez", "but", 
                     "esa", "muy", "han", "mas", "ahi","tus","tan","aunque", "estos", "estas", "hace", "sin") 


str_remove_all(lyrics,undesirable_words)

words_filtered <-samp.lyrics %>%
  unnest_tokens(word, LyricsText)%>%
  distinct() %>%
  filter(!word %in% undesirable_words) %>%
  filter(nchar(word) > 2)

class(words_filtered)
dim(words_filtered)

# Word Frequency: number of words per song
full_word_count <- samp.lyrics  %>%
  unnest_tokens(word, LyricsText) %>%
  group_by(TrackName,AlbumName,Oldie) %>%
  summarise(num_words = n()) %>%
  arrange(desc(num_words)) 

png("WordCount.png") 
full_word_count %>%
  ggplot() +
  geom_histogram(aes(x = num_words, fill = Oldie )) +
  ylab("Song Count") + 
  xlab("Word Count per Song") +
  ggtitle("Word Count Distribution") +
  theme(plot.title = element_text(hjust = 0.5),
        legend.title = element_blank(),
        panel.grid.minor.y = element_blank()) +
 scale_fill_discrete(name = "Era", labels= c("Old", "New"))
dev.off()

# Lexical Diversity: number of unique words used in a text (song vocabulary)

png("LexicalDiversity.png") 
words_filtered %>%
  count(word, sort = TRUE) %>%
  top_n(12) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot() +
  geom_col(aes(word, n), fill ="aquamarine4") +
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("") + 
  ylab("Song Count") +
  ggtitle("Most Frequently Used Words in Lyrics") +
  coord_flip()
dev.off()

# WorldCloud
wordsCounts <-words_filtered %>% count(word, sort = TRUE) 

png("WordCloud.png") 
wordcloud2(wordsCounts[1:400,],size = 0.25)
dev.off()

popular_words <- words_filtered %>% 
  group_by(Oldie) %>%
  count(word, Oldie, sort = TRUE) %>%
  slice(seq_len(8)) %>%
  ungroup() %>%
  arrange(Oldie,n) %>%
  mutate(row = row_number()) 

png("PopularWords.png") 
popular_words %>%
  ggplot(aes(row, n, fill = Oldie)) +
  geom_col(show.legend = FALSE)+
  labs(x = NULL, y = "Song Count") +
  ggtitle("Popular Words by Era") + 
  theme_lyrics() +  
  facet_wrap(~Oldie, scales = "free") +
  scale_x_continuous(  # This handles replacement of row 
    breaks = popular_words$row, # notice need to reuse data frame
    labels = popular_words$word) +
  coord_flip() 
dev.off()

######## Sentiment Analysis

# Analyze Sentiment and Update for Spanish

## We are going to add some words and their weights (taken from wordcloud:
#write.csv(wordsCounts, "Wordspanish.csv")
wordsweight <- read_excel("Wordspanish.xls")

woorden <-wordsweight$word
scores <- wordsweight$Scale

dictionarySpanish <- SentimentDictionaryWeighted(woorden, scores)

## With special dictionary

sentiment.Spanish.subj <-analyzeSentiment(samp.lyrics$LyricsText, language="spanish",
              rules=list("SpanishSentSubj"=list(ruleLinearModel,dictionarySpanish)))

sentiment.Spanish <-analyzeSentiment(samp.lyrics$LyricsText, language="spanish",
                                     removeStopwords =TRUE, stemming=TRUE)

## Let's get one data set for this:

sent.df<-merge(sentiment.Spanish.subj,samp.lyrics,by="row.names",sort=TRUE)
sent.df$Row.names <- NULL
sent.df<-merge(sent.df,sentiment.Spanish,by="row.names", sort=TRUE)


cor(sent.df[, c("SpanishSentSubj", "SentimentGI", "SentimentLM", "SentimentHE", "SentimentQDAP")])

barplot(sent.df$SpanishSentSubj, sent.df$Year)
barplot(sent.df$SentimentLM, sent.df$Year)
barplot(sent.df$SentimentGI, sent.df$Year)
barplot(sent.df$SentimentHE, sent.df$Year) ## Doesnt say much
barplot(sent.df$SentimentQDAP, sent.df$Year)

#######################################################################################
## Plotting: we are going to use the Spanish Subjective (I put my own values)

df.span <- sent.df %>% group_by(Year) %>% summarize(Mean = mean(SpanishSentSubj))

png("SpanishSent.png") 
ggplot(data=df.span, aes(x=Year, y=Mean, fill=Mean)) +
  geom_bar(stat='identity', fill="aquamarine3")+
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("Year") + 
  ylab("Sentiment Subjective Score") +
  coord_flip()
dev.off() 

###############################
df.LM <- sent.df %>% group_by(Year) %>% summarize(Mean = mean(SentimentLM))

png("SpanishSentimentLM.png") 
ggplot(data=df.LM, aes(x=Year, y=Mean, fill=Mean)) +
  geom_bar(stat='identity', fill="coral3")+
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("Year") + 
  ylab("Sentiment LM Score") +
  coord_flip()
dev.off() 

###############################
df.GI <- sent.df %>% group_by(Year) %>% summarize(Mean = mean(SentimentGI))

png("SpanishSentimentGI.png") 
ggplot(data=df.GI, aes(x=Year, y=Mean, fill=Mean)) +
  geom_bar(stat='identity', fill="coral3")+
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("Year") + 
  ylab("Sentiment GI Score") +
  coord_flip()
dev.off() 

###############################
df.QDAP <- sent.df %>% group_by(Year) %>% summarize(Mean = mean(SentimentQDAP))

png("SpanishSentimentQADP.png") 
ggplot(data=df.QDAP, aes(x=Year, y=Mean, fill=Mean)) +
  geom_bar(stat='identity', fill="coral3")+
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("Year") + 
  ylab("Sentiment QADP Score") +
  coord_flip()
dev.off() 
