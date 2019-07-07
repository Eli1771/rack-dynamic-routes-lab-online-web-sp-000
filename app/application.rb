class Application 
  @@items = [Item.new("apples", 2.35), Item.new("flour", 3.15), Item.new("milk", 2.20)]
  def call(env) 
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last.downcase
      if item = @@items.find{|i| i.name == item_name}
        resp.write item.price
      else 
        resp.status = 400
        resp.write "Item not found"      
      end
    else 
      resp.status = 404
      resp.write "Route not found"    
    end 
    resp.finish
  end 
end 