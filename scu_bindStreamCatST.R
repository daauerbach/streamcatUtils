#Convenience function to roll up data from multiple states into a single object, removing any duplicate cats/COMIDs
#Default file location is "catdata" directory in working directory
#Peforms a very simple (fixed string) check for match between states to combine and available .rds objects

bindStreamCatST = function(states
                           ,dirCatdata = paste0(getwd(),"/catdata")
                           ){
   if (!require("dplyr")) { install.packages("dplyr", dependencies = TRUE); library(dplyr)}

   availst = states %in% gsub("catdata|.rds","",list.files(dirCatdata,pattern = "catdata"))
   if(!all(availst)){
      cat(paste("No data available for",states[!availst], "\nRemoved from returned object\n"))
      states = states[availst]
      }
   
   return(distinct(
         do.call(rbind
                 ,lapply(states, function(i) readRDS(paste0(dirCatdata,"/catdata",i,".rds")))
               )
            )
         )
} #end function

