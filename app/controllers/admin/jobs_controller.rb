class Admin::JobsController < ApplicationController
  before_action :require_is_admin
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
    redirect_to admin_jobs_path, notice: "已更改"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:alert] = "已删除"
    redirect_to admin_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description)
  end

  def require_is_admin
    if !current_user.admin?
      flash[:alert]="ur not an admin"
      redirect_to root_path
    end
  end
end
