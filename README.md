# DPnode
code for **Discriminating Power of Centrality Measures in Complex Networks**  
## Experiment Code
*undirExp* --> Experiment on undirected unweighted networks  
*dirExp* --> Experiment on directed weighted networks  
Julia v1.5.3 is required.  
Download julia on : https://julialang.org  
The network data is available on : http://networkrepository.com and https://snap.stanford.edu  
Start experiments with
```shell
sh undirExp/doExp.sh
sh dirExp/doExp.sh
```
## Excel Table of Table V
See **Table-V.xlsx**   
## Code for Generating Pictures
*PictureCode* --> Metapost code for generating Figure 1 and 2 in the paper  
Generate pictures by
```shell
mpost PictureCode/Figure1.mp
mpost PictureCode/Figure2.mp
```
