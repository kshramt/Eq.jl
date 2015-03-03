import Base.Test: @test, @test_throws, @test_approx_eq

unshift!(LOAD_PATH, joinpath(dirname(@__FILE__), "..", "src"))
import Eq

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
