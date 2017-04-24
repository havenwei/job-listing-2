class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :resumes
  has_many :jobs, dependent: :destroy
  has_many :job_applieds
  has_many :applied_jobs, through: :job_applieds, source: :job
  has_many :job_favorites
  has_many :favorite_jobs, through: :job_favorites, source: :job

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  def applied?(job)
    applied_jobs.include?(job)
  end

  def applied!(job)
    applied_jobs << job
  end

  def disapplied!(job)
    applied_jobs.delete(job)
  end
end
