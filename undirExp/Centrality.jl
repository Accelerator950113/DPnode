include("Graph.jl")

using LinearAlgebra
using SparseArrays

function Degree(G)
    C = zeros(G.n)
    for (ID, u, v, w) in G.E
        C[u] += w
        C[v] += w
    end
    return C
end

function spA(G)
    Is = zeros(Int, G.m*2)
    Js = zeros(Int, G.m*2)
    Vs = zeros(G.m*2)
    for (ID, u, v, w) in G.E
        Is[ID] = u
        Js[ID] = v
        Vs[ID] = w
        Is[G.m + ID] = v
        Js[G.m + ID] = u
        Vs[G.m + ID] = w
    end
    return sparse(Is, Js, Vs, G.n, G.n)
end

function alpP(G, alp)
    d = Degree(G)
    Is = zeros(Int, G.m*2)
    Js = zeros(Int, G.m*2)
    Vs = zeros(G.m*2)
    for (ID, u, v, w) in G.E
        Is[ID] = u
        Js[ID] = v
        Vs[ID] = alp * w / d[v]
        Is[G.m + ID] = v
        Js[G.m + ID] = u
        Vs[G.m + ID] = alp * w / d[u]
    end
    return sparse(Is, Js, Vs, G.n, G.n)
end

function BetweennessCentrality(G)
    g = Array{Array{Int32, 1}, 1}(undef, G.n)
    foreach(i -> g[i] = [], 1 : G.n)
    for (ID, u, v, w) in G.E
        push!(g[u], v)
        push!(g[v], u)
    end
    C = zeros(G.n)
    p = Array{Array{Int32, 1}, 1}(undef, G.n)
    d = zeros(Int32, G.n)
    S = zeros(Int32, G.n+10)
    sigma = zeros(G.n)
    Q = zeros(Int32, G.n+10)
    delta = zeros(G.n)
    for s = 1 : G.n
        foreach(i -> p[i] = [], 1 : G.n)
        top = 0
        sigma .= 0
        sigma[s] = 1.0
        d .= -1
        d[s] = 0
        front = 1
        rear = 1
        Q[1] = s

        while front <= rear
            v = Q[front]
            front += 1
            top += 1
            S[top] = v
            for w in g[v]
                if d[w] < 0
                    rear += 1
                    Q[rear] = w
                    d[w] = d[v] + 1
                end
                if d[w] == (d[v] + 1)
                    sigma[w] += sigma[v]
                    push!(p[w], v)
                end
            end
        end

        delta .= 0

        while top > 0
            w = S[top]
            top -= 1
            for v in p[w]
                delta[v] += ((sigma[v] / sigma[w]) * (1 + delta[w]))
                if w != s
                    C[w] += delta[w]
                end
            end
        end

    end

    return C
end

function ClosenessCentrality(G)
    g = Array{Array{Int32, 1}, 1}(undef, G.n)
    foreach(i -> g[i] = [], 1 : G.n)
    for (ID, u, v, w) in G.E
        push!(g[u], v)
        push!(g[v], u)
    end
    C = zeros(G.n)
    d = zeros(Int32, G.n)
    Q = zeros(Int32, G.n+10)
    for s = 1 : G.n
        d .= -1
        d[s] = 0
        front = 1
        rear = 1
        Q[1] = s

        while front <= rear
            v = Q[front]
            front += 1
            for w in g[v]
                if d[w] < 0
                    rear += 1
                    Q[rear] = w
                    d[w] = d[v] + 1
                end
            end
        end

        C[s] = sum(d)
    end

    foreach(i -> C[i] = 1.0 / C[i], 1 : G.n)

    return C
end

function ForestDistanceClosenessCentrality(G)
    # get Forest Matrix
    IpL = zeros(G.n, G.n)
    for (ID, u, v, w) in G.E
        IpL[u, u] += w
        IpL[v, v] += w
        IpL[u, v] -= w
        IpL[v, u] -= w
    end
    foreach(i -> IpL[i, i] += 1, 1 : G.n)
    W = inv(IpL)

    # calculate FDC
    trace = tr(W)
    C = zeros(G.n)
    foreach(i -> C[i] = 1.0 / (G.n * W[i, i] + trace - 2), 1 : G.n)

    return C
end

function InformationCentrality(G)
    # get pseudo inverse of L
    L = zeros(G.n, G.n)
    for (ID, u, v, w) in G.E
        L[u, u] += w
        L[v, v] += w
        L[u, v] -= w
        L[v, u] -= w
    end
    L .+= (1 / G.n)
    Lp = inv(L)
    Lp .-= (1 / G.n)

    # calculate Information Centrality
    trace = tr(Lp)
    C = zeros(G.n)
    foreach(i -> C[i] = G.n / (G.n * Lp[i, i] + trace), 1 : G.n)

    return C
end

function PageRank(G; alpha = 0.85)
    aP = alpP(G, alpha)
    C = zeros(G.n)
    C[1] = 1.0
    adC = ((1.0 - alpha) / G.n) * ones(G.n)

    while true
        pC = copy(C)
        C = aP * C + adC
        if norm(C - pC) < 1e-12
            break
        end
    end

    return C
end

function EigenvectorCentrality(G)
    C = zeros(G.n)
    C[1] = 1.0
    A = spA(G)

    while true
        pC = copy(C)
        C = A * C
        C ./= C[argmax(C)]
        if norm(C - pC) < 1e-9
            break
        end
    end

    return C
end
