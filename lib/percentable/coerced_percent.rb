class CoercedPercent < Struct.new(:percent)
  def + other
    other + self * other
  end

  def - other
    other - self * other
  end

  def * other
    other * percent.to_f
  end

  def / other
    other / percent.to_f
  end
end
