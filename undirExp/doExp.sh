#!/bin/sh
for var in Karate Dolphins Celegans Diseasome GridMouse CrimeMoreno WikiVote Reed98 EmailUniv GridPlant Yeast Hamster USFCA72 NipsEgo GridWorm GrQc USgrid Erdos992 Advogato Bcspwr10 Reality PagesGovernment WikiElec Dmela HepPh Anybeat PagesCompany AstroPh CondMat Gplus ;do
    julia -O3 Main.jl $var
done
