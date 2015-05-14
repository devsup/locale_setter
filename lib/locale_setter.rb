require "locale_setter/version"
require "locale_setter/configuration"
require "locale_setter/matcher"
require "locale_setter/controller"
require "locale_setter/railtie" if defined?(Rails)
require "locale_setter/http"
require "locale_setter/user"
require "locale_setter/domain"
require "locale_setter/param"
require "locale_setter/generic"

module LocaleSetter
  HTTP_HEADER = 'HTTP_ACCEPT_LANGUAGE'
  URL_PARAM   = :locale
  COOKIE_KEY  = :locale

  class << self
    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new(default_params)
    end

    def configure
      yield(config)
    end

    private

    def default_params
      {
        :url_param => URL_PARAM,
        :cookie_key => COOKIE_KEY,
        :localized_domains => {}
      }
    end
  end
end
