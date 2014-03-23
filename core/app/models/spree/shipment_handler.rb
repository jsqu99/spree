module Spree
  class ShipmentHandler
    class << self
      def handle_after_ship(shipment)

        # Do we have a specialized shipping-method-specific handler? e.g:
        # Given shipment.shipping_method = Spree::ShippingMethod::DigitalDownload
        # do we have Spree::ShipmentHandler::DigitalDownload?
        if sm_handler = "Spree::ShipmentHandler::#{shipment.shipping_method.to_s.split('::').last}".constantize rescue false
          sm_handler.handle_after_ship(shipment)
        else
          # question: most/all of this should happend regardless...right?  So maybe not put this in 'else'?
          inventory_units.each &:ship!
          send_shipped_email
          touch :shipped_at
          update_order_shipment_state
        end
      end
    end
  end
end
