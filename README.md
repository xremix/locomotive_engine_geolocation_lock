# LocomotiveEngineGeolocationLock

A Locomotive CMS Extension to allow Geolocation Lock based on users IP address — Edit


# Usage

Add the gem in your `Gemfile` after loading the locomotivecms

```
gem 'locomotivecms'
gem 'locomotive_engine_geolocation_lock', git: 'https://github.com/xremix/locomotive_engine_geolocation_lock', require: true
```

You can specify your own geolocation IP in the .env file
```
geolocation_url=http://my_service.io/
```
The ip will get appended at the end of the url