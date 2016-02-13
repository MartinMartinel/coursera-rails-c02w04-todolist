class Profile < ActiveRecord::Base
  belongs_to :user
  validates :gender, inclusion: { in: %w(male female), message: "%{value} must be male or female."}
  validates :first_name, presence: true, if: "last_name.nil?"
  validates :last_name, presence: true, if: "first_name.nil?"

  validates :first_name, exclusion: { in: %w(Sue), message: "%{value} invalid for a male"}, if: :male?
 
  def male?
    gender == "male"
  end

  def self.get_all_profiles(min_y, max_y)
  	where('birth_year BETWEEN :min_year AND :max_year ', min_year: min_y, max_year: max_y).order(:birth_year).to_a
  end



end

