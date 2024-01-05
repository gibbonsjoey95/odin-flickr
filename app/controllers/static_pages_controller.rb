class StaticPagesController < ApplicationController
  # require 'flickr'
  
  # def home
  #   flickr = Flickr.new(ENV['FLICKR_API_KEY'])
  #   user_id = params[:flickr_user_id]

  #   if user_id.present?
  #     @photos = flickr.photos.search(user_id: user_id, per_page: 10)
  #   else
  #     flash[:alert] = 'Please enter a valid Flickr User ID.'
  #   end

  #   render :home
  # end


  def home
    if params[:user_id].present?
      begin
        flickr_api_key = ENV['FLICKR_API_KEY']

        if flickr_api_key.blank?
          flash[:alert] = "Flickr API key is not configured."
        else
          flickr = Flickr.new(flickr_api_key)
          user_info = flickr.people.find_by_url("https://www.flickr.com/photos/#{params[:user_id]}/")
          @photos = flickr.people.getPhotos(user_info.id).to_a
        end
      rescue Flickr::FailedResponse => e
        flash[:alert] = "Error retrieving photos: #{e.message}"
      end
    end
  end
end
