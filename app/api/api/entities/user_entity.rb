module Api::Entities
    class UserEntity < Grape::Entity
      root 'user'
      expose :id, documentation: { type: "Integer"}
      expose :full_name, documentation: { type: "String"}
      expose :email, documentation: { type: "String"}
      expose :phone_number, documentation: { type: "String" }
      expose :avatar 
    end
  end