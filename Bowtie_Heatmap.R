##To compile the final output from the Bowtie Process_data.py into a nice heatmap for ease of consuption:


## install the following R libraries
library(readr)
library(readxl)
library(tidy)
library(dplyr)
library(scales)
library(ggplot)

##Set working directory to where the final table csv file was made from the data_process.py
setwd("~/USER/path/to/table")

##input the created dataframe into R
bin_abundance_table_tab <- read_excell("DATE_TIME_process_results.xls")
View(bin_abundance_table_tab)

##Gather the samples into a tidy dataframe that will turn the samples and the reads into a tidy df.
MAG_heatmap <- bin_abundance_table_tab %>%
  gather(Sample, Reads, 2:bin_abundance_table_tab[,ncol(bin_abundance_table_tab)])

#Idividual mutations of the dataframe to read the numbers and names.

MAG_heatmap$Sample <- as.character(MAG_heatmap$Sample)

MAG_heatmap$Reads <- as.numeric(MAG_heatmap$Reads)

#round to the lowest integer
MAG_heatmap$Reads <- floor(MAG_heatmap$Reads)

##Can input the order that you want your samples to appear
MAG_heatmap$Sample <- factor(MAG_heatmap$Depth, levels=c( "name", "name", "name", "name", "name", "name"))

##If there are any bins that you want to highlight later you can add their name into here
hqbins <- c("bin_name0", "bin_name1", "bin_name2" ... "bin_nameN")

##to bring attention to some names of the bins use this to highlight that text in the plot input those names
x <- ifelse(MAG_heatmap$MAG %in% 
              c("important_bin_name1", "important_bin_name2", "important_bin_name3"), "blue", "black")

##to use it the sample names have a '_' and if we dont want to see those in the R plot.
#MAG_heatmap$MAG_and_phyla_name <- gsub("\\_"," ",MAG_heatmap$MAG_and_phyla_name)

#For non scientific fill values

my_breaks = c(20, 2000, 10000, 22000)

MAGs_heatmap_plot <- ggplot(data = MAG_heatmap, aes(x =MAG_and_phyla_name, y = Depth)) +
  geom_tile(aes(fill = Reads)) +
  xlab("Sample Depth and MAG") +
  ylab("Depth (m)") + 
  scale_fill_gradient(low = "white", high = "black",
                      name = "RPKM", trans = "log",
                      breaks = my_breaks, labels = my_breaks) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 65, size = 9, hjust = 1, colour = x, face ="bold"),
        axis.text.y = element_text(size = 11))


view(MAGs_heatmap_plot)
