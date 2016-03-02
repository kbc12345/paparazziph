class Site::PhotosController < SiteController

  def index
    @collection = Photo.where(album_id: params[:album_id]).in_groups_of(4)
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

end
