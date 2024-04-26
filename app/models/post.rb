class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    belongs_to :parent_post, class_name: "Post", optional: true
    has_many :replies, class_name: "Post", foreign_key: "parent_post_id", dependent: :destroy
  
    # Validaciones
    validates :title, presence: { message: "Title can't be blank" }
    validates :content, presence: { message: "Content can't be blank" }
    validates :user_id, presence: { message: "User can't be blank" }
    validates :answers_count, numericality: { greater_than_or_equal_to: 0 }
    validates :likes_count, numericality: { greater_than_or_equal_to: 0 }
    validates :published_at, presence: true
  
    # Callback para establecer la fecha de publicación por defecto
    before_validation :set_default_published_at, on: :create
  
    private
  
    def set_default_published_at
      self.published_at ||= Time.current
    end
  end
  