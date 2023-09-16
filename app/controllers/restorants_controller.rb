# frozen_string_literal: true

class RestorantsController < ApplicationController
  skip_before_action :authenticate_admin!, only: %i[index]
  before_action :set_restorant, only: %i[edit update destroy]

  def index
    @restorants = restorants.all
  end

  def new
    @restorant = restorants.new
  end

  def edit; end

  def create
    @restorant = restorants.new(restorant_params)

    respond_to do |format|
      if @restorant.save
        format.html { redirect_to restorants_url, notice: 'Restorant was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restorant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restorant.update(restorant_params)
        format.html { redirect_to restorants_url, notice: 'Restorant was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restorant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restorant.destroy!

    respond_to do |format|
      format.html { redirect_to restorants_url, notice: 'Restorant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_restorant
    @restorant = restorants.find(params[:id])
  end

  def restorants
    @restorants ||= Restorant.all
  end

  def restorant_params
    params.require(:restorant).permit(:name, :descripton, :phone, :address_street, :address_number, :address_postcode, :address_town)
  end
end
