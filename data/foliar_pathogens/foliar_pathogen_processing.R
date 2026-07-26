#July 24th, 2026 
#Ria Raut 

#Let's first load all the libraries 
library(tidyverse) 
library(janitor)

setwd('C:/Users/riara/OneDrive/All Documents/UCBerk Personal research work/LOVE/community_assembly_love_RR-NEW/data/foliar_pathogens')

raw_data <- read.csv('Fungi2015.csv')
unique(raw_data$Host)
unique_fungi <- as.list(unique(raw_data$FungusSpecies))
class(unique_fungi)

#giving up on this because the dataset that has the pathogen damage is corrupted, so consideing the effort it 
#would take to recvoer that or email the authors + the
#fact that it's not an explicitly manipulated community 
#means that this is worth just abandoning 