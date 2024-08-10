class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build(bookmark_params) # Associe le bookmark à la list

    #//version sans le build pour lier les deux
    # Crée un nouvel objet Bookmark
    #@bookmark = Bookmark.new(bookmark_params)
    # Associe le bookmark à la liste
    #@bookmark.list_id = @list.id
    #//version sans le build pour lier les deux

    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie successfully added", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list_id
    @bookmark.destroy
    redirect_to list_path(@list), notice: "Movie successfully removed", status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id,:comment)
  end
end
