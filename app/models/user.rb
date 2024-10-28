class User < ApplicationRecord
  has_many :sent_transactions, class_name: "Transfer", foreign_key: "sender_id"
  has_many :received_transactions, class_name: "Transfer", foreign_key: "receiver_id"
end
