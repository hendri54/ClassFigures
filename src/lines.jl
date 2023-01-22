intercept(fl :: FLine) = fl.y - fl.slope * fl.x;

y_value(fl :: FLine, x) = intercept(fl) + fl.slope .* x;

function left_point(fl :: FLine)
	xMin = max(0.0, (0.0 - intercept(fl)) / fl.slope);
	yMin = y_value(fl, xMin);
	return xMin, yMin
end

function right_point(fl :: FLine)
	xMax = 1.0;
	yMax = intercept(fl) + fl.slope * xMax;
	return xMax, yMax
end

function add_line!(ax, fl :: FLine)
	lft = left_point(fl);
	rgt = right_point(fl);
	lines!(ax, [first(lft), first(rgt)], [last(lft), last(rgt)]);

	# Text
	if !isempty(fl.label)
		x = 0.9;
		y = y_value(fl, x) + 0.01;
		text!(ax, x, y, text = fl.label);
	end
end

# --------------