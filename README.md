# Text_Analysis_Chicha
By Fabiola M. Alba Vivar

I created a code in R that uses text and sentimental analysis to analyse one of my favorite playlists: Peruvian Psychedelic Chicha

Recommended: Listen to the playlist while reading this: spotify:playlist:5owR7sSGZ0cCE8E5gsNW8x

## Data Input
I created a dataset of song's lyrics based on my -kinda famous- Spotify playlist. A little bit of context: peruvian cumbia and chicha were super popular around the 70s in Lima as a product of the huge rural-urban migration. It came back to life in the 2010s, becoming popular among young generations (like me!).
I compiled the biggest hits in this playlist. 

![Chacalon](Chacalon.jpg)

Check these videos to get to know more about this music genre and its history.
https://youtu.be/WKZKz11hIek
https://youtu.be/6mZ3EY6-r2U

## Some Fun Facts 

I selected modern and classics for this playlist, as you can see in the histogram, there is a gap from mid 80s to 2010s. 
Not surprisingly, this is also one of the worst times in Peru's history: economic and social crisis and after recovery. 
Seems like prosperity and proudness feed this music. 

![SongsHist](SongsHist.png)

I also check and plotted how long are these songs. New modern songs (after 2000) are 45 seconds longer compare with the old ones in average. 

![DurHist](DurHistOver.png)

## Text and Sentimental Analysis
I compiled lyrics from all the songs on my playlist. Why? Well, I have always been interested on how music represents the current feelings on the economy (from real people - no inflation time series!). Social phenomena are sometimes quite hard to quantify, most of the research done on the peruvian chicha culture (rural migrants arriving to Lima) are mostly based on socio/antropology studies, which rely mostly on interviews. However, what can we see on numbers about how people face these times? A nice simple approach is to use text and sentimental analysis.  



