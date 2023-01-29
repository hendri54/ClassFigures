module ClassFigures

using ArgCheck, CairoMakie, DocStringExtensions, LaTeXStrings;

export FLine;
export plot_defaults;
export render_graph, new_fig_axis;
export make_line, shift_line, shift_line!, intercept, y_value;
export add_intersection!;

# Plots set this as axis range
const AxisMin = 0.0;
const AxisMax = 1.0;

include("types.jl");
include("lines.jl");
include("point.jl");
include("graph.jl");

include("islm.jl");

function plot_defaults()
    set_theme!(theme_minimal());
	return GraphOptions(; textSize = 26, labelSize = 26)
end

function color_list(opts :: GraphOptions)
	return cgrad(opts.colorScheme, opts.nColors)
end

function color_one(opts, j)
	@assert 1 <= j <= opts.nColors;
	return color_list(opts)[j]
end

function test_dir()
	return joinpath(first(splitdir(@__DIR__)), "testfiles");
end


end

# -----------------------