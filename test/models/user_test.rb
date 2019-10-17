require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", username: "the_real_example", password: "abcdefgh!3I")
  end

  test "Should be valid" do
    assert @user.valid?
  end

  test "Name is within character limit" do
    @user.name = "t" * 51
    assert_not @user.valid?
  end
  
  test "Username is within character limit" do
    @user.username = "t" * 31
    assert_not @user.valid?
  end
  
  test "Username must exist" do
    @user.username = ""
    assert_not @user.valid?
  end

  test "Username must be unique" do
    duplicate = @user.dup
    duplicate.username = duplicate.username.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test "Password must exist" do
    @user.password = " " * 8
    assert_not @user.valid?
  end
  
  test "Password must have more than 7 characters" do
    @user.password = "t" * 7
    assert_not @user.valid?
  end
  
  test "Password must have less than 30 characters" do
    @user.password = "t" * 31
    assert_not @user.valid?
  end
  
  test "Password must have at least one special characters" do
    @user.password = "abcdefghijB3"
    assert_not @user.valid?
  end
  
  test "Password must have at least one uppercase character" do
    @user.password = "abcdefghij!3"
    assert_not @user.valid?
  end

  test "Password must have at least one lowercase character" do
    @user.password = "abcdefghij!3".upcase
    assert_not @user.valid?
  end

  test "Password must have at least one number" do
    @user.password = "abcdefghij!B"
    assert_not @user.valid?
  end
end
