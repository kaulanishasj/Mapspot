class Location < ActiveRecord::Base
	belongs_to :user
  


   attr_accessible :address, :gmaps, :latitude, :longitude, :name , :created_at
  
   reverse_geocoded_by :latitude, :longitude
   after_validation :reverse_geocode

	acts_as_gmappable

	def gmaps4rails_address
	   #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	  address
	end

	def gmaps4rails_infowindow
	
	 "#{name} was spotted in #{address} \n at #{created_at}"
	end
 
	def gmaps4rails_sidebar
	 name   
	end



 
end
