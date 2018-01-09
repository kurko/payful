module Payful
  module PaymentMethodsConcern
    extend ActiveSupport::Concern

    class_methods do
    end

    included do
      before_action :set_payment_gateway_name

      def index
        @resources = Payful::PaymentMethod.all
        @resources = Kaminari.paginate_array(@resources).page(params[:page]).per(7)
        render 'payful/payment_methods/index'
      end

      def new
        @resource = Payful::PaymentMethod.new
        render 'payful/payment_methods/new'
      end

      def create
        @resource = Payful::PaymentMethod.new(resource_params)
        @resource.owner = payment_method_owner
        @resource.service = payment_gateway_name
        @resource.method_type = payment_method_type
        @resource.is_default = "true"
        details = {
          token: params[:token],
          brand: params[:brand],
          last4: params[:last4],
          full_name: params[:full_name]
        }
        @resource.details = details
        if @resource.save
          redirect_to admin_client_payment_methods_path(@client)
        else
          render 'payful/payment_methods/new'
        end
      end

      def show
        @resource = Payful::PaymentMethod.find(params[:id])
        render 'payful/payment_methods/show'
      end

      private

      def resource_params
        params
          .require(:payment_method)
          .permit(
            :token,
            :brand,
            :last4,
            :full_name
          )
      end

      def set_payment_gateway_name
        @payment_gateway = payment_gateway_name
      end
    end
  end
end
