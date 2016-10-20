# require_dependency File.join Gem.loaded_specs['locomotivecms_steam'].full_gem_path, 'lib/locomotive/steam/entities/site'

class Locomotive::Steam::Site
  
  attr_writer :request_geolocation_lock_countries
  def request_geolocation_lock_countries
    self[:request_geolocation_lock_countries] || ""
  end
  
  
end
