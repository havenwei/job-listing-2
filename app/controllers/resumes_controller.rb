class ResumesController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find(params[:job_id])
    if !current_user.applied?(@job)
      @resume = Resume.new
    else
      flash[:warning] = "You have applied this job!"
      redirect_to root_path
    end
  end

  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user
    current_user.applied!(@job)

    if @resume.save
      flash[:notice] = "成功提交履历"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  private
  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
