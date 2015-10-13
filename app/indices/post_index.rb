ThinkingSphinx::Index.define :post, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes text
  indexes tags.name

  # attributes
  has user_id, created_at, updated_at, tags.id
end