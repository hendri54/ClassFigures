Base.@kwdef mutable struct FLine
	x :: Float64
	y :: Float64
	slope :: Float64
	lineWidth :: Float64 = 2.0
	label :: AbstractString = ""
	color :: Any
end


mutable struct Point
	x :: Float64
	y :: Float64
	pointLabel :: AbstractString
	xLabel :: AbstractString
	yLabel :: AbstractString
	color :: Any
end

Base.@kwdef mutable struct GraphOptions
	textSize :: Int = 20
    lineWidth :: Float64 = 4.0
	xlabel :: AbstractString = ""
	ylabel :: AbstractString = ""
	labelSize :: Int = 20
	colorScheme :: Symbol = :cividis
	axisColor = :gray70
	axisLineWidth :: Int = 3
	nColors :: Int = 10
end


mutable struct Graph
	opts :: GraphOptions
	lines :: Vector{FLine}
	points :: Vector{Point}
end


# -------------