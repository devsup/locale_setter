module LocaleSetter
  module Controller
    def self.included(controller)
      controller.before_filter :set_locale
    end

    def default_url_options(options = {})
      if I18n.locale != I18n.default_locale && params[LocaleSetter.config.url_param]
        {LocaleSetter.config.url_param => I18n.locale}.merge(options)
      else
        options
      end
    end

    def set_locale
      Generic.set_locale(
        I18n,
        {:params  => params,
         :cookies => cookies,
         :domain  => request.host,
         :env     => request.env}
      )
      logger.debug "==== #{I18n.locale}"
    end
  end
end
