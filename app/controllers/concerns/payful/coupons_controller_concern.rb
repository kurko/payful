module Payful
  module CouponsControllerConcern
    def index
      @resources = Payful::Coupon.all
      render 'payful/coupons/index'
    end

    def new
      @resource = Payful::Coupon.new
      render 'payful/coupons/new'
    end

    def edit
      @resource = Payful::Coupon.find(params[:id])
      render 'payful/coupons/edit'
    end

    def create
      @metadata ||= {}
      @resource = Payful::Coupon.new(resource_params)
      if @resource.save
        redirect_to redirect_path_after_create, notice: t("views.forms.saved")
      else
        render :new
      end
    end

    def update
      @metadata ||= {}
      @resource = Payful::Coupon.find(params[:id])
      if @resource.update(resource_params)
        redirect_to redirect_path_after_update, notice: t("views.forms.saved")
      else
        render 'payful/coupons/edit'
      end
    end

    private

    def redirect_path_after_create
      coupons_url
    end

    def redirect_path_after_update
      coupons_url
    end

    def customer_model
      raise StandardError, "Undefined method #customer_model"
    end

    def update_path
      raise StandardError, "Undefined method #update_path"
    end

    def resource_params
      params
        .require(:coupon)
        .permit(
          :code,
          :description,
          :valid_from,
          :valid_until,
          :redemption_limit,
          :amount,
          :coupon_type
        )
    end
  end
end
