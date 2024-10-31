class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

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
