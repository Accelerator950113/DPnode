include("Graph.jl")

using SparseArrays
using LinearAlgebra

function OutDegree(G)
    C = zeros(G.n)
    for (u, v, w) in G.E
        C[u] += w
    end
    return C
end

function spA(G)
    Is = zeros(Int, G.m)
    Js = zeros(Int, G.m)
    Vs = zeros(G.m)
    ID = 0
    for (u, v, w) in G.E
        ID += 1
        Is[ID] = u
        Js[ID] = v
        Vs[ID] = w
    end
    return sparse(Is, Js, Vs, G.n, G.n)
end

function alpP(G, alp)
    d = OutDegree(G)
    Is = zeros(Int, G.m)
    Js = zeros(Int, G.m)
    Vs = zeros(G.m)
    ID = 0
    for (u, v, w) in G.E
        ID += 1
        Is[ID] = v
        Js[ID] = u
        Vs[ID] = alp * w / d[u]
    end
    return sparse(Is, Js, Vs, G.n, G.n)
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

function getPc(C; eps = 1e-9)
    A = copy(C)
    n = size(A, 1)
    sort!(A)
    sum = 0.0
    for i = 1 : n
        ts = 0.0
        for j = i-1 : -1 : 1
            if abs(A[i] - A[j]) < eps
                ts += 1.0
            else
                break
            end
        end
        for j = i+1 : n
            if abs(A[i] - A[j]) < eps
                ts += 1.0
            else
                break
            end
        end
        sum += ts
    end
    sum /= (n * (n - 1))
    return (1.0 - sum) * 100
end
