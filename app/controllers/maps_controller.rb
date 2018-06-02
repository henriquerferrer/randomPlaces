class MapsController < ApplicationController

  def randomize
    @client = GooglePlaces::Client.new("AIzaSyCVcuPwW5vDnPwhBMVvf322lmGcZwqtCeY")
    spots = @client.spots(params[:latitude], params[:longitude], radius: 500, types: 'restaurant') 
    #spots = @client.spots(40.202738, -8.401090, radius: 1000, types: 'restaurant') #remove this line for deployment
    @randomSpot = spots[rand(spots.length)]
    gon.randomSpot = @randomSpot
    if @randomSpot
      respond_to do |format|
        format.js { render partial: "maps/map" }
      end
    else
      flash[:danger] = "no restaurants in your zone"
      redirect_to randomize_path
    end
  end

end
