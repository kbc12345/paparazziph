class User < ActiveRecord::Base

def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    return facebook
  end

  def self.photos(facebook, album_id)
    photo_collection = []
    pages = facebook.get_connections('me', 'accounts')
    page_graph = Koala::Facebook::API.new(facebook.get_page_access_token((pages.find {|s| s["name"] == "The Paparazzi" })["id"]))
    photos = page_graph.get_connections(album_id, 'photos', {fields: ['created_time',"id", "images", "height", "width"]})
    photo_collection.push(*photos)
    while(photos.next_page != nil) do
      photos = photos.next_page
      photo_collection.push(*photos)
    end
    return photo_collection
  end

  def self.albums(facebook)
    album_collection = []
    pages = facebook.get_connections('me', 'accounts')
    page_graph = Koala::Facebook::API.new(facebook.get_page_access_token((pages.find {|s| s["name"] == "The Paparazzi" })["id"]))
    albums = page_graph.get_connections("me","albums", :fields => "name, id, created_time, photos.fields(source)")
    album_collection.push(*albums)
    while(albums.next_page != nil) do
      albums = albums.next_page
      album_collection.push(*albums)
    end

    return album_collection
  end

  def self.ratings(facebook)
    rating_collection = []
    pages = facebook.get_connections('me', 'accounts')
    page_graph = Koala::Facebook::API.new(facebook.get_page_access_token((pages.find {|s| s["name"] == "The Paparazzi" })["id"]))
    ratings = page_graph.get_connections("me","ratings", :fields => "reviewer, has_review, rating, review_text")
    rating_collection.push(*ratings)
    while(ratings.next_page != nil) do
      ratings = ratings.next_page
      rating_collection.push(*ratings)
    end

    return rating_collection
  end

end