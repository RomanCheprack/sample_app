require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example user", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be valid" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should br valid" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be to long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be to long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-er@foo.bar.org
                         first.last@foo.jp alice+bob@bar.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_adresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_adresses.each do |invalid_adress|
      @user.email = invalid_adress
      assert_not @user.valid?, "#{invalid_adress.inspect} should be invalid"
    end
  end
end
