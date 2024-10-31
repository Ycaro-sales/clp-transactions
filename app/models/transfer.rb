class Transfer < ApplicationRecord
  belongs_to :sender, class_name: "Account"
  belongs_to :receiver, class_name: "Account"

  enum transfer_type: { pix: 0, ted: 1, doc: 2 }
  validates :value, presence: true
end
