module LocaleSetter
  module Controller
    def self.included(controller)
      controller.before_filter :set_locale
    end

    def default_url_options(options = {})
      if i18n.locale != i18n.default_locale && params[LocaleSetter.config.url_param]
        {LocaleSetter.config.url_param => i18n.locale}.merge(options)
      else
        options
      end
    end

    def set_locale
      Generic.set_locale(
        i18n,
        {:params => params,
         :user   => locale_user,
         :domain => request.host,
         :env    => request.env}
      )
    end

    def locale_user
      cookie_key = LocaleSetter.config.cookie_key.to_sym
      cookies[cookie_key]
    end

    def i18n
      I18n
    end
  end
end
