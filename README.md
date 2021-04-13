# HDF5Logging.jl

![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg) [![build](https://github.com/tpapp/HDF5Logging.jl/workflows/CI/badge.svg)](https://github.com/tpapp/HDF5Logging.jl/actions?query=workflow%3ACI) [![codecov.io](http://codecov.io/github/tpapp/HDF5Logging.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/HDF5Logging.jl?branch=master)

**`HDF5Logging.hdf5_logger`** &mdash; *Function*.

```julia
hdf5_logger(filename; group_path)
```

Create a logger that write log messages into the HDF5 file `filename` within the given `group_path` (defaults to `"log"`).

**Logging**

A counter keeps track of an increasing integer index. A log message is written to the given `group_path` as a group named with this index (converted to a string), with the following fields:

  * `level::Int`, `message::String`, `_module::String`, `group::String`, `id::String`, `file::String`, `line::String`, which are part of every log message
  * `data`, which contains additional key-value pairs as passed on by the user. Keys are strings.

**Reading logs**

`length(logger)` returns the last index of logged messages, which can be be accessed with `logger[i]`. The latter returns a `NamedTuple`, or `nothing` for no such message.

**Example**

```julia-repl
julia> using HDF5Logging, Logging

julia> logger = hdf5_logger(tempname())
Logging into HDF5 file /tmp/jl_IbbUvj, 0 messages in “log”

julia> # write log

julia> with_logger(logger) do
       @info "very informative" a = 1
       end

julia> # read log

julia> logger[1]
(level = Info, message = "very informative", _module = "Main", group = "REPL[46]", id = "Main_7a40b9cc", file = "REPL[46]", line = 2, data = ["a" => 1])
```

**Notes**

1. The HDF5 file can contain other data, ideally in other groups than `group_path`.
2. Contiguity of message indexes is not checked. This package will create them in order,
starting at 1, but if you delete some with another tool then `getindex` will just return `nothing`.
3. A lock is used, so a shared instance should be thread-safe. That said, **if you open the
same file with another `hdf5_logger`, consequences are undefined.**
4. The HDF5 file is not kept open when not accessed. This is slower, but should help ensure
robust operation.

