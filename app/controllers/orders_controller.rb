class OrdersController < ApplicationController

  def index
    @list = Order.where(user_id: current_user.uid).limit(1000)
  end

  def new
    product = Product.find_by(id: params[ :product_id])
    json = open("http://localhost:4000/on_hand?sku=#{product.sku}").read
    puts "##################"
    puts json
    @product_count = JSON.parse(json)['count']
    puts "##################"
    if @product_count <= 0
      redirect_to root_url, notice: "The product is not available now."
    end
  end

  def create
  end
end
