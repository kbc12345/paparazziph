class Site::PackagesController < SiteController

  def index
    @booking = Booking.new(category: "Photoman")
    if request.headers['X-PJAX']
      render :layout => false
    end
  end

end
