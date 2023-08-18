class Contact < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "must be a valid 10-digit phone number" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  def self.to_csv
    attributes = %w[id first_name last_name phone email]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |contact|
        csv << [contact.id, contact.first_name, contact.last_name, contact.phone, contact.email]
      end
    end
  end
end
