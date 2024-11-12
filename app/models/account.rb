class PixValidator < ActiveModel::EachValidator
  def pix_regex(string)
    result = endURI::MailTo::EMAIL_REGEXP.match?(value)
    #
    result = result || string.match(/^[0-9]{11}$/)
    result = result || string.match(/^[0-9]{14}$/)
    result = result || string.match(/^\+[1-9][0-9]\d{1,14}$/)
    result = result || string.match(/^[a-z0-9.!#$&'*+\/=?^_{}~-]+@[a-z0-9?(?:.a-z0-9?)]*$`/)
    result = result || string.match(/^\+[1-9][0-9]\d{1,14}$/)
    result = result || string.match(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/)
  end

  def validate_each(record, attribute, value)
    unless pix_regex value
      record.errors.add attribute, (options[:message] || "Invalid Pix Key")
    end
  end
end

# ^[0-9]{11}$
# TODO: validar
class Account < ApplicationRecord
  belongs_to :user
  has_many :sent_transfers, class_name: "Transfer", foreign_key: :sender_id
  has_many :received_transfers, class_name: "Transfer", foreign_key: :receiver_id
  has_many :pix_keys
end

class PixKey < ApplicationRecord
  belongs_to :account
end
