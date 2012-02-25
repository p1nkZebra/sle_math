require File.dirname(__FILE__) + '/lib/sle_math'

eqs =<<EQS
x + 2 * (y - x + 3 * z) = z - 2
y / 0.8 - 1.1 * (0.5 * z + 13) = 0
x + z = 10 * (0.2 * y - z / 0.8)
EQS

a, b = SLEMath::Parser::parse_sle_to_matrix(eqs)
p a, b

# TODO implement code below:
#result = SLEMath::Solver::solve(a, b)
#p result
