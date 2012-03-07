module SLEMath
	module Solver
		def self.solve(a, b)
			#расширяем массив A, добавляя к нему столбец массива B
			n = a.size
			0.upto(n-1) do |i|
				a[i].push(b[i])
			end
			#обеспечиваем единицы на главной диагонали и нули под ними
			0.upto(n-1) do |k|
				tmp = a[k][k]
				0.upto(n) do |j| 
					if a[k][j] != 0
						a[k][j] = a[k][j] / tmp
					end
				end
				(k + 1).upto(n-1) do |i| 
					tmp = (-1) * a[i][k]
					0.upto(n) do |j|
						a[i][j] = a[i][j] + a[k][j] * tmp
					end
				end
			end
			#добиваемся нулей над главной диагональю
			(n - 1).downto(0) do |k|
				(k - 1).downto(0) do |i|
					tmp = (-1) * a[i][k];
					0.upto(n) do |j|
						a[i][j] = a[i][j] + a[k][j] * tmp
					end
				end
			end
			 result = a	
		end
	end
end
