#Johson et al., 2019 data processing 
#Ria Raut, Sept 11th 

library(tidyverse)

setwd('C:/Users/riara/OneDrive/All Documents/UCBerk Personal research work/LOVE/community_assembly_love_RR-NEW')
getwd()

infections_data <- read.csv('data/amphibian_parasites/experiment_infection_totals_UPLOAD.csv', stringsAsFactors = F)

#see if p/a of amphibians (and thus community?) influences p/a of parasite -- not quite the same as persistence 
#of species across time? 
#take out host count 
#Make it so that you're multipling the B, P, etc. host columns by the number of P, B, etc. in the 'treatment' column 
#these counts are your outcome columns. Not action in this case because action and outcomes are expected to be the same
#and since this is primarily for function g, let's just call it outcome 
#then the outcome cols are just...the Count? Change that title to parasite_count 

cleaned <- infections_data %>% 
  select(-c(HostCount, CommFreq, B, P, R, G, T, TotalAdded))
summary(cleaned)

#Make individual counts 
cleaned$B.outcome <- str_count(cleaned$Treatment, 'B')
cleaned$P.outcome <- str_count(cleaned$Treatment, 'P')
cleaned$R.outcome <- str_count(cleaned$Treatment, 'R')
cleaned$G.outcome <- str_count(cleaned$Treatment, 'G')
cleaned$T.outcome <- str_count(cleaned$Treatment, 'T')
#cleaned$row_ID <- row_number(cleaned)

wider_cleaned <- cleaned %>% 
  pivot_wider(names_from = Parasite, values_from = Count) 

expanded <- wider_cleaned %>%
  unnest(c(Alaria, Cephalogonimus, Ribeiroia))

class(expanded$Alaria) # it says it's an integer, which I think is fine... ?? 

final <- expanded %>% 
  select( c (Treatment, 
             HostRichness, 
             contains('outcome'), 
             Alaria, 
             Cephalogonimus, 
             Ribeiroia))

write.csv(final, 'data/amphibian_parasites/LOVE_updated_Johnson2019_parasites.csv', row.names = F)
#yay