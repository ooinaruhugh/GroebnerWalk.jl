using Oscar
using GroebnerWalk
using Documenter, DocumenterCitations

Base.print(io::IO, b::Base.Docs.Binding) = print(io, b.var)
bib = CitationBibliography(
  joinpath(@__DIR__, "citations.bib");
  style=:alpha
)

s = read(joinpath(@__DIR__, "doc.main"), String)
doc = eval(Meta.parse(s))

makedocs(;
  format=Documenter.HTML(;prettyurls=true),
  sitename="GroebnerWalk.jl",
  pages=doc,
  plugins=[bib],
)

deploydocs(
  repo="github.com/ooinaruhugh/GroebnerWalk.jl.git"
)
