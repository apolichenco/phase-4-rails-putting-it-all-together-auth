class RecipesController < ApplicationController

    # before_action :authorize

    def index
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
        recipes = Recipe.all
        render json: recipes, status: :created
    end

    def create
        # byebug
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
        recipe = Recipe.create(params.permit(:title, :instructions, :minutes_to_complete))
        recipe.update(user_id: session[:user_id])
        if recipe.valid?
            # recipe.update(user_id: session[:user_id])
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    end

end
