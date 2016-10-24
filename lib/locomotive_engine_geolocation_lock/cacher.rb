require 'singleton'
module LocomotiveEngineGeolocationLock
  class Cacher
    include Singleton

    attr_accessor :cache_store
    def self._load()
      instance.cache_store = ActiveSupport::Cache::MemoryStore.new
    end
    
    def self._get_by_key(cache_key)
      if instance.cache_store.nil?
        self._load
      end

      return instance.cache_store.fetch(cache_key)
    end

    def self._set_by_key(cache_key, obj)
      if instance.cache_store.nil?
        self._load
      end

      instance.cache_store.write(cache_key, obj, {expires_in: 1.days})
    end
  end
end