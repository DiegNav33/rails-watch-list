class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new]

  def index
    @lists = List.all
    @user = current_user
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list), notice: "List successfully created", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find(params[:id])
    @review = Review.new(list_id: @list.id)
    # @review = Review.new(list: @list)
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path, notice: "List successfully deleted", status: :see_other
  end
  private

  def list_params
    params.require(:list).permit(:name, :image)
  end
end
