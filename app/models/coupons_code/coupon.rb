module CouponsCode
  class Coupon < ActiveRecord::Base
  	validates_presence_of :code, :valid_from
     #validates_inclusion_of :type, in: %w[percentage amount]     

      validates_numericality_of :amount,
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 100,
        only_integer: true,
        if: :percentage_based?

      validates_numericality_of :amount,
        greater_than_or_equal_to: 0,
        only_integer: true,
        if: :amount_based?

      validates_numericality_of :redemption_limit,
        greater_than_or_equal_to: 0

      validate :validate_dates
  end
end
