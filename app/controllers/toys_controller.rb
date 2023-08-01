class ToysController < ApplicationController

    def index
        @toys = Toy.paginate(page: params[:page])
    end

    def show
        @toy = Toy.find(params[:id])
    end

    private

        def toy_params
            params.require(:toy).permit(:name, :description)
        end
end
