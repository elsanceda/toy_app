class StaticPagesController < ApplicationController
  def home
    @toys = Toy.includes(images_attachments: :blob).paginate(page: params[:page])
  end

  def about
  end

  def contact
  end
end
