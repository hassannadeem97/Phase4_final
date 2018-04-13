json.extract! registration, :id, :camp_id, :student_id, :payment, :created_at, :updated_at
json.url registration_url(registration, format: :json)
