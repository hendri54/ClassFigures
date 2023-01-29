function make_line(opts, x :: Number, y :: Number, slope :: Number, lbl, lineNo :: Integer)
	return FLine(x, y, slope, opts.lineWidth, lbl, color_one(opts, lineNo))
end

function shift_line(opts, ln, direction, amount; newLabel = nothing)
	x, y = compute_shift(ln.x, ln.y, direction, amount);
	newColor = shift_color(opts, ln.color);
	if isnothing(newLabel)
		lbl = ln.label;
	else
		lbl = newLabel;
	end
	return FLine(x, y, ln.slope, ln.lineWidth, lbl, newColor)
end

function compute_shift(x, y, direction, amount)
	if direction == :up
		return x, y + amount
	elseif direction == :down
		return x, y - amount
	elseif direction == :left
		return x - amount, y
	elseif direction == :right
		return x + amount, y
	else
		error("Unknown direction $direction");
	end
end

function shift_color(opts, oldColor)
	# dummy +++++
	return oldColor
end

# y(0)
intercept(fl :: FLine) = fl.y - fl.slope * fl.x;

# x(y = 0)
y_intercept(fl :: FLine) = x_value(fl, 0.0);

x_value(fl :: FLine, y) = (y - intercept(fl)) / fl.slope;
y_value(fl :: FLine, x) = intercept(fl) + fl.slope .* x;

function left_point(fl :: FLine)
    if fl.slope >= 0.0
        xMin = max(0.0, y_intercept(fl));
    else
        xMin = 0.0;
    end
	
	yMin = y_value(fl, xMin);
	return xMin, yMin
end

function right_point(fl :: FLine)
	xMax = 1.0;
	yMax = intercept(fl) + fl.slope * xMax;
	return xMax, yMax
end

# pass options via struct +++++
function add_line!(ax :: Axis, fl :: FLine)
	lft = left_point(fl);
	rgt = right_point(fl);
	line = lines!(ax, [first(lft), first(rgt)], [last(lft), last(rgt)];
		linewidth = fl.lineWidth);

	add_line_label!(ax, line, fl);
end

function add_line_label!(ax :: Axis, line, fl :: FLine)
	if !isempty(fl.label)
		x = 0.95 * AxisMax;
		y = y_value(fl, x);
		if fl.slope >= 0.0
			align = (:right, :bottom);
		else
			align = (:right, :top);
		end
		text!(ax, x, y; text = fl.label, fontsize = 24, color = line.color, align);
	end
end

function intersection(l1 :: FLine, l2 :: FLine)
	if l1.slope == l2.slope
		error("No intersection");
	end
	x = (intercept(l1) - intercept(l2)) / (l2.slope - l1.slope);
	y = y_value(l1, x);
	@check y_value(l2, x) ≈ y_value(l1, x);
	return x, y
end

# --------------