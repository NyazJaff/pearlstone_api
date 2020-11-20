module Api::V1::PearlstoneHelper

  def to_bool(value)
    ActiveModel::Type::Boolean.new.cast value
  end

end
