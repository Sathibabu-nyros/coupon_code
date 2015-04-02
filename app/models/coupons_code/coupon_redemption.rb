module CouponsCode
  class CouponRedemption < ActiveRecord::Base
  	# Set table name.
      self.table_name = :coupon_redemptions
      belongs_to :Coupon, counter_cache: true
  end
end
