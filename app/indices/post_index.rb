ThinkingSphinx::Index.define :post, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes text

  # attributes
  has user_id, created_at, updated_at
  has tags.id, :as => :tag_ids
end