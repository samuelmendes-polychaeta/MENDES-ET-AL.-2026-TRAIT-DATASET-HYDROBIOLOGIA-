#' Author: Samuel Lucas da S. Delgado Mendes, Nykon Craveiro, Paulo Cesar de Paiva, José Souto Rosa-Filho, 
#' Rodolfo L. Nascimento
#' Subject: Macroalgae morphological complexity affects the functional diversity of epifaunal annelid assemblages
#' Journal: HYDROBIOLOGIA
#' 
#' TRAIT DATA AND GOWER DISTANCE MATRIX

# Packages ---------------------------------------------------------------------

{
  lib <- .libPaths()[1] 
  required.packages <- c("vegan", "writexl", "openxlsx",
                         "readxl",  "here","tidyverse", 
                         "ade4", "hclust", "gawdis") 
  i1 <- !(required.packages %in% row.names(installed.packages())) 
  if(any(i1)) { 
    install.packages(required.packages[i1], dependencies = TRUE, lib = lib) 
  } 
  lapply(required.packages, require, character.only = TRUE)
  
} # required packages


# Import -----------------------------------------------------------------------

{
  traits<-read.xlsx(here("Data", "data.xlsx"), sheet = "polychaete_traits") #Raw fuzzy coded traits
  
}


# Fuzzy scores calculation -----------------------------------------------------

#1. fuzzy scores and distance matrix
{
  
  #size
  {
    length<-prep.fuzzy(traits[2:4], col.blocks = 3)
  }
  
  #feeding strategy
  {
    feeding<-prep.fuzzy(traits[5:9], col.blocks = 5)
  }
  
  #reproduction
  {
    larval_development<-prep.fuzzy(traits[10:12], col.blocks = 3)
  }
  
  #fuzzy scores dataframe
  {
    db.trait = data.frame(length, feeding, larval_development)
    rownames(db.trait) = traits$`Genera/Traits`
  }
  
  #Gower distance matrix
  {
    gawdist<- gawdis(db.trait, w.type = "equal", 
                     groups = c(1,1,1,
                                2,2,2,2,2,
                                3,3,3), fuzzy = TRUE) #gower distance among genera w/ fuzzy traits
    
  }
  
} 


