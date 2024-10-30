class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :kind

  belongs_to :kind do
    link(:related) { contact_kind_url(object.id) }
  end
  has_many :phones
  has_one :address

  # link(:self) { contact_url(object.id) }
  # link(:kind) { kind_url(object.kind.id) }

  # meta do
  #   { author: "Cristiano" }
  # end

  def kind
    object.kind.description
  end

  def as_json(*args)
    h = super(*args)
    # h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_datetime.iso8601 if object.birthdate.present?
    h
  end
end
