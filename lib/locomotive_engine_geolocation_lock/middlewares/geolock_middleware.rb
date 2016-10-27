require 'locomotive/steam/middlewares/thread_safe'
require_relative  '../helpers'


module LocomotiveEngineGeolocationLock
  module Middlewares

    class GeolockMiddleware < ::Locomotive::Steam::Middlewares::ThreadSafe

      include ::LocomotiveEngineGeolocationLock::Helpers

      def _call
        if ::Locomotive::Steam.configuration.mode != :test
          lock_page_handle = 'locked-country'
          Rails.logger.warn "-------------------------------------> > > > > #{env['HTTP_HOST']} #{env.key? 'HTTP_HOST'}"
          Rails.logger.warn "-------------------------------------> > > > > #{env['HTTP_X_FORWARDED_FOR']}"
          lock_page_handle = ENV['GEOLOCATION_LOCK_PAGE_HANDLE'] unless ENV['GEOLOCATION_LOCK_PAGE_HANDLE'].nil?
          unless page.handle == lock_page_handle
            request_ip = get_client_ip
            user_country = get_country_by_ip(request_ip)
            lock_countries = site.request_geolocation_lock_countries.gsub(/\s+/, "").downcase.split(',')
            if (lock_countries.include? user_country.downcase)
              redirect_to_page lock_page_handle , 302
            end
          end
        end
      end
    end
  end
end
