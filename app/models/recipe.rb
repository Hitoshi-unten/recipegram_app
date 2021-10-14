class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image

  with_options presence: true do
    validates :title
    validates :body
    validates :image
    # こう書くことでtitle,body,imageが空の投稿は弾いてくれる。
  end

end
