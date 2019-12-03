module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :payment_params, only: %i[create index]

      def index
        payment = Payment.find_by(project_id: payment_params[:project_id])
        if payment
          render json: { success: true, errors: {}, result: { payments: serialize_resource(payment) } }
        else
          render json: { success: true, errors: {}, result: { payments: [] } }
        end
      end

      def create
        user = User.find_by(token: payment_params[:token])
        if user
          payment = Payment.new(
            title: payment_params[:title],
            description: payment_params[:description],
            address: payment_params[:address],
            payment_method: payment_params[:payment_method],
            project_id: payment_params[:project_id],
            amount: payment_params[:amount],
            user_id: user.id
          )
          if payment.save
            project = Project.find(payment_params[:project_id])
            project.update(current_sum: project.current_sum + payment_params[:amount].to_i)
            render json: { success: true, errors: {}, result: { payment: serialize_resource(payment) } }
          else
            render json: { success: false, errors: payment.errors.messages, result: {} }
          end
        else
          render json: { success: false, errors: 'You have not access for this', result: {} }
        end
      end

      private

      def payment_params
        params.permit(:token, :title, :description,
                      :address, :payment_method, :project_id, :amount)
      end
    end
  end
end
