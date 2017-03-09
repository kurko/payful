module Payful
  class Transaction < ActiveRecord::Base
    STATES = ["pending", "complete"]

    attr_accessor :metadata

    has_and_belongs_to_many :memberships, join_table: 'payful_memberships_transactions'
    has_many :services, through: :memberships
    belongs_to :owner, polymorphic: true

    validates :state, inclusion: { in: STATES }
    validates :amount_in_cents, numericality: { greater_than: 0 }

    after_initialize :set_attributes
    before_save :set_metadata

    def metadata
      if metadata_json.present?
        @metadata ||= ActiveSupport::JSON.decode(self.metadata_json)
      end
      @metadata || {}
    end

    def customer
      memberships.first.memberable
    end

    # TODO test
    def update_payment_details(params)
      update!(
        payment_url: params[:payment_url],
        payment_remote_id: params[:payment_remote_id]
      )
    end

    def mark_as_emailed!
      update!(payment_emailed_at: Time.now)
    end

    def mark_as_complete(at = Time.now)
      update!(state: 'complete', completed_at: at)
    end

    def self.has_any_complete_this_month?
      where(
        'payful_transactions.state = ? AND completed_at >= ?',
        'complete',
        Time.new.utc.beginning_of_month
      ).present?
    end

    private

    def set_attributes
      self.state = :pending if state.blank?
    end

    def set_metadata
      self.metadata_json = ActiveSupport::JSON.encode(metadata)
    end
  end
end
