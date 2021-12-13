class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true,length:{minimum:6,maximum:10}
  validates :description,presence:true,length:{minimum:15,maximum:500}
  validates :author,presence:true,length:{minimum:6,maximum:10}
  has_many :book_categories
  has_many :categories,through: :book_categories
end
