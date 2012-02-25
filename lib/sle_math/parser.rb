require 'symbolic'

module SLEMath
  module Parser
    def self.parse_sle_to_matrix(sle_str)
      # получаем названия переменных
      vars = []
      sle_str.scan(/\w+/).each { |w| vars << w if w !~ /\d+/ && !vars.include?(w) }

      # уравнения как элементы массива
      eqs = sle_str.split("\n").select { |eq| eq != '' }
      eqs = simplify_sle(vars, eqs)

      nums = eqs.size

      # пустышки
      b = Array.new(nums, 0)
      a = Array.new(nums) { b.dup }

      # парсим уравнения и заполняем пустышки
      eqs.each_with_index do |eq, index|
        # делим уравнение на члены, сохраняя знак
        parts = eq.scan(/\s*([+-]?\s*[\.\w]+(?:\s*[\*\/]\s*[\.\w]+)*)\s*/).map { |member| member.first }

        # заполняем пустышки
        parts.each do |member|
          w = member.scan(/[^\.\d\s\*\/+-]/).first
          i = vars.index(w)
          i ? a[index][i] = eval(member.sub(w, '1.0')) : b[index] = -eval(member)
        end
      end
      [a, b]
    end

    private

    def self.simplify_sle(vars, eqs)
      # собираем строку, которую будем исполнять
      eval_arr_name = 'evalued_arr'
      istr = "#{eval_arr_name} = []\n"
      istr << vars.inject('') { |str, var| str << "#{var} = var(name: '#{var}')\n" }
      istr << eqs.inject('') do |str, eq|
        left, right = eq.split(/\s*=\s*/)
        str << "#{eval_arr_name} << (#{left} - (#{right})).to_s\n"
      end

      # исполняем собранную строку
      eval_eqs_parts = eval(istr + eval_arr_name)
    end

  end
end