using ClassFigures
using Documenter

DocMeta.setdocmeta!(ClassFigures, :DocTestSetup, :(using ClassFigures); recursive=true)

makedocs(;
    modules=[ClassFigures],
    authors="hendri54 <hendricksl@protonmail.com> and contributors",
    repo="https://github.com/hendri54/ClassFigures.jl/blob/{commit}{path}#{line}",
    sitename="ClassFigures.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
