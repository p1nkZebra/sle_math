require File.dirname(__FILE__) + '/spec_helper'

describe SLEMath do
  describe 'Parser test:' do
    context 'check results matrix' do
      {
          "\nx - (y + x) / 5 = -1\ny = x / 2" => [[[0.8, -0.2], [-0.5, 1.0]], [-1, 0]],
          "\nx * 2 / 5 + 2*(y - z) = -3 + 3 * z\ny / 4 = x - x / 2\n55 * z = (y + 2) / 5" => [[[0.4, 2.0, -5.0], [-0.5, 0.25, 0], [0, -0.2, 55.0]], [-3, 0, 0.4]],
          "\nx + 2 * (y - x + 3 * z) = z - 2\ny / 0.8 - 1.1 * (0.5 * z + 13) = 0\nx + z = 10 * (0.2 * y - z / 0.8)" => [[[-1.0, 2.0, 5.0], [0, 1.25, -0.55], [1.0, -2.0, 13.5]], [-2, 14.3, 0]],
          "\na + b + c + d = 1\nd - c - b - a = -1\nb - d = 0\nc + a = 100" => [[[1.0, 1.0, 1.0, 1.0], [-1.0, -1.0, -1.0, 1.0], [0, 1.0, 0, -1.0], [1.0, 0, 1.0, 0]], [1, -1, 0, 100]],
      }.each do |eqs, result|
        parse_result = SLEMath::Parser::parse_sle_to_matrix(eqs)
        it eqs do
          parse_result.should eq(result)
        end
      end
    end

  end
end
