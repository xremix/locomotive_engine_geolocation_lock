require           'locomotive/steam'
require_relative  'locomotive/steam/entities/site'
require_relative  'locomotive_engine_geolocation_lock/middlewares/geolock_middleware'

Locomotive::Steam.configure_extension do |config|
  config.middleware.insert_after Locomotive::Steam::Middlewares::TemplatizedPage, LocomotiveEngineGeolocationLock::Middlewares::GeolockMiddleware
end
