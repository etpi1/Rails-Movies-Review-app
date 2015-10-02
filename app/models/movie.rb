class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, 
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future
  
  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  protected
  
  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

  mount_uploader :image, ImageUploader

  def self.search(title, director, duration)
    where("title LIKE ? AND director LIKE ?", "%#{title}%", "%#{director}%").where(runtime_in_minutes: Movie.get_duration(duration))
  end

  def self.get_duration(duration)
    case duration
    when "1"
      return (0..89)
    when "2"
      return (90..120)
    when "3"
      return (121..300)
    else
      return (0..300)
    end
  end 

end
