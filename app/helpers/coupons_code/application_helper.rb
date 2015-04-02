module CouponsCode
  module ApplicationHelper
  	
  	def redeem(code, options)
      options[:discount] = 0
      options[:total] = options[:amount]

      coupon = find(code, options)
      return options unless coupon

      coupon.redemptions.create!(options.slice(:user_id, :order_id))
      coupon.apply(options)
    end

    # Apply coupon code.
    # If the coupon is still good, returns a hash containing the discount value,
    # and total value with discount applied. It doesn't redeem coupon.
    # It returns discount as `0` for invalid coupons.
    #
    #     apply('ABC123', amount: 100)
    #     #=> {amount: 100, discount: 30, total: 70}
    #
    def apply(code, options)
    
      options[:discount] = 0
      options[:total] = options[:amount]

      coupon = find(code, options)
      return options unless coupon

      coupon.apply(options)
    end

    # Create a new coupon code.
    def create(options)
      ::Coupons::Models::Coupon.create!(options)
    end

    # Find a valid coupon by its code.
    # It takes starting/ending date, and redemption count in consideration.
    def find(code, options)
      Coupons.configuration.finder.call(code, options)
    end
  end
end
