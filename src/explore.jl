using ClassFigures, CairoMakie;

g = ClassFigures.is_lm_blank();

# make function that shifts an existing line +++++
is2 = FLine(0.7, 0.5, -0.3, ClassFigures.gopt(g, :lineWidth), "IS", 
    ClassFigures.color_one(g.opts, 3));
ClassFigures.add_line!(g, is2);

# add arrows that indicate shifting lines +++++
# with labels

fig, ax = make_graph(g);

testFn = "/Users/lutz/Documents/temp/test_fig1.pdf";
save(testFn, fig);

# -------------