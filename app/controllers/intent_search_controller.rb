class IntentSearchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    data = params[:data]

    if data.blank?
      render json: { error: "Data cannot be empty" }, status: :bad_request
    else
      search_service = IntentSearchService.new(data)
      response = search_service.search_intents
      render json: response
    end
  end
end
