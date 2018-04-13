json.extract! student, :id, :first_name, :last_name, :family_id, :date_of_birth, :rating, :active, :created_at, :updated_at
json.url student_url(student, format: :json)
