is_line(opts) = make_line(opts, 0.5, 0.5, -0.4, L"IS", 1);

lm_line(opts) = make_line(opts, 0.5, 0.5, 0.5, L"LM", 2);

function is_lm_blank()
    opts = GraphOptions(; xlabel = "Y", ylabel = "i");
    lineV = [is_line(opts), lm_line(opts)];
    pointV = [make_point(0.5, 0.5; xLabel = L"Y^*", yLabel = L"i^*")];
    g = Graph(opts, lineV, pointV);
    return g
end

# --------------