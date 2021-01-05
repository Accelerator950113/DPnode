#!/bin/sh
for var in email-dnc egoTwitter emailEuAll socEpinions1 wikiVote ;do
    julia -O3 Main.jl $var
done