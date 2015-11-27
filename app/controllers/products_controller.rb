require 'open-uri'

class ProductsController < ApplicationController

   def index
  #@products = Product.all
    json = open("http://localhost:4000/inventory.json").read
    puts "###################"
    puts json
    puts "###################"
    @products = JSON.parse(json)
    Product.delete_all
    @products.each do |product|

      item = Product.find_by(sku: product["id"])
      item ||= Product.create(id: product["id"],sku: product["sku"], photo_url: product["photo_url"], title: product["title"], description: product["description"], price: product["price"])
      # Product.create sku: 'B0002F58TG', photo_url: 'http://ecx.images-amazon.com/images/I/61fspjyu4yL._SL1500_.jpg', title: 'Jasmine S35 Acoustic Guitar', description: 'This Amazon Marketplace top-selling acoustic guitar is the perfect instrument for a beginner of any age, or as a second instrument for the seasoned player. From its detailed appointments to the bold acoustic tones it projects, the Jasmine S35 dreadnought guitar is an excellent all around solution for any style of music. This finely crafted instrument is backed by a limited lifetime warranty.'
    end
   end

end
