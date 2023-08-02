class ToysController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update, :destroy]
    before_action :previous_url,   only: [:new, :show]

    def show
        @toy = Toy.find(params[:id])
    end

    def new
        @toy = Toy.new
    end

    def create
        @toy = current_user.toys.build(toy_params)
        @toy.images.attach(params[:images])
        if @toy.save
            flash[:success] = "Toy uploaded!"
            redirect_to session[:forwarding_url] || root_url
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        @toy.destroy
        flash[:success] = "Toy deleted"
        redirect_to session[:forwarding_url] || root_url
    end

    def edit
        @toy = Toy.find(params[:id])
    end

    def update
        if @toy.update(toy_params)
            flash[:success] = "Toy updated"
            redirect_to @toy
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    private

        def toy_params
            params.require(:toy).permit(:name, :description, images: [])
        end

        def correct_user
            @toy = current_user.toys.find_by(id: params[:id])
            redirect_to(root_url, status: :see_other) if @toy.nil?
        end

        def previous_url
            session[:forwarding_url] = request.referrer if request.get?
        end
end
