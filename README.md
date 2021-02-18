## NEW-bowtie
All bowite output python script and files to make a reads per kilobase per million mapped reads table.

# README:
_What you provide_: The .txt files of the bins/mags/files to be mapped. The .csv files from the whole sample that are interested in finding the number of Reads per kilobase per million mapped reads.
_The output_: A final table with each organism (txt file) and its calculated ‘mapped reads’ per file (csv file). (See mapped-reads-table-goal.txt)


More elaborate, including acronym descriptions:

A metagenome is a sampled and sequenced and then computer complied group of DNA to study the DNA in that environment. Metagenomes because ‘meta’ is the ‘behind the curtain’ kind of science, and then genome because its constructing organisms with all the puzzle pieces of DNA retrieved. A  MAG is a "metagenome assembled genome”. This is one organism solely constructed from the DNA retrieved from the metagenome. Sometimes you have a complete genome and sometimes not so complete. We know completeness by comparing the genes in a genome to other known organisms. 
The goal of this script is to take the generated outputs from Bowtie2 and summarize them into a table.

Because there are a lot of organismal DNA in a metagenome it is important to see which pieces of those DNA segments went into a MAG and which did not. Further, it is also important to see which patterns of ~250 nucleotides (A,G, C, and T) appear the most often. 

Each organism (or MAG) is a .txt file. In this text file it has the list of all the DNA puzzle pieces (contigs; short for contiguous - for contiguous string of DNA) that make up its genome. The csv file is the metagenome, and it has the (contigs) DNA puzzle pieces name (NODE_##_length_######_cov_##.#####) in col1, col2 is the gene length again, col3 is the number of mapped reads, and col4 is unmapped reads, which is always 0.

In the script, I decided to add another input variable after the data_directory to be the metagenome information “Total_Reads_ALL_Sample.txt". This file has the sample depth (the depth below the Siberian Russian Tundra surface (m) the metagenome came from) the total number of read (or contigs, or puzzle pieces) and the total # of reads already divided by 1 million ((A common stat used in bioinformatics because the size of the metagenome can be very large.

The script is to use the list of the contigs in each of the MAGs (.txt files) and find that contig in the metagenome (csv file) and apply the number of maps in the eq’n seen on line 70 of the script; which is the number of the maps /[ (gene length/1000) * (total # of reads in that metagenome/1000000)] -> a /((b/1000)x (c/1,000,000)]; where a is the third col in every csv file, b is the second col in the csv file, and c is the last col in the Total_Reads_ALL_Sample.txt. The trick is to find the contigs that match in MAG and the metagenome, apply the calculation, sum all of the individual calculations into one table.

## After you get the final table file:

You can make a heat map with the final table that will help you identify the abundance of the item that was mapped (bin/MAG/list of specific genes) to the sample.
To do this in R: use Bowtie_Heatmap.R file.
