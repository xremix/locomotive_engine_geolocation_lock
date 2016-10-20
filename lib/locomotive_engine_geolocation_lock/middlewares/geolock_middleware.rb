require 'locomotive/steam/middlewares/thread_safe'
require_relative  '../helpers'


module LocomotiveEngineGeolocationLock
  module Middlewares

    class GeolockMiddleware < ::Locomotive::Steam::Middlewares::ThreadSafe

      include ::LocomotiveEngineGeolocationLock::Helpers

      def _call
        if ::Locomotive::Steam.configuration.mode != :test
          unless page.handle == 'embargoed-country'
            user_country = get_country_by_ip(request.ip)
            if ('us'.gsub(/\s+/, "").downcase.split(',').include? user_country.downcase)
              redirect_to_page 'embargoed-country' , 302
            end
          end
        end
      end
    end
  end
end