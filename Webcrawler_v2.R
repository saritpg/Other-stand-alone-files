# Written by Sarit Pati Goswami
# Project is to search in Times of India archives for news articles on communal riots
# First, we scan systematically through 15 years of archives for articles
# Second, we scan the articles for keywords (riots, communal violence)
# Save the URL, keyword scores in a dataList List.


# load packages
library(RCurl)
library(XML)
library(httr)
library(stringr)

# Sample URL:
# http://timesofindia.indiatimes.com/2001/1/1/archivelist/year-2001,month-1,starttime-36892.cms

dataList<-c()  # never thought this will be necessary, defining a empty list variable.
ProData<-c() 
Tck<-36892 # start of archive ticks in the webpage url, not random.
Yr=2001 # remove the Yr, Mnth, and Dte, when running the for loop
Mnth=1
Dte=1
# for (Yr in 2001:2015) {
  TempYear<-as.character(Yr)
  # for (Mnth in 1:12) {
    TempMonth=as.character(Mnth)
#     if (Mnth == 1 | 3 |5 | 7 | 8 | 10 | 12) {
#       nDte<-31
#     } else if (Mnth == 2 & Yr== 2004 | 2008 |2012) {
#       nDte<-29
#     } else if (Mnth == 2 & Yr!= 2004 | 2008 |2012) {
#       nDte<-28
#     } else
#       nDte<-30

    # for (Dte in 1:nDte) {
      TempDate=as.character(Dte)
      TempTick=as.character(Tck)

      AddUrl<-paste0("http://timesofindia.indiatimes.com/",TempYear,"/",TempMonth,"/",TempDate,"/","archivelist/year-",TempYear,",month-",TempMonth,",starttime-",TempTick,".cms")
      Tck<-Tck+1

      doc <- htmlParse(AddUrl)
      RawData <- xpathSApply(doc, "//a[@href]", xmlGetAttr, "href") # get all 'href' links (which are the article links)
    
      match1<-str_match(RawData, "articleshow")
      match2<-str_match(RawData, "timesofindia")
      
    
      for (n in 1:length(RawData)) {
        if ((toString(match1[n])=="articleshow") & (toString(match2[n]) =="timesofindia")) {
          ProData<-c(ProData, RawData[n])
        }
      }
      
      
      
      for (n in 1:length(ProData)) {
        html <- getURL(ProData[n])
        
        doc <- htmlParse(html, asText = TRUE)
        text <- xpathSApply(doc, "//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)
        
        
        riot<-grep('riot', text)
        riots<-grep('riots', text)
        violence<-grep('violence', text)
        communal<-grep('communal', text)
        mob<-grep('mob', text)
        tension<-grep('tension', text)
        
        
        
        
        if ((length(riot)>0) | (length(riots)>0) | (length(violence)>0) & (length(communal)>0) | (length(mob)>0) | (length(tension)>0)) {
          totalScore<-sum(length(riot),length(riots),length(violence),length(mob),length(tension),length(communal))
          communalScore<-length(communal)
          
          docList<-c(ProData[n], totalScore, communalScore)
          dataList<-c(dataList,docList)
          
        }
      } # End of "for Loop" scanning keywords
   
#       } # End of Date for loop
#     } # End of Month for loop
#   } # End of Year for loop

    
    

      



