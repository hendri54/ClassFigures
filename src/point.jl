function make_point(x, y; pointLabel = "", xLabel = "", yLabel = "")
    return Point(x, y, pointLabel, xLabel, yLabel, :blue)  # set color +++++
end

function add_point!(ax :: Axis, p :: Point, opts)
    scatter!(ax, p.x, p.y; color = opts.axisColor, markersize = 20);
    add_vertical!(ax, p, opts);
    add_horizontal!(ax, p, opts);
end

function add_vertical!(ax, p, opts)
    add_point_line!(ax, p, [p.x, p.x], [0, p.y], opts);
end

function add_horizontal!(ax, p, opts)
    add_point_line!(ax, p, [0.0, p.x], [p.y, p.y], opts);
end

function add_point_line!(ax, p, xV, yV, opts)
    lines!(ax, xV, yV; linestyle = :dot, 
        linewidth = opts.axisLineWidth, color = opts.axisColor);
end

# color? +++++
# not clear how to write text outside of axis
# better set using xticks? (can be done incrementally?)
function add_x_axis_text!(ax :: Axis, xPos, txt)
    if !isempty(txt)
        text!(ax, xPos, 0.02; text = txt, fontsize = 24, color = :green);
    end
end

# ------------