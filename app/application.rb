require_relative '../config/environment.rb'

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    item_name = req.path.split("/items/").last

    # binding.pry

    if req.path.match("/items/")
      # binding.pry
      item = Item.all.find { |item| item.name == item_name }
      if item
        resp.write "#{item.price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
