using ClassFigures
using CairoMakie, Test

mdl = ClassFigures;

function lines_test()
    @testset "Lines" begin
        x = 0.5;
        y = 0.5;
        slope = -0.3;
        l1 = FLine(x, y, slope, 2.0, "IS", :red);
        @test y_value(l1, 0.5) ≈ y;
        @test intercept(l1) ≈ y - slope * x;
        @test all(mdl.left_point(l1) .≈ (0.0, intercept(l1)));
        xR, yR = mdl.right_point(l1);
        @test y_value(l1, xR) ≈ yR;

        l2 = FLine(x, y, slope + 0.5, 3.0, "LM", :blue);
        xi, yi = mdl.intersection(l1, l2);
        @test y_value(l1, xi) ≈ y_value(l2, xi) ≈ yi;
    end
end

function islm_test()
    @testset "ISLM" begin
        opts = plot_defaults();
        isl = mdl.is_line(opts);
        @test isl isa FLine;
        lml = mdl.lm_line(opts);
        @test lml isa FLine;
        
        isGraph = mdl.is_lm_blank();
        shift_line!(isGraph, L"LM", L"IS^*", :right, 0.4);
        add_intersection!(isGraph, isl.label, L"IS^*";
            xLabel = L"\hat{Y}", yLabel = L"\hat{i}", pointLabel = L"A");
        fig, ax = render_graph(isGraph);
        fn = joinpath(mdl.test_dir(), "islm_test.pdf");
        save(fn, fig);
    end
end

@testset "ClassFigures" begin
    lines_test();
    islm_test();
end

# ------------------