# frozen_string_literal: true

class DepartmentsController < ApplicationController
  skip_before_action :authenticate_admin!, only: %i[index]
  before_action :set_department, only: %i[edit update destroy]

  def index
    @departments = departments
  end

  def new
    @department = departments.new
  end

  def edit; end

  def create
    @department = departments.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, notice: 'Department was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, notice: 'Department was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy!

    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_department
    @department = departments.find(params[:id])
  end

  def departments
    @departments ||= Department.all
  end

  def department_params
    params.require(:department).permit(:name, :descripton)
  end
end
