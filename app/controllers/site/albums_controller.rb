class Site::AlbumsController < SiteController

  def index
    @category = params[:gallery_id]
    @albums = Album.where(category: @category).order(created_at: :desc).in_groups_of(4)
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

end
