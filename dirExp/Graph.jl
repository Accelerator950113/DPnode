struct DiGraph
    n :: Int32 # |V|
    m :: Int32 # |E|
    V :: Array{String, 1} # V[i] = Real Label of node i
    E :: Array{Tuple{Int32, Int32, Float64}, 1} # <u, v, w> in Edge Set
end

function readDiGraph(fileName) # Read a directed graph from a file
    n = 0
    V = Array{String, 1}()
    label = Dict{String, Int32}()
    W = Dict{Tuple{Int32, Int32}, Float64}()

    getid(x) = begin
        if !haskey(label, x)
            n += 1
            label[x] = n
            push!(V, x)
            return n
        end
        return label[x]
    end

    open(fileName) do f1
        for line in eachline(f1)
            buf = split(line)
            u = getid(buf[1])
            v = getid(buf[2])
            if u == v
                continue
            end
            if haskey(W, (u, v))
                W[(u, v)] += 1.0
            else 
                W[(u, v)] = 1.0
            end
        end
    end

    m = length(W)
    E = Array{Tuple{Int32, Int32, Float64}, 1}()
    for (u, v) in keys(W)
        push!(E, (u, v, W[(u, v)]))
    end

    return DiGraph(n, m, V, E)
end

function getAdjacentList(G :: DiGraph)
    g = Vector{Vector{Int32}}(undef, G.n)
    foreach(i -> g[i] = Vector{Int32}(), 1 : G.n)
    for (u, v, w) in G.E
        push!(g[u], v)
    end
    return g
end

function SubDiGraph(G :: DiGraph, C, xx)
    n = 0
    h = zeros(Int32, G.n)
    V = Vector{String}()
    for i = 1 : G.n
        if C[i] == xx
            n += 1
            h[i] = n
            push!(V, G.V[i])
        end
    end

    E = Vector{Tuple{Int32, Int32, Float64}}()
    for (u, v, w) in G.E
        if h[u] != 0 && h[v] != 0
            push!(E, (h[u], h[v], w))
        end
    end

    return DiGraph(n, size(E, 1), V, E)
end

function LSCC(G :: DiGraph)
    g = getAdjacentList(G)
    dfn = zeros(Int32, G.n)
    low = zeros(Int32, G.n)
    index = 0
    S = Vector{Int32}()
    C = zeros(Int32, G.n)
    inStack = zeros(Bool, G.n)

    dfs(u) = begin
        index += 1
        dfn[u] = index
        low[u] = index
        push!(S, u)
        inStack[u] = true
        for v in g[u]
            if dfn[v] == 0
                dfs(v)
                low[u] = min(low[u], low[v])
            elseif inStack[v]
                low[u] = min(low[u], dfn[v])
            end
        end
        if dfn[u] == low[u]
            while true
                v = pop!(S)
                inStack[v] = false
                C[v] = u
                if u == v
                    break
                end
            end
        end
    end

    for i = 1 : G.n
        if dfn[i] == 0
            dfs(i)
        end
    end

    sz = zeros(Int32, G.n)
    foreach(x -> sz[x] += 1, C)
    xx = argmax(sz)

    return SubDiGraph(G, C, xx)
end

