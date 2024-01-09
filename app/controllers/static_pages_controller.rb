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


  require 'flickr'
  
  # def home
  #   if params[:user_id].present?
  #     begin
  #       flickr_api_key = ENV['FLICKR_API_KEY']
  #       flickr_shared_secred = ENV['FLICKR_SHARED_SECRET']

  #       if flickr_api_key.blank?
  #         flash[:alert] = "Flickr API key is not configured."
  #       else
  #         flickr = Flickr.new(flickr_api_key, flickr_shared_secred)
  #         user_info = flickr.people.find_by_url("https://www.flickr.com/photos/#{params[:user_id]}/")
  #         @photos = flickr.people.getPhotos(user_info.id).to_a
  #       end
  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end

  # def home
  #   puts "ENV['FLICKR_API_KEY']: #{ENV['FLICKR_API_KEY']}"
  
  #   if params[:user_id].present?
  #     begin
  #       flickr = Flickr.new
  #       # Extract the user ID from the URL
  #       user_id = params[:user_id].split('@')[0]
  #       # Retrieve user information using the user ID
  #       user_info = flickr.people.getInfo(user_id: user_id)
  #       # Get photos for the user
  #       @photos = flickr.people.getPhotos(user_info.id).to_a
  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end

  # def home
  #   if params[:user_id].present?
  #     begin
  #       flickr = Flickr.new

  #       # Fetch recent photos for the given user ID
  #       recent_photos = flickr.people.getPhotos(user_id: params[:user_id]).to_a

  #       # Display information for the first photo (you can modify this as needed)
  #       if recent_photos.present?
  #         first_photo = recent_photos.first
  #         info = flickr.photos.getInfo(photo_id: first_photo.id, secret: first_photo.secret)

  #         @photo_title = info.title
  #         @photo_taken_at = info.dates.taken
  #       else
  #         @photo_title = "No recent photos found"
  #       end
  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end

  # def home
  #   if params[:user_id].present?
  #     begin
  #       flickr = Flickr.new

  #       # Fetch recent photos for the given user ID
  #       recent_photos = flickr.people.getPhotos(user_id: params[:user_id]).to_a

  #       # Display information for the first photo (you can modify this as needed)
  #       if recent_photos.present?
  #         first_photo = recent_photos.first
  #         info = flickr.photos.getInfo(photo_id: first_photo.id, secret: first_photo.secret)

  #         @photo_title = info.title
  #         @photo_taken_at = info.dates.taken

  #         # Fetch available sizes for the photo
  #         sizes = flickr.photos.getSizes(photo_id: first_photo.id)

  #         # Select the URL of a specific size (e.g., 'Medium 640')
  #         @photo_url = sizes.find { |s| s.label == 'Medium 640' }&.source
  #       else
  #         @photo_title = "No recent photos found"
  #       end
  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end
  

  # def home
  #   if params[:user_id].present?
  #     begin
  #       flickr = Flickr.new
  #       user_info = flickr.people.fi("https://www.flickr.com/photos/#{params[:user_id]}/")
  #       @photos = flickr.photos.getContactsPublicPhotos(user_id: user_info.id, count: 10).to_a
  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end


  # def home
  #   @photos = []

  #   if params[:user_id].present?
  #     begin
  #       flickr = Flickr.new
  #     @photos = flickr.people.getPhotos(user_id: params[:user_id], per_page: 10).to_a

  #     @info = flickr.photos.getInfo(photo_id: params[:id] )

  #     puts 'INFO'

  #     rescue Flickr::FailedResponse => e
  #       flash[:alert] = "Error retrieving photos: #{e.message}"
  #     end
  #   end
  # end

  def home
    @photos = []
  
    if params[:user_id].present?
      begin
        flickr = Flickr.new
        photo_list = flickr.people.getPhotos(user_id: params[:user_id], per_page: 10).to_a
  
        photo_list.each do |photo|
          info = flickr.photos.getInfo(photo_id: photo.id)
          sizes = flickr.photos.getSizes(photo_id: photo.id)
          direct_url = sizes.find { |s| s.label ==  'Medium 640' }.source
          # sizes.find { |s| s.label == 'Medium 640' }&.source

          title = info.title
          # urls = info.urls.url[0]._content
          id = info.id
          @photos << { title: title, urls: direct_url , id: id}
        end
      rescue Flickr::FailedResponse => e
        flash[:alert] = "Error retrieving photos: #{e.message}"
      end
    end
  end
end
