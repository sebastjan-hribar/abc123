module Helpers

  def compute(operator, input_1, input_2)
    case operator
      when "add"
        input_1.to_i + input_2.to_i
      when "subtract"
        input_1.to_i - input_2.to_i
      when "multiply"
        input_1.to_i * input_2.to_i
      when "divide"
        input_1.to_i / input_2.to_i
    end
  end
  
  def input1
    rand(0..9)
  end
  
  def input2
    rand(0..9)
  end
  
end