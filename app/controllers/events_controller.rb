class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    date_time = DateTime.new(params['event']['start_date(1i)'].to_i,
                            params['event']['start_date(2i)'].to_i,
                            params['event']['start_date(3i)'].to_i,
                            params['event']['start_date(4i)'].to_i,
                            params['event']['start_date(5i)'].to_i)
    @event = Event.new(start_date: date_time,
      duration: params['event']['duration'].to_i, 
      title: params['event']['title'], 
      description: params['event']['description'],
      location: params['event']['location'],
      administrator_id: current_user.id,
      img_url: "https://loremflickr.com/#{rand(150..250)}/#{rand(150..250)}/place",
      price: params['event']['price'].to_i)
    if @event.save
      flash[:notice] = "L'évènement a bien été créé !"
      redirect_to '/'
    else
      flash[:alert] = @event.errors.full_messages[0]
      render new_event_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    post_params = params.require(:event).permit(:start_date, :duration, :title, :description, :location, :price)
    if @event.update(post_params)
      flash[:notice] = "L'évènement a bien été mis à jour"
      redirect_to @event
      else
      flash[:alert] = @event.errors.full_messages[0]
      render 'edit'
    end 
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
      flash[:notice] = "L'évènement a bien été supprimé"
    redirect_to root_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Merci de vous connecter"
      redirect_to new_user_session_path
    end
  end

  def authenticate_administrator
    unless current_user == Event.find(params[:id]).administrator
      flash[:alert] = "Vous n'êtes pas l'administrateur de cet évènement !"
      redirect_to root_path
    end
  end

end
