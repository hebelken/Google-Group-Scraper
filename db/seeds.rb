# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

authors = Author.create([{ :name => "hebelken"}, { :name => "timmy"}, { :name => "barny Stinson"}])

posts = Post.create([
  { :author => authors.first, 
    :rating => 5, 
    :body => "yo tina, I'mma let you finish but jeffry has the..."},
  { :author => authors.first, 
    :rating => 1, 
    :body => "herp-derp dee deed derp"},
  { :author => authors.last, 
    :rating => 2, 
    :body => "this is the name that is mine my post is baller and I look so fine"},
  { :author => authors[1], 
    :rating => 5, 
    :body => "this is alebeeb psors dort aohtem lariousemsasdgnm ipsotmsatmm"
}])
