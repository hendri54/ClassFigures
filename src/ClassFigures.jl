module ClassFigures

using CairoMakie, DocStringExtensions;

include("types.jl");
include("lines.jl");

function plot_defaults()
    set_theme!(theme_minimal());
end

function new_fig_axis(xlabel, ylabel)
	fig = Figure();
	ax = fig[1,1] = Axis(fig; xlabel, ylabel, 
		xticklabelsvisible = true, yticklabelsvisible = true);
	return fig, ax
end

end
