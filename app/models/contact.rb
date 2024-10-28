class Contact < ApplicationRecord
  belongs_to :kind, optional: true

  # def author
  #   "Tiano"
  # end

  # def kind_description
  #   self.kind.description
  # end

  # def as_json(options={})
  #   super(
  #     methods: [:author, :kind_description],
  #     include: { kind: { only: :description } }, root: true
  #   )    
  # end
end
