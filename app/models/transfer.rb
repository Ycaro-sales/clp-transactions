class Transfer < ApplicationRecord
  belongs_to :sender, class_name: "Account"
  belongs_to :receiver, class_name: "Account"

  enum transfer_type: { pix: 0, ted: 1, doc: 2 }
  validates :value, presence: true, comparison: { greater_than: 0 }, numericality: true
  validates :sender, presence: true
  validates :receiver, presence: true
  validates :transfer_type, presence: true
end
