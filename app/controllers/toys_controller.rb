class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys, except: [:created_at, :updated_at]
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, except: [:created_at, :updated_at], status: :created
  end

  def update
    toy = find_toy
    toy.update(toy_params)
    render json: toy, except: [:created_at, :updated_at], status: :ok
  rescue ApplicationRecord::RecordNotFound
    render_not_found_response
  end

  def destroy
    toy = find_toy
    toy.destroy
    head :no_content
  rescue ApplicationRecord::RecordNotFound
    render_not_found_response
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def find_toy
    Toy.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "toy not found" }, status: :not_found
  end
end
