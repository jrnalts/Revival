class Voucher < ApplicationRecord
  belongs_to :user

  validates :name, :presence => { :message => "公司名稱不能為空白" }
  validates :uniform, :presence => { :message => "統一編號不能為空白" }
  validates :tel, :presence => { :message => "聯絡電話不能為空白" }
  validates :uniform,
            length: { 
              is: 8, 
              message: "統一編號請輸入8碼數字"
            }
  validates :serial, uniqueness: true
  validate :valid_uniform
  
  before_create :create_serial

  private
  def create_serial
    self.serial = [*'a'..'z', *'A'..'Z', *0..9].sample(10).join
  end

  def valid_uniform
    if uniform == ''
      return
    end
    multiplier = [1, 2, 1, 2, 1, 2, 4, 1].freeze
    serial = uniform.split('')

    multipled = serial.zip(multiplier).map{|x, y| x.to_i * y}
    multipled_reduced = multipled.map{|x|x.divmod(10).reduce(:+)}
    if multipled_reduced[6] == 10
      other_sum = multipled_reduced[0..5].reduce(:+)+multipled_reduced[7]
      if other_sum%10 != 0 && (other_sum+1)%10 != 0
        errors.add(:uniform, "您所填寫的統一編號有誤，請確認後重新輸入")
      end
    else
      if multipled_reduced.reduce(:+)%10 != 0
        errors.add(:uniform, "您所填寫的統一編號有誤，請確認後重新輸入")
      end
    end
  end
end
