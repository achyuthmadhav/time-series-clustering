# time-series-clustering
# Master's Capstone Project

Advisor: Prof. Eamonn Keogh, University of California Riverside (https://www.cs.ucr.edu/~eamonn/)

# Abstract
The ubiquitous nature of time series and the need to effectively analyze time series data has provided the motivation for this project. The consensus motif search algorithm is a powerful tool that can retrieve the best repeated structure in a dataset of time series. The objective of this project is to use consensus motifs to cluster the time series into the classes to which they belong. Using the properties of consensus motifs and a forward selection approach a clustering algorithm was developed. Experiments performed on synthetic and real world data provide further evidence that consensus motifs can be used for time series clustering. The MATLAB application developed for this purpose, successfully clustered time series of different classes with high accuracy. The properties of the algorithm and scope for future work has also been covered in this research endeavor.

# Refer the file: 
AchyuthDiwakar_Report.pdf or the link below for detailed info.

# Presentation Link: 
https://docs.google.com/presentation/d/1dhwWNoGYqSQSf99950MuRv9_p5mjjyUWp1GiYD07D8o/edit?usp=sharing

# Datasets: 
UCR Time Series Repository (https://www.cs.ucr.edu/%7Eeamonn/time_series_data_2018/) OR birdsong.zip

# Instructions:

Step 0: The Consensus Motif Algorithm is the property of Prof.Keogh's Lab at UC Riverside. 
        Drop an email to Prof. Keogh (eamonn.keogh@ucr.edu) requesting access and CC: madhav.achyuth@gmail.com

Step 1: Add all the MATLAB files in the repo and consensus motifs scripts (Step 0) to your MATLAB path.

Step 2: Download a time series dataset from the above link (or any CSV/TSV dataset file)

Step 3: Create a synthetic dataset. Run the randwalk_gen.m as follows (num_ts: number of time series, ts_size: size of time series to create)
        >>randwalk_gen(num_ts, ts_size)
        
        
Step 4: Cluster the dataset. Run the consensus_seg.m as follows
        >>consensus_seg(num_ts, subsequence_length)
