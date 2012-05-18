class DesiredPriceValidator < ActiveModel::EachValidator
  # implement the method called during validation
  def validate_each(record, attribute, value)
    if record.app
      record.errors[attribute] << 'must be less than the app price' unless value < record.app.price and record.app.price > 0
    end
  end
end
