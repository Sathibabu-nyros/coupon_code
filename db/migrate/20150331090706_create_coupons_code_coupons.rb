class CreateCouponsCodeCoupons < ActiveRecord::Migration
  def change
    create_table :coupons_code_coupons do |t|
      t.string :code, null: false
      t.string :description, null: true
      t.date :valid_from, null: false
      t.date :valid_until, null: true
      t.integer :redemption_limit, default: 1, null: false
      t.integer :coupon_redemptions_count, default: 0, null: false
      t.integer :amount, null: false, default: 0
      t.string :type, null: false
      t.timestamps null: false      
    end
  end
end
