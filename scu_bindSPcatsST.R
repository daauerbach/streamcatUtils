#Helper to create (possibly) multi-state sp objects from vector of "ST" abbreviations
# !! requires a directory of NHDplus cat polygon shapefiles (by state)
# versions by VPU are available from Horizon: http://www.horizon-systems.com/NHDPlus/V2SimpleCat.php
bindSPcatsST = function(states
                        ,dirPolys
                        ,pts = T #convert to SpatialPoints at centroids, useful for faster plotting
){
   if (!require("sp")) { install.packages("sp", dependencies = TRUE); library(sp) }
   if (!require("rgdal")) { install.packages("rgdal", dependencies = TRUE); library(rgdal) }
   
   rsp = lapply(states, function(st) readOGR(dirPolys, layer=paste0("_",st)) )
   rsp = do.call(rbind,
                 lapply(1:length(states), function(i) {
                    spChFIDs(rsp[[i]], paste(states[i],row.names(rsp[[i]]),sep="_")) 
                 })
   )
   rsp = rsp[!duplicated(rsp$FEATUREID),]
   if(pts) {
      rsp = SpatialPointsDataFrame(coords = coordinates(rsp)
                                   ,data = rsp@data
                                   ,proj4string = rsp@proj4string)
   }
   return(rsp)
} #end function
