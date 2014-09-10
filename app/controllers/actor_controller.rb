class ActorController < ApplicationController
    def index
        @actors = Actor.paginate(:page => params[:page]).order('name ASC')
    end

    def show
        @actor = Actor.find(params[:id])
    end
end
