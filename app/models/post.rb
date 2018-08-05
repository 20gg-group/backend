class Post < ApplicationRecord
  belongs_to :user
  has_one :address, autosave: true, dependent: :destroy #autosave=> update , build_address=>tao obj
  accepts_nested_attributes_for :address 
  has_many :images , dependent: :destroy 
  accepts_nested_attributes_for :images,reject_if: :all_blank, allow_destroy: true


  before_save :set_date_post
  
  validates :title, presence: true#,length:# {minimum:1, maximum:100}
  #validates :price,:area,:decription,:phone_contact_number, presence: true
  enum role: [:user, :admin]
  #enum type_house: ["Phòng cho thuê","Phòng ở ghép"]

  acts_as_votable

  #paginates_per 50
  #max_paginates_per 100
  
  def set_date_post
    self.date_post=Time.now
  end

  
end