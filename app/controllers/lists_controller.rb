class ListsController < ApplicationController
  before_action :set_list, only: %i[show]

  def index
    @lists = List.all
    @bookmarks = Bookmark.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
    @movies = Movie.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end


private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end

end
