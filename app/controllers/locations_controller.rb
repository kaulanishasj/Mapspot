class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
      @u=User.find_by_id(params[:user_id]) 
      array_latest_locations = []
      @graph ||= Koala::Facebook::API.new(@u.oauth_token)
      @friends = @graph.get_connections("me","friends").collect{|f| f["id"] }
      @users=User.all
      @users_new = @users.map { |u| u.uid}
      @common_ones = @users_new & @friends # this gives me the common uid of those who are registered in the user table and the freinds of the current user
      
      @common_ones.each do |common_one|
          
        location_s = Location.where("user_id IN (?)",common_one ) 
        @latest = location_s.last
        array_latest_locations << @latest
      
      end

       @locations = Location.find(:all, :conditions => ["user_id = ?",@u.uid ])
        location=@locations.last
        
      if location.nil?
       #redirect_to new_user_location_path(@u.id)
      else
        puts location.name
        array_latest_locations << location
      end
      #raise array_latest_locations.inspect
      @json = array_latest_locations.compact.to_gmaps4rails
    
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @locations }
      end
    end

  # GET /locations/1
  # GET /locations/1.json

 


  def show
      #@location = Location.find(params[:id])
      @user=User.find_by_id(params[:user_id])
      @location = Location.find_by_id(params[:id])
      a = @location.address 
      
 
      @array_rest = Gmaps4rails.places_for_address( a , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'restaurant|amusement_park|shopping_mall|campground|bar|museum|night_club|movie_theater|zoo', radius = 1000)
     # @array_amusementpark_camp= Gmaps4rails.places_for_address( a , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'restaurant|amusement_park|shopping_mall|campground|bar|museum|night_club|movie_theater|zoo', radius = 1000)
     # @array_shopping = Gmaps4rails.places_for_address( a , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'restaurant|amusement_park|shopping_mall|campground|bar|museum|night_club|movie_theater|zoo', radius = 1000)

      @json = @array_rest.to_json
     #@json = array_rest.to_gmaps4rails

      respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @location }
    
      end 
  
  end


  def new
    
    @user=User.find_by_uid(params[:user_id])
    locations = Location.find(:all, :conditions => ["user_id = ?",@user.uid ])

    if locations.blank?
       location_n = Location.create(:address =>"Manhattan,New York,USA" )

    else
      location_n = locations.last
    end
    
    @json = location_n.to_gmaps4rails
    @location = Location.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @user=User.find_by_id(params[:user_id])
    @location = Location.find_by_id(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
      @user=User.find_by_id(params[:user_id])
      @location = Location.new(params[:location])
      @location.user_id = @user.uid
      @location.name = @user.name
      
      respond_to do |format|
        
        if @location.save
            format.html { redirect_to user_locations_path(@user), notice: 'Location was successfully created.' }
            format.json { render json: @location, status: :created, location: @location }
        else
            format.html { render action: "new" }
            format.json { render json: @location.errors, status: :unprocessable_entity }
        end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to user_locations_path, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @user=User.find_by_id(params[:user_id])
    @location = Location.find_by_id(params[:id])
     @location.destroy
    respond_to do |format|
      format.html { redirect_to user_locations_path }
      format.json { head :no_content }
    end
  end

  def restaurants
  
  end


  def  hospitals
      
    @user=User.find_by_id(params[:user_id])
    @location = Location.find_by_id(params[:id])
     
    b = @location.address
      @array_hosp = Gmaps4rails.places_for_address( b , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'dentist|health|hospital', radius = 1000)
    # @array_amusementpark_camp= Gmaps4rails.places_for_address( a , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'restaurant|amusement_park|shopping_mall|campground|bar|museum|night_club|movie_theater|zoo', radius = 1000)
    # @array_shopping = Gmaps4rails.places_for_address( a , 'AIzaSyDBgmxkPQH0JRNFvneP7d8vireve1gCC5Y', type = 'restaurant|amusement_park|shopping_mall|campground|bar|museum|night_club|movie_theater|zoo', radius = 1000)
     @json = @array_hosp.to_json
    #@json = array_rest.to_gmaps4rails
       
     # respond_to do |format|
     #   format.html 
     #   format.json { render json: @location }
    
     #end 
 end

  def shopping_malls




  end

end









