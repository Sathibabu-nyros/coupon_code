require "coupons_code/engine"

module CouponsCode

    #require 'coupons_code/helpers'
    #require 'coupons_code/models/coupon'

   def self.apply(code, options)
      puts "----------------------------------"
      options[:discount] = 0
      options[:total] = options[:amount]

      #find coupon 
      coupon = find(code)
      return options unless coupon

      Coupon.apply(options,coupon)    
     
   end


   def self.reedem(code, options)
      options[:discount] = 0
      options[:total] = options[:amount]

      coupon = find(code)
      return options unless coupon

      @coupon_redemption = CouponRedemption.new

      @coupon_redemption.coupon_id = coupon.id
      @coupon_redemption.user_id = options[:user_id]
      @coupon_redemption.order_id = options[:order_id]
      @coupon_redemption.save

      #Coupon.CouponRedemption.create!(options.slice(:user_id, :order_id))
      Coupon.apply(options,coupon)
   end



   private 

   def self.find(code)
      Coupon.find_by_code(code)
   end
  
end
