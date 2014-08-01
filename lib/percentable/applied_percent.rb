class AppliedPercent < Struct.new(:percent)
  def + other
    other + other * percent.to_f
  end

  def - other
    other - other * percent.to_f
  end

  def * other
    other * percent.to_f
  end

  def / other
    other / percent.to_f
  end
end
