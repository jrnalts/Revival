require 'rails_helper'

RSpec.describe Voucher, type: :model do
  it "公司名稱, 公司統編, 聯絡電話皆為必填" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123456'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '52420881',
      tel: Faker::PhoneNumber.phone_number 
    )
    expect(voucher1).to be_valid
    expect(voucher2).to be_valid
  end

  it "不符合驗證規則的統一編號就不能通過" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '11111111',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher3 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '1111',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher1.valid?
    voucher2.valid?
    voucher3.valid?
    expect(voucher1.errors[:uniform]).to include("統一編號不能為空白")
    expect(voucher2.errors[:uniform]).to include("您所填寫的統一編號有誤，請確認後重新輸入")
    expect(voucher3.errors[:uniform]).to include("統一編號請輸入8碼數字")
  end

  it "如果已經兌換過就無法再兌換" do
    user = User.new(
      email: Faker::Internet.email,
      password: '123123'
    )
    voucher1 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher2 = user.vouchers.new(
      name: Faker::Company.name,
      uniform: '54191940',
      tel: Faker::PhoneNumber.phone_number 
    )
    voucher1.valid?
    voucher2.valid?
    expect(voucher1).to be_valid
    expect(voucher2.errors[:uniform]).to eq([])
  end
end
