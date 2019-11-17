class ApplicationController < ActionController::API
  def serialize_resource(*resource)
    ActiveModelSerializers::SerializableResource.new(*resource).serializable_hash
  end
end
