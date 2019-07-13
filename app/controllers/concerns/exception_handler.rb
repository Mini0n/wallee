module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |er|
      json_response({ error: er.message.slice(0, er.message.index(' with'))}, :not_found)
    end
  end
end