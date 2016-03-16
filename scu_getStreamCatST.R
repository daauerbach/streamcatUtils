# Takes a 2-character (caps) state abbreviation, returns a tbl_df dataframe of n-obs COMIDs with n-features
# Revised to dplyr from original data.table version, maintaining fast data.table merge
# Run time mostly downloads

# Subsets to state of interest from a vector of attribute .csv file names,
# then builds a list of csv data; note COMID ordering over rows differs across tables, but all appear equivalently present 
# Drops some identical/redundant columns and reshapes

#KY, SD, NE failed on a few duplicate row names/COMID, now tests and removes
#could add various other fussy bits: check for correct capitalization, allow full state names, etc.

getStreamCatST = function(state, #2 character abbreviation
                          repos = "ftp://newftp.epa.gov/EPADataCommons/ORD/NHDPlusLandscapeAttributes/StreamCat/States/",
                          dirOut = NULL,
                          rds = T
){
   if (!require("RCurl")) { install.packages("RCurl", dependencies = TRUE); library(RCurl)}
   if (!require("data.table")) { install.packages("data.table", dependencies = TRUE) } #; library(data.table)
   if (!require("dplyr")) { install.packages("dplyr", dependencies = TRUE); library(dplyr)}
   
   attribfn = sub("\r", "", strsplit(getURL(repos, dirlistonly = TRUE), "\n")[[1]])
   attribfnst = paste0(repos,grep(paste0("_",state), attribfn, value=T))

   stsc1 = data.table::fread(attribfnst[1], data.table = T)  #no stringsAsFactors = F since no strings
   data.table::setkey(stsc1, COMID)
   stsc = lapply(attribfnst[2:length(attribfnst)]
                 ,data.table::fread
                 ,drop=c("CatAreaSqKm","CatPctFull","WsAreaSqKm","WsPctFull")
                 ,data.table = T)
   lapply(stsc, data.table::setkey, COMID)
   stsc = Reduce(function(x,y) merge(x, y, by="COMID"), stsc)
   stsc = merge(stsc1, stsc, by="COMID") #still a data.table
   if(anyDuplicated(stsc)>0) {
      print("Duplicate COMID ID rows removed from data.table")
      stsc = unique(stsc)
      }

   stsc = tbl_df(stsc) #convert class to dplyr (leaves attributes)   
   stsc$stabb = state
   row.names(stsc) = as.character(stsc$COMID)
   if(!is.null(dirOut)) {
      if(rds) {
         saveRDS(stsc, file=paste0(dirOut,"/catdata",state,".rds")) } else {
            write.csv(stsc, file=paste0(dirOut,"/catdata",state,".csv"), row.names = F)
         }
      }
      
   return(stsc)
} #end getStreamCat
