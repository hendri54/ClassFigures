"""
	$(SIGNATURES)

Given a `Graph`, render it as a `Figure` and `Axis`.
"""
function render_graph(g :: Graph)
    fig, ax = new_fig_axis(g);
    for (j, l) in enumerate(g.lines)
        add_line!(ax, l);
    end
	for p in g.points
		add_point!(ax, p, g.opts);
	end
    return fig, ax
end

function new_fig_axis(g :: Graph)
	fig = Figure();
	ax = fig[1,1] = Axis(fig; 
        bottomspinecolor = axis_color(g),
        leftspinecolor = axis_color(g),
        spinewidth = axis_linewidth(g),
		xlabel = axis_label(g, :x), ylabel = axis_label(g, :y), 
		xlabelsize = label_size(g), ylabelsize = label_size(g),
		xgridvisible = false, ygridvisible = false,
		xticklabelsvisible = true, yticklabelsvisible = true,
        xticklabelsize = label_size(g), yticklabelsize = label_size(g));
    xlims!(ax, 0.0, 1.0);
    ylims!(ax, 0.0, 1.0);
    set_xticks!(ax, g.points);
    set_yticks!(ax, g.points);
    return fig, ax
end

function set_xticks!(ax :: Axis, pointV)
    if !isempty(pointV)
        xV = [p.x  for p in pointV];
        lblV = [p.xLabel  for p in pointV];
        ax.xticks = (xV, lblV);
    end
end

function set_yticks!(ax :: Axis, pointV)
    if !isempty(pointV)
        yV = [p.y  for p in pointV];
        lblV = [p.yLabel  for p in pointV];
        ax.yticks = (yV, lblV);
    end
end


add_line!(g :: Graph, l) = push!(g.lines, l);
add_point!(g :: Graph, p :: Point) = push!(g.points, p);

function find_line(g :: Graph, lbl)
    findfirst(ln -> (ln.label == lbl), g.lines);
end

function get_line(g :: Graph, lbl)
    idx = find_line(g, lbl);
    @assert !isnothing(idx)  "Line $lbl not found";
    return g.lines[idx]
end

function shift_line!(g :: Graph, oldLabel, newLabel, direction, amount)
    lineNo = find_line(g, oldLabel);
    @assert !isnothing(lineNo)  "Line $oldLabel not found";
    newLine = shift_line(g.opts, g.lines[lineNo], direction, amount; newLabel);
    add_line!(g, newLine);
end

function add_intersection!(g :: Graph, lbl1, lbl2; xLabel = "", yLabel = "",
        pointLabel = "")
    ln1 = get_line(g, lbl1);
    ln2 = get_line(g, lbl2);
    x, y = intersection(ln1, ln2);
    p = make_point(x, y; xLabel, yLabel, pointLabel);
    add_point!(g, p);
end


## ------------  Access

gopt(g :: Graph, opt) = getproperty(g.opts, opt);

function axis_label(g :: Graph, xy)
    if xy == :x
        lbl = gopt(g, :xlabel);
    else
        lbl = gopt(g, :ylabel);
    end
    return L"\textbf{%$lbl}";
end

text_size(g :: Graph) = gopt(g, :textSize);
label_size(g :: Graph) = gopt(g, :labelSize);
axis_color(g :: Graph) = gopt(g, :axisColor);
axis_linewidth(g :: Graph) = gopt(g, :axisLineWidth);


# ---------------