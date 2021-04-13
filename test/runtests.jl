using HDF5Logging
using Test
using Logging

@testset "log consistency" begin
    file = tempname() * ".hdf5"
    logger = hdf5_logger(file)
    with_logger(logger) do
        @info "test info" a = 1 b = 2
        @warn "test warn" c = 9
    end
    @test length(logger) == 2
    msg1 = logger[1]
    @test msg1.level == Logging.Info
    @test sort(msg1.data, by = first) == ["a" => 1, "b" => 2]
    msg2 = logger[2]
    @test msg2.level == Logging.Warn
    @test msg2.data == ["c" => 9]
end
