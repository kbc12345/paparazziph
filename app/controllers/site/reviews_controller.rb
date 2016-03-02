class Site::ReviewsController < SiteController

  def index
    @reviews = Review.all.in_groups_of(3)
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

end
