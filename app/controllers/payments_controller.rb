require 'open-uri'

class PaymentsController < ApplicationController

  def new

  end

  def create
    require "stripe"
    Stripe.api_key = "sk_test_dkY8errhPdowa3cPJ9Dfei2e"
    @product = Product.find_by_id(params[:productId])

    if logged_in?
        Stripe::Charge.create(
          :amount => @product.price,
          :currency => "usd",
          :source => params[:stripeToken], # obtained with Stripe.js
          :description => @product.title
        )
        order = Order.create user_id:current_user.uid, product_id: @product.id, amount: @product.price, created_at:Time.new(), updated_at: Time.new()
        open("http://localhost:4000/purchase?sku=#{@product.sku}").read
        redirect_to root_url, notice: "The #{@product.title} is on its way!"
    else
        redirect_to root_url, notice: "Please login first"
    end

  end
end
