# streamcatUtils
R utility functions for using StreamCat datasets


##Description: 
Please see
https://github.com/USEPA/StreamCat
and 
http://www2.epa.gov/national-aquatic-resource-surveys/streamcat
for info on the StreamCat products and processes.

This repo contains working scripts for accessing and manipulating StreamCat data within the [R language](http://cran.us.r-project.org/) and [RStudio](https://www.rstudio.com/).

Scripts depend on an updated base R installation as well as various packages. Some effort has been made to ensure that dependencies are installed and loaded, but this is firmly "research grade" scripting - **_CAVEAT EMPTOR!_**

##Functions

 + [scu\_getStreamCatST](https://github.com/daauerbach/streamcatUtils/blob/master/scu_getStreamCatST.R) takes a 2-character (caps) state abbreviation and returns a tbl_df dataframe of n-obs COMIDs with n-features ("attributes" or columns) using data.table::fread. It currently scrapes all available data per state but could be easily modified to return selected features/columns. Run time is mostly downloads. Objects can optionally be retained as .rds, which can provide substantial storage benefits over .csv (which are also easily written out).



## Disclaimer
This code is provided on an "as is" basis and the user assumes responsibility for its use.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring.

