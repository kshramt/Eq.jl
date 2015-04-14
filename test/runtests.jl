import Base.Test: @test, @test_throws, @test_approx_eq

unshift!(LOAD_PATH, joinpath(dirname(@__FILE__), "..", "src"))
import Eq


let
    @test_approx_eq Eq.Mw_of_m0(10^24.1) 10
    @test_approx_eq Eq.Mw_of_m0(10^21.1) 8
    for m0 in 0.1:0.11:10
        @test_approx_eq Eq.m0_of_Mw(Eq.Mw_of_m0(m0)) m0
    end
end


let
    m = Eq.MomentTensor(1, 2, 3, 4, 5, 6)
    @test_approx_eq Eq.xyz(m) [1 4 5
                               4 2 6
                               5 6 3]
    @test_approx_eq Eq.rtf(m) [+3 -6 +5
                               -6 +2 -4
                               +5 -4 +1]
end


let
    for _ in 1:10
        @test Eq.is_valid_general_elastic_tensor(Eq.symmetrize_general_elastic_tensor!(rand(3, 3, 3, 3) + 0.1))
    end
end
