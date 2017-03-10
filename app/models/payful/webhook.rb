module Payful
  class Webhook < ActiveRecord::Base
    class BadStateTransaction < StandardError; end

    attr_accessor :data

    STATES = ["pending", "failed", "processed"].freeze

    belongs_to :hookable, polymorphic: true
    before_save :set_data
    after_initialize :set_state

    validates :state, inclusion: { in: STATES }

    def data
      if data_json.present?
        @data ||= ActiveSupport::JSON.decode(self.data_json)
      end
      @data || {}
    end

    def mark_as_processed(at = Time.now)
      if processed?
        raise BadStateTransaction, "Cannot transition from processed to processed"
      end

      update!(
        state: "processed",
        processed_at: at
      )
    end

    def processed?
      state == "processed"
    end

    private

    def set_data
      self.data_json = ActiveSupport::JSON.encode(data)
    end

    def set_state
      self.state = 'pending' if state.blank?
    end
  end
end
