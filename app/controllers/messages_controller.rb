class MessagesController < ApplicationController
  load_and_authorize_resource except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_message, only: [:show, :update, :edit, :destroy, :like, :unlike]
  
  def search
    if params[:search].present?
      @messages = Message.search(params[:search])
    else
      @messages = Message.all
    end
  end
  
  def index
    if params[:category].blank?
      @messages = Message.all.paginate(page: params[:page], per_page: 30).order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @messages = Message.where(category_id: @category_id).paginate(page: params[:page], per_page: 30)
    end
  end

  def show
    @pictures = @message.pictures
  end

  def new
    @message = current_user.messages.build
    @pictures = 1.upto(5) { @message.pictures.build }
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.category_id = params[:category_id]
    if @message.save
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def update
    @message.category_id = params[:category_id]
    if @message.update_attributes(message_params)
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to root_path if @message.destroy
  end
  
  def like
    redirect_back(fallback_location: root_path) if @message.liked_by current_user
  end
  
  def unlike
    redirect_back(fallback_location: root_path) if @message.unliked_by current_user
  end
  
  private
    def find_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:title, :content, :category_id, pictures_attributes: [:message_id, :id, :image])
    end
    
end
