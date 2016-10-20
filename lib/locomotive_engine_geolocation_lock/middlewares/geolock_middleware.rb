require 'locomotive/steam/middlewares/thread_safe'
require_relative  '../helpers'


module LocomotiveEngineGeolocationLock
  module Middlewares

    class GeolockMiddleware < ::Locomotive::Steam::Middlewares::ThreadSafe

      include ::LocomotiveEngineGeolocationLock::Helpers

      def _call
        if ::Locomotive::Steam.configuration.mode != :test
          unless page.handle == 'embargoed-country'
            request_ip = request.ip
            unless params[:test_geo_ip].blank?
              request_ip = params[:test_geo_ip]
            end
            user_country = get_country_by_ip(request_ip)
            lock_countries = site.request_geolocation_lock_countries.gsub(/\s+/, "").downcase.split(',')
            if (lock_countries.include? user_country.downcase)
              redirect_to_page 'embargoed-country' , 302
            end
          end
        end
      end
    end
  end
end