class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  has_one :account
  attr_accessor :account_id
  after_create :create_new_account

  # validates :name, presence: true
  # validates :cpf, uniqueness: { message: "CPF already registered" }, presence: true
  # validates :email, email: true, presence: true
  def create_new_account
    @account = Account.find_or_create_by(id: @account_id) do |account|
      account.institution = "OxeBank"
      account.user_id = self.id
    end
    @account.save
  end
end
