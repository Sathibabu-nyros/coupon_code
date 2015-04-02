module CouponsCode
  class Coupon < ActiveRecord::Base
  	 # Set table name.
      self.table_name = :coupons

      #before_save :set_name
      has_many :redemptions, class_name: 'CouponsCode::CouponRedemption'

      validates_presence_of :code, :valid_from
      validates_uniqueness_of :code
      validates_numericality_of :redemption_limit, greater_than_or_equal_to: 0
      validates_numericality_of :amount,
                    greater_than_or_equal_to: 0,
                    less_than_or_equal_to: 100,
                    only_integer: true, if: Proc.new { self.discount_type == 'percentage'}  
                    
      validates_numericality_of :amount,
                    greater_than_or_equal_to: 0,
                    only_integer: true, if: Proc.new {self.discount_type == 'amount' }
                    
      validate :validate_dates

      def self.apply(options,coupon)
        @coupon = coupon       
        puts input_amount = BigDecimal("#{options[:amount]}")
        puts discount = BigDecimal(percentage_based? ? percentage_discount(options[:amount],@coupon.amount) : @coupon.amount)
        total = [0, input_amount - discount].max        
        options = options.merge(total: total, discount: discount, error: 'success')        
        options
      end

     
      def self.percentage_based?
        @coupon.discount_type == 'percentage'
      end

      def self.amount_based?
        discount_type == 'amount'
      end


      private

        def self.percentage_discount(input_amount,amount)        
        BigDecimal("#{input_amount}") * (BigDecimal("#{amount}") / 100).to_f
        end

        def validate_dates
          if valid_until_before_type_cast.present?
            errors.add(:valid_until, :invalid) unless valid_until.kind_of?(Date)
            errors.add(:valid_until, "must be equal to or greater than today") if valid_until? && valid_until < Date.current
          end

          if valid_from.present? && valid_until.present?
            errors.add(:valid_until, "must be greater than or equal to valid from date.") if valid_until < valid_from
          end
        end

  end
end
