require "coupons_code/engine"

module CouponsCode

    #require 'coupons_code/helpers'
    #require 'coupons_code/models/coupon'

   def self.apply(code, options)
      puts "----------------------------------"
      options[:discount] = 0
      options[:total] = options[:amount]
      options[:error] = "invalid_couponcode"

      #find coupon 
      coupon = find(code)
      return options unless coupon

       #find redemption_limit 
      options[:error] = "redemption_limit_expired"      
      return options unless has_available_redemptions?(coupon)

       #find started? 
      options[:error] = "couponcode_expired1"      
      return options unless started?(coupon)

      #find expired?
      options[:error] = "couponcode_expired2"      
      return options unless !expired?(coupon)

      Coupon.apply(options,coupon)    
     
   end


   def self.reedem(code, options)     
      apply(code, options)
      coupon = find(code)
      @coupon_redemption = CouponRedemption.new
      @coupon_redemption.coupon_id = coupon.id
      @coupon_redemption.user_id = options[:user_id]
      @coupon_redemption.order_id = options[:order_id]
      @coupon_redemption.save      
      coupon.update_attribute("coupon_redemptions_count","#{coupon.coupon_redemptions_count + 1}")      
   end



   private 

   def self.find(code)
      Coupon.find_by_code(code)
   end  
   

  def self.expired?(coupon)
    coupon.valid_until && coupon.valid_until <= Date.current
  end

  def self.has_available_redemptions?(coupon)
    coupon.redemption_limit.zero? || coupon.coupon_redemptions_count < coupon.redemption_limit
  end

  def self.started?(coupon)
    coupon.valid_from <= Date.current
  end

  def self.redeemable?(coupon)
    !expired? && has_available_redemptions? && started?
  end    
  
end
