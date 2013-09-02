class TraveloguesController < ApplicationController
  # GET /travelogues
  # GET /travelogues.json
  def index
    @u=User.find_by_id(params[:user_id]) 
    @travelogue = Travelogue.find(:all, :conditions => ["user_id = ?",@u.id ])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @travelogue }
    end
  end

 
  def show
    
    @user=User.find_by_id(params[:user_id])
    @travelogue = Travelogue.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @travelogue }
    end
  end

  
  def new
   
    @user=User.find_by_id(params[:user_id])
    @travelogue = Travelogue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @travelogue }
    end
  end

  # GET /travelogues/1/edit
  def edit
    @user=User.find_by_id(params[:user_id])
    @travelogue = Travelogue.find_by_id(params[:id])
  end

  # POST /travelogues
  # POST /travelogues.json
  def create
    @user=User.find_by_id(params[:user_id])
    @travelogue = Travelogue.new(params[:travelogue])
    @travelogue.user_id = @user.id
    
    respond_to do |format|
      if @travelogue.save
        format.html { redirect_to user_travelogues_path , notice: 'Travelogue was successfully created.' }
        format.json { render json: @travelogue, status: :created, location: @travelogue }
      else
        format.html { render action: "new" }
        format.json { render json: @travelogue.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    @travelogue = Travelogue.find(params[:id])
      
    respond_to do |format|
      if @travelogue.update_attributes(params[:travelogue])
        format.html { redirect_to user_travelogues_path, notice: 'Travelogue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @travelogue.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user=User.find_by_id(params[:user_id])
    @travelogue = Travelogue.find_by_id(params[:id])
    @travelogue.destroy

    respond_to do |format|
      format.html { redirect_to user_travelogues_path }
      format.json { head :no_content }
    end
  end
end
