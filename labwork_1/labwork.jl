#yuval.bloom@mail.huji.ac.il
#GraphiBot
#note that there is an ~8ms slippage
#because of 120hz of my phone screen and the 1ms accuracy
#capturing a video of the video also has sync problems and is unrealistic,
#using the original clips is preferred.
using CSV, DataFrames, Plots

df = CSV.read("labwork_1/exp1.csv", DataFrame)

x = parse.(Float64, string.(df[:, 1]))
#the approximate length of the bottle of water is 16cm or 0.16m
#we measured from the bottom, to measure from the center mass it would be L-0.08m
println(x)
x=x.-0.08
println(x)
y = parse.(Float64, string.(Matrix(df[:, 2:end])))

p = scatter(x, y,
    label=["t1" "t2" "t3" "t4" "t5" "t6"],
    xlabel="Pendulum length L (m)",
    ylabel="Pendulum cycle T (s)",
    title="Pendulum Cycle (T) vs Length (L)")

f(L) = 2pi*sqrt(L/9.8)

plot!(p, f, minimum(x), maximum(x), label="Theoretical T(L): 2pi*sqrt(L/9.8)")


savefig(p, "pendulum_exp1.pdf")

p_log = scatter(x, y,
    label=["t1" "t2" "t3" "t4" "t5" "t6"],
    title="Pendulum Cycle vs Length (Log-Log)",
    xlabel="Pendulum length L (m)",
    ylabel="Pendulum cycle T (s)",
    xscale=:log10,
    yscale=:log10)

plot!(p_log, f, minimum(x), maximum(x), label="Theoretical T(L): 2pi*sqrt(L/9.8)")

savefig(p_log, "pendulum_exp1_log.pdf")



p_text = plot(
    framestyle=:none,
    showaxis=false,
    grid=false,
    xlims=(0, 1),
    ylims=(0, 1),
    legend=false,
    title="Julia code for creating the graphs"    
)

code = """
            #note that there is an ~8ms slippage
            #because of 120hz of my phone screen and the 1ms accuracy
            #capturing a video of the video also has sync problems and is unrealistic,
            #using the original clips is preferred.
            using CSV, DataFrames, Plots
            df = CSV.read("labwork_1/exp1.csv", DataFrame)
            x = parse.(Float64, string.(df[:, 1]))
            #the approximate length of the bottle of water is 16cm or 0.16m
            #we measured from the bottom, to measure from the center mass it would be L-0.08m
            println(x)
            x=x.-0.08
            println(x)
            y = parse.(Float64, string.(Matrix(df[:, 2:end])))

            p = scatter(x, y,
                label=["t1" "t2" "t3" "t4" "t5" "t6"],
                xlabel="Pendulum length L (m)",
                ylabel="Pendulum cycle T (s)",
                title="Pendulum Cycle (T) vs Length (L)")

            f(L) = 2pi*sqrt(L/9.8)

            plot!(p, f, minimum(x), maximum(x), label="Theoretical T(L): 2pi*sqrt(L/9.8)")
            savefig(p, "pendulum_exp1.pdf")

            p_log = scatter(x, y,
                label=["t1" "t2" "t3" "t4" "t5" "t6"],
                title="Pendulum Cycle vs Length (Log-Log)",
                xlabel="Pendulum length L (m)",
                ylabel="Pendulum cycle T (s)",
                xscale=:log10,
                yscale=:log10)
            plot!(p_log, f, minimum(x), maximum(x), label="Theoretical T(L): 2pi*sqrt(L/9.8)")
            savefig(p_log, "pendulum_exp1_log.pdf")
    """

annotate!(p_text, 0.02, 0.5, text(code, 4, :left))


p_combined = plot(
    p,
    p_log,
    p_text,
    layout=grid(3, 1, heights=[0.39, 0.39, 0.22]),
    size=(800, 1200)
)

savefig(p_combined, "pendulum_exp1_combined.pdf")