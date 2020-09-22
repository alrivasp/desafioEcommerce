require 'test_helper'

class OrderTest < ActiveSupport::TestCase

test "pass total price to cents" do
  user_one = User.create(email: "user@mail.com", password:"12345678")
  order = Order.create(user: user_one, total: 100)
  assert_equal order.total_cents, 10000

end

test "order creates a payment" do
  user_one = User.create(email: "user@mail.com", password:"12345678")
  order = Order.create(user: user_one, total: 100)

  PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
  order.create_payment("PEC", "token_123456789")
  assert_equal order.payments.last.state, "processing"
  
end

test "order is marked as completed" do
  user_one = User.create(email: "user@mail.com", password:"12345678")
  order = Order.create(user: user_one, total: 100)

  order.complete!
  assert_equal order.state, "completed"
end

end
