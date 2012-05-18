class DesiredPriceValidator < ActiveModel::EachValidator
  # implement the method called during validation
  def validate_each(record, attribute, value)

    if record.app and ((value > record.app.price) and (record.rule != 0))
      record.errors[attribute] << 'must be less than the app price'
    end

  end
end
