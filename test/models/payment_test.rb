require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
 test "payment is marked as completed" do
    user_one = User.create(email: "user@mail.com", password:"12345678")
    order = Order.create(user: user_one, total: 100)

    pm = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state:"processing", total: 100, token: "token_123456")
    
    payment.complete!

    assert_equal payment.state, "completed"
 end

 test "complete payment" do
    user_one = User.create(email: "user@mail.com", password:"12345678")
    order = Order.create(user: user_one, total: 100)

    pm = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state:"processing", total: 100, token: "token_123456")

    payment.close!

    assert_equal payment.state, "completed"
    assert_equal payment.order.state, "completed"
 end
end
