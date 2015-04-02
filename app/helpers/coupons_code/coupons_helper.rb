module CouponsCode
  module CouponsHelper

      def coupon_discount(coupon)       
        return  "#{coupon.amount}% OFF"  if coupon.discount_type == 'percentage'       
        return  "$#{coupon.amount} OFF"       
      end

      def redeemed(coupon)
        limit = coupon.redemption_limit
        return "Not yet" if limit == 0
        return "#{coupon.coupon_redemptions_count} / #{coupon.redemption_limit}" if limit >  0
      end

       def valid_until(coupon)
         if coupon.valid_until?
         short_date(coupon.valid_until)
         else
         "Never"
         end
       end

       def short_date(date)
         date.to_formatted_s(:long)
       end
  end
end
