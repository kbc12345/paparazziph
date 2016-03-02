class Site::UsersController < SiteController

  ADMIN_IDS = ["10208780839255340", "1966758440216682"]

  ALBUM_IGNORE_LIST = ["Timeline Photos", "Photo Invitation", "Profile Pictures", "Cover Photos", "Guests who instagram their photo experience with us"]

  def index

  end

  def login
    fb = User.koala(request.env['omniauth.auth']['credentials'])
    user = fb.get_object("me")
    if ADMIN_IDS.include? user["id"]
      current_reviewers = Review.pluck("reviewer")
      review_collection = []
      reviews = User.ratings(fb).each do |review|
        if (review["has_review"] && !(current_reviewers.include? review["reviewer"]["name"]))
          review_collection << Review.new(rating: review["rating"], reviewer: review["reviewer"]["name"], message: review["review_text"])
        end
      end
      Review.import review_collection
      
      current_albums = Album.pluck("name")
      albums =  User.albums(fb).each do |album|
        if ( !(ALBUM_IGNORE_LIST.include? album["name"]) && !(current_albums.include? album["name"]))
          album_category = "photoman"
          if album["name"].downcase.include? "coverage"
            album_category = "coverage"
          end
          new_album = Album.new(name: album["name"], cover_photo: album["photos"]["data"][0]["source"], category: album_category, created_at: album["created_time"])
          photos = User.photos(fb, album["id"])
          if photos[0]["images"][0]["height"] > photos[0]["images"][0]["width"]
            new_album.layout = "vertical"
          end
          new_album.save
          photo_collection = []
          photos.each do |photo|
            photo_collection << new_album.photos.build(url: photo["images"][0]["source"], created_at: photo["created_time"])
          end
          Photo.import photo_collection
        end
      end
    end
  end

end