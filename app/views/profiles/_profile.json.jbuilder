json.extract! profile, :id, :name, :mobile, :postcode, :address, :address2, :birth, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
