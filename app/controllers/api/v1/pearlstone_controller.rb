require 'json'

module Api
  module V1
    class PearlstoneController < ApplicationController
      # include Api::V1::AnasIslamHelper

      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token
      # before_action :firebase_instance

      def index
        _success_response('data tes ')
      rescue StandardError => e
        _error_response(e)
      end

      def create
        added_doc_ref = 'qwer'
        _success_response(added_doc_ref)
        # question = Question.create(question_param)
      rescue StandardError => e
        _error_response e
      end

      def destroy
      end

      def update
        _success_response '111'
          # question = Question.find(params[:id])
      rescue StandardError => e
          _error_response e
      end

      def _success_response(data)
        render json:
                   {status: 'SUCCESS',
                    action: action_name,
                    data: data},
               status: :ok
      end

      def _error_response(e)
        render json:
                   {status: 'ERROR',
                    action: action_name,
                    message: e},
               status: :unprocessable_entity
      end

      def json_to_hash(json)
        data = {}
        json.each do |k,v|
          data.merge!({"#{k}": v})
        end
        data
      end

      def valid_json?(json)
        JSON.parse(json)
        return true
      rescue JSON::ParserError => e
        return false
      end

      def question_param
        params.permit(:total)
      end
    end
  end
end

