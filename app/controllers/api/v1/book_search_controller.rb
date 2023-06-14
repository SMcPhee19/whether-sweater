class Api::V1::BookSearchController < ApplicationController
  def index
    # if params[:location] == nil || params[:quantity] == nil || params[:location] == nil && params[:quantity] == nil
    #   render json: { error: 'No location or quantity given' }, status: 400
    # else
    search = BookFacade.new.search_books(params[:location], params[:quantity])
    render json: BooksSerializer.new(search)
    # end
  end
end
