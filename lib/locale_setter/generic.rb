module LocaleSetter
  module Generic

    def self.set_locale(i18n, options = {:params  => nil,
                                         :cookies => nil,
                                         :domain  => nil,
                                         :env     => nil})

      @options = options
      @i18n = i18n
      @i18n.locale = from_params ||
                     from_user   ||
                     from_domain ||
                     from_http   ||
                     i18n.default_locale
    end

    def self.available
      @i18n.available_locales.map(&:to_s)
    end

    def self.from_user
      user_locale = @options[:cookies][LocaleSetter.config.cookie_key.to_sym] 
      LocaleSetter::User.for(user_locale, available)
    end

    def self.from_http
      env = @options[:env] 
      if env && env[HTTP_HEADER]
        LocaleSetter::HTTP.for(env[HTTP_HEADER], available)
      end
    end

    def self.from_domain
      domain = @options[:domain] 
      LocaleSetter::Domain.for(domain, available)
    end

    def self.from_params
      params = @options[:params] 
      if params && params[LocaleSetter.config.url_param]
        locale_from_params = LocaleSetter::Param.for(params[LocaleSetter.config.url_param], available)
        @options[:cookies][LocaleSetter.config.cookie_key.to_sym] = locale_from_params
      end
    end
  end
end
