db.restaurants.find();
db.restaurants.find({},{"restaurant_id":1,"name":1,"borough":1,"cuisine":1});
db.restaurants.find({},{"_id":0,"restaurant_id":1,"name":1,"borough":1,"cuisine":1});
db.restaurants.find({},{"_id":0,"restaurant_id":1,"name":1,"borough":1,"address.zipcode":1});
db.restaurants.find({"borough":"Bronx"});
db.restaurants.find({"borough":"Bronx"}).limit(5);
db.restaurants.find({"borough":"Bronx"}).limit(5).skip(5);
db.restaurants.aggregate([{$match: {}},{$group: {_id}}]);

