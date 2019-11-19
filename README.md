# Text_Analysis_Chicha
By Fabiola M. Alba Vivar

I created a code in R that uses text and sentimental analysis to analyse one of my favorite playlists: Peruvian Psychedelic Chicha

A little bit of context: peruvian cumbia and chicha were super popular around the 70s in Lima as a product of the huge rural-urban migration in Peru. It's a weird mix of jungle-andean sounds tuned up with cool pyscodelic influences. The lyrics reflected a stories of the migrants establishing in the city and also the traditions of those who remained in the highlands and the jungle. This old popular gnre came back to life in the 2010s, becoming popular among young generations (like me!). A lot of new artists got inspired and created a modern version that keeps playing along in parties.

Check these videos to get to know more about this music genre and its history.
https://youtu.be/WKZKz11hIek
https://youtu.be/6mZ3EY6-r2U

![Chacalon](Chacalon.jpg)

## Data Input
I created a dataset of song's lyrics based on my -kinda famous- Spotify playlist. I compiled the biggest hits in this playlist/dataset. 
The raw data is included in the Github site. 

Please, listen to the playlist while reading this: spotify:playlist:5owR7sSGZ0cCE8E5gsNW8x

## Some Fun Facts 
I selected modern songs and classics for this playlist. As you can see in the histogram, there is a gap from mid 80s to 2010s.
Not surprisingly, this is also one of the worst times in Peru's history: economic and social crisis and after recovery. 
Seems like prosperity brings out this music... 

![SongsHist](SongsHist.png)

I also check and plotted how long are these songs. New modern songs (after 2000) are 45 seconds shorter compare with the old ones in average. Why? Well this is actually a product of the modern world, it's just following the demand for modern hits to be shorter. 
(Check this link: https://www.digitalmusicnews.com/2019/01/18/streaming-music-shorter-songs-study/)

![DurHist](DurHistOver.png)

## Text and Sentimental Analysis
I compiled lyrics from all the songs on my playlist. Why? Well, I have always been interested on how music represents the current feelings on the economy (from real people - not inflation time series!). Social phenomena are sometimes quite hard to quantify, most of the research done on the peruvian chicha culture (the cultural change when rural migrants arrived to Lima) are mostly based on socio/antropology studies, which rely mostly on interviews. However, what can we see on numbers about how people face these times? A nice simple approach is to use text and sentimental analysis.

Lyrics expressed the popular sentiment of the time and the chicha gnre reflected quite well the feeling of the migrant. One popular amthen of these times,  a song called "Provinciano" (meaning something like "the one who came from the rural area") by Chacalon, portraits the experience of thousands of people...

> Soy muchacho provinciano, (I am a provincial boy)
> me levanto muy temprano, (I wake up very early)
> para ir con mis hermanos, (to go with my brothers)
> ayayayay a trabajar, (ayayayay to work)
> no tengo padre ni madre,  (I have no father or mother)
> ni perro que a mi me ladre, (No dog that barks at me)
> solo tengo la esperanza, (I only have hope)
> ayayayay de progresar, (ayayayay to progress)
> busco una nueva vida, (I'm looking for a new life)
> en esta ciudad ah ah, (in this city ah ah)
> donde todo es dinero y, (where everything is money and)
> hay maldad ah ahm, (there is evil ah ah) 
> con la ayuda de dios, (with God's help)
> se que triunfare eh eh, (I know that I will triumph huh huh)
> y junto a ti mi amor,  (and with you my love)
> feliz sere, (happy i will be)

I'm going to make this analysis comparing the classics (the 70's era) versus the modern renaissance (the 2010s era). 
Old song seem to have the most number of words compared to the new era songs. This might be because a lot of modern songs are covers and they only used extracts of old songs.

![WordCount](WordCount.png)

Overall, the most common words used in the songs are "everything, want, life, alone, when, love, always, people, heart, never, sky, sweetheart". I took several hours of constanly listening to these songs and I'm not surprised by these results. The overall feeling transmited into this lyrics reflect the migrant sentiment: hope and love. Most the songs are stories about leaving your hometown, missing your lover, hoping for a better future and adapting to the city culture. 

![LexicalDiver](LexicalDiversity.png)

![WordCloud](WordCloud.png)

When breaking down the results from old and new songs, the new ones are mostly positive. "love, life, pretty, fine, now, etc".
Again, this is not surprising given the context is different but also, the audience is different: new generations are already established in the city, enjoying (the not so fair or sustainable) economic prosperity.

![PopWords](PopularWords.png)

Finally, I wanted to quantify one dimension of the sentiment reflected on these lyrics. I know this is something complex to process and so subjective, of course! A song might make you feel different than it would make me feel. But simplyfying this to one dimension, it might make it easier. For example, does this word make you feel good or bad? Let's say "sunshine", it's more on the positive side than negative. 

![SpanishSent](SpanishSent.png)

Overall, all my indexes using sentimental analysis in Spanish gave me very neutral results. Probably because some words and phrases are hard to categorize. So I created a new data base where I included a score for each word, in a range from [-1,1]. I found that modern songs are more "positive" than the old ones, probably reflecting less strugles that people did in the past. Of course, this is completly subjective, you can create your own weights as well, and run your own sentiment analysis. 


You can find all the data sets, graphs and R code in this site.
Use it to create your own version and have some fun. 
I hope this inspire you to use data to explore other social phenomena.
If you find any error or have any interesting suggestion, please contact me. 




