class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token

    rescue_from StandardError, with: :standard_error

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


    def not_found
        render(
            json: {
                errors: [{
                    type: "Not Found"
                }]
            },
            status: :not_found #alias for 404 in rails
        )
    end

    private

    def authenticate_user!
        unless current_user.present?
            render(
                json: {status: 401},
                status: 401 #Unauthorized
            )
        end
    end

    protected
    def record_not_found(error)
        render(
            status: 404,
            json: {
                status: 404,
                errors: [{
                    type: error.class.to_s,
                    message: error.message
                }]
            }
        )
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s, #need it in string format
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: {status: 422, errors: errors },
            status: 422 #alias is :unprocessable_entity
        )
    end

    def standard_error(error)
        logger.error error.full_message

        render(
            status: 500,
            json:{
                status:500,
                errors:[{
                    type: error.class.to_s,
                    message: error.message
                }]
            }
        )
    end
end