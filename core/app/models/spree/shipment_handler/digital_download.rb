module Spree
  module ShipmentHandler
    class DigitalDownload
      class << self
        def handle_after_ship(shipment)
          # do whatever specific handling for digital downlaods
          # DRY issue below (see comments in shipment_handler)
          inventory_units.each &:ship!
          send_shipped_email
          touch :shipped_at
          update_order_shipment_state
        end
      end
    end
  end
end
