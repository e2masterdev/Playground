class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable, :recoverable,
         :validatable, :confirmable, :lockable

  validates :password, allow_nil: true,
            length: {minimum: 8},
            format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/,
                     message: "Must contain at least one digit and one letter"}
  validates :extra_id, presence: true, length: {maximum: 20}

  before_create :set_balance_to_zero

  private

  def set_balance_to_zero
    self.balance = 0
  end
end
