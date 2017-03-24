module Payful
  module MembershipConcern
    def edit
      @customer = customer_model
      Payful::Service.find_each do |service|
        next if @customer.memberships.map(&:payful_service_id).include?(service.id)
        @customer.memberships.build(active: 1, service: service)
      end

      @update_path = update_path

      render 'payful/memberships/edit'
    end

    def update
      @metadata ||= {}
      @transaction_amount ||= 0
      @customer = customer_model
      if @customer.update(update_params)

        # FIXME make it a job?
        # TODO add descriptions
        transaction = Payful::Transaction.create!(
          memberships: @customer.memberships,
          extends_memberships_for_days: @extends_memberships_for_days || params[:payful_period],
          payment_type: "bank_slip",
          metadata: @metadata,
          owner: @customer,
          amount_in_cents: @transaction_amount
        )
        # This will generate a BankSlip or charge a credit
        # card token if needed.
        Payful::ChargeJob.perform_later(transaction.id)

        redirect_to redirect_path_after_update, notice: notice_message_after_update
      else
        render :edit
      end
    end

    private

    def notice_message_after_update
      nil
    end

    def customer_model
      raise StandardError, "Undefined method #customer"
    end

    def update_path
      raise StandardError, "Undefined method #update_path"
    end

    def update_params
      params
        .require(customer_model.class.name.underscore.to_sym)
        .permit(
          memberships_attributes: [
            :id,
            :payful_service_id,
            :active,
            :base_price_days
          ]
        )
    end
  end
end
