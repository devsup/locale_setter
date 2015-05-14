class Configuration
  attr_accessor :url_param, :cookie_key, :localized_domains, :http_header

  def initialize(options)
    options.each_pair { |k, v| send(:"#{k}=", v) }
  end
end
