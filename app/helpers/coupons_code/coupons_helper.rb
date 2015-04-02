module CouponsCode
  module CouponsHelper

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
