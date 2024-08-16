class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new]
  before_action :set_list, only: %i[show destroy]

  def index
    @lists = List.all
    @user = current_user
  end

  def new
    # @list = List.new
    if current_user == nil
      @list = List.new
    else
      @list = current_user.lists.build
    end
  end

  def create
    # @list = List.new(list_params)
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to list_path(@list), notice: "List successfully created", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @review = Review.new(list_id: @list.id)
    # @review = Review.new(list: @list)
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: "List successfully deleted", status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :image)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
