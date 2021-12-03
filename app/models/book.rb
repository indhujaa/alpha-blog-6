class Book < ApplicationRecord
  validates :title,presence:true,length:{minimum:6,maximum:10}
  validates :description,presence:true,length:{minimum:15,maximum:500}
  validates :author,presence:true,length:{minimum:6,maximum:10}
end
