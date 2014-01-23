class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reports, inverse_of: :user

  def self.without_report
    all.select { |user| user.reports.since_last_monday.empty? }
  end

  def self.all_ids
    select(:id).all.map { |user| user.id }
  end
end
