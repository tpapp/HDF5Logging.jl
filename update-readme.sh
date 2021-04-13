# generate readme from docs/src/index.md
julia --project=docs -e '
  using Pkg
  Pkg.develop(PackageSpec(path=pwd()))
  Pkg.instantiate()'
julia --project=docs -e '
  using Documenter: doctest
  using HDF5Logging
  doctest(HDF5Logging)'
julia --project=docs docs/make.jl
cp docs/build/index.md README.md
