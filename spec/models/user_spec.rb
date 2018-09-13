require 'rails_helper'
describe User do
  describe '#create' do

    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      binding.pry
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid when a nickname is more than 6 characters" do
      user = build(:user, nickname: "abeabeabe")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "is valid when a nickname is below 6 characters" do
      user = create(:user, nickname: "test")
      expect(user).to be_valid
    end

    it "is invalid with duplicating email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "is valid when a password is no less than 6 characters" do
      user = create(:user, password: "1234567", password_confirmation: "1234567")
      expect(user).to be_valid
    end

    it "is invalid when a password is less than 6 characters" do
      user = build(:user, password: "1234", password_confirmation: "1234")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end
end
