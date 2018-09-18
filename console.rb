require('pry')
require_relative('./models/property')
Property.delete_all()

property1 = Property.new({
  'address' =>"100 Main Road",
  'value' => 100000,
  'no_of_bedrooms' => 1,
  'year_built' => 1900,
  'build' => "Semi-Detached"})

property1.save()

  property2 = Property.new({

  'address' => "Main House, Main Road",
'value' => 200000,
'no_of_bedrooms' => 7,
'year_built' => 1845,
'build' => "Detached"})

property2.save()

Property.property_all()

Property.find_property_by_address("Main House, Main Road")
Property.find_property_by_id(4)

Property.delete1(10)

property1.address = "110 Main Road"
property1.update()

binding.pry
nil
