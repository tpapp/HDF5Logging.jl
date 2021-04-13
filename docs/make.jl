# RUN update-readme.sh MANUALLY

using Documenter, DocumenterMarkdown, HDF5Logging

makedocs(
    modules = [HDF5Logging],
    format = DocumenterMarkdown.Markdown(),
    authors = "Tamas K. Papp",
    sitename = "HDF5Logging.jl",
    pages = Any["index.md"],
    # strict = true,
    # clean = true,
    checkdocs = :exports,
)
