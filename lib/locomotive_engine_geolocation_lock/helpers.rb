require 'locomotive/steam/middlewares/helpers'

module LocomotiveEngineGeolocationLock::Helpers

	include ::Locomotive::Steam::Middlewares::Helpers

	def get_country_by_ip(remote_ip)
		# cache_key = "getcountryip-#{remote_ip}"

  #   	config.cache_store = ActiveSupport::Cache::MemoryStore.new

		# currentCountry = config.cache_store.fetch(cache_key)

		# if currentCountry != nil
		# 	return currentCountry
		# else
			uri = URI.parse("https://freegeoip.net/json/#{remote_ip}")

			# Specify your own service
			if env['geolocation_url'] != nil
				uri = URI.parse(env['geolocation_url'] >> remote_ip)
			end
			
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false

			request = Net::HTTP::Get.new(uri.request_uri)
			request["User-Agent"] = "arthrex-celltherapy-engine"

			resp = http.request(request)
			currentCountry = "DE"

			if valid_json? resp.body
				jsonResp = JSON.parse resp.body
				# currentCountry = jsonResp["country"]
				currentCountry = jsonResp["country_code"]
			end
			# config.cache_store.write(cache_key, currentCountry, {expires_in: 1.days})
			return currentCountry

		# end
	end
	def valid_json?(json)
		begin
			JSON.parse(json)
			return true
		rescue JSON::ParserError => e
			return false
		end
	end

	def redirect_to_page handle, type=301
		target_page = services.page_finder.by_handle handle, false
		target_path = "/#{target_page.fullpath}"
		target_path = "/#{locale}#{target_path}" unless locale == default_locale
		redirect_to target_path, type
	end


end
