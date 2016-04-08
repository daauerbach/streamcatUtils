# streamcatUtils
R utility functions for using StreamCat datasets



##Description 
Please see
https://github.com/USEPA/StreamCat
and 
http://www2.epa.gov/national-aquatic-resource-surveys/streamcat
for info on the StreamCat products and processes.

This repo contains in-progress scripts for accessing and manipulating StreamCat data within the [R language](http://cran.us.r-project.org/) and [RStudio](https://www.rstudio.com/).

Scripts depend on an updated base R installation as well as various packages. Some effort has been made to ensure that dependencies are installed and loaded, but this is firmly "research grade" scripting - **_CAVEAT EMPTOR!_**

Functions can be individually source()'d in a session via [devtools::source_url](http://www.inside-r.org/packages/cran/devtools/docs/source_url), for example: (note "raw" url)
```R
source_url("https://raw.githubusercontent.com/daauerbach/streamcatUtils/master/scu_getStreamCatST.R")
```

To build or refresh a library of streamCat state objects:
```R
for(s in state.abb[-grep("AK|HI", state.abb)]) getStreamCatST(s, dirOut = "YourDirectoryName")
```

##Functions

 + [scu\_getStreamCatST](https://github.com/daauerbach/streamcatUtils/blob/master/scu_getStreamCatST.R) takes a single 2-character CAPS state abbreviation as in [state.abb](http://www.inside-r.org/r-doc/datasets/state) and returns a tbl_df dataframe of n-obs COMIDs with n-features ("attributes" or columns) using data.table::fread directly on ftp csv files. It currently scrapes all available data per state but could be easily modified to return only selected features/columns. Run time is mostly downloads and may be several minutes for larger states and/or slow connections. Objects can optionally be retained as .rds, which can provide substantial storage benefits over .csv (which are also easily written out).

 + [scu\_bindStreamCatST](https://github.com/daauerbach/streamcatUtils/blob/master/scu_bindStreamCatST.R) is a convenience function that takes a character vector of CAPS state abbreviations and returns a single tbl_df object, removing any duplicate cats/COMIDs. 

 + [scu\_bindSPcatsST](https://github.com/daauerbach/streamcatUtils/blob/master/scu_bindSPcatsST.R) is also convenience function that takes a character vector of CAPS state abbreviations and returns a single sp(atial) object, by default a SpatialPointsDataFrame drawn from polygon centroids (via coordinates()) or if pts = F the underlying polygons (also removing any duplicate cats/COMIDs in either case). _*NOTE THIS CURRENTLY DEPENDS ON A DIRECTORY OF NHDplus CAT POLYGONS SPLIT BY STATE*_ Comparable simplified shapefiles [are here](http://www.horizon-systems.com/NHDPlus/V2SimpleCat.php) from Horizon Systems, but organized by VPU.

##Objects

 + *regulatoryStateLists.rds* is a small convenience object with vectors of state abbreviations for the 10 EPA regions and 36 Army Corps regulatory districts (excluding Alaska/POA and Hawaii/POH)

 + *focalfeatWs.rds* is a convenience named list of vectors of Ws (upstream NHDPlus watershed) features in StreamCat


## Disclaimer
This code is provided on an "as is" basis and the user assumes responsibility for its use.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring.

