class ActorController < ApplicationController
    def index
        @actors = Actor.paginate(:page => params[:page])
    end

    def show
        @actor = Actor.find(params[:id])
    end
end
