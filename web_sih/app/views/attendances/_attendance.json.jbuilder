json.extract! attendance, :id, :image_uri, :location, :remarks, :timeIn, :timeOut, :employee_id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
