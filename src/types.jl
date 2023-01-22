Base.@kwdef mutable struct FLine
	x :: Float64
	y :: Float64
	slope :: Float64
	lineWidth :: Float64 = 2.0
	label :: String = ""
end

# -------------