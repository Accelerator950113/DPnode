include("Graph.jl")
include("Centrality.jl")

function doExp(ags1) 
    G0 = readDiGraph("data/"*ags1*".txt")
    G = LSCC(G0)
    lg = open("log.txt", "a")
    println(lg, ags1, " ", G0.n, " ", G0.m, " ", G.n, " ", G.m)
    println(lg, "PageRank : ", getPc(PageRank(G)))
    println(lg, "Eigenvector : ", getPc(EigenvectorCentrality(G)))
    println(lg)
end

doExp(ARGS[1])