using Plots

tldr = include("/home/bcferrari/Code/TLDR/src/TLDR.jl")

tops = tldr.jldopen("./brian.jld2")["tops"]



name = joinpath(@__DIR__, "output" "script1.png")
savefig(name)
