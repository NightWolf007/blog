ThinkingSphinx::Index.define :post, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes text

  # attributes
  has created_at, updated_at
  has tags.id, :as => :tag_ids
end