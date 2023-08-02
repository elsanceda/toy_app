class StaticPagesController < ApplicationController
  def home
    @toys = Toy.paginate(page: params[:page])
  end

  def about
  end

  def contact
  end
end
