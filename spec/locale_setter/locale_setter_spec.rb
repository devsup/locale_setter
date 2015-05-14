require 'spec_helper'

describe LocaleSetter do
  context "configuring" do

    before { described_class.configuration = nil }

    it "should be possible to set values via plain calls" do
      described_class.config.url_param = :some_method
      expect(described_class.config.url_param).to eq(:some_method)
    end

    it "should be possible to set values via block" do
      described_class.configure do |conf|
        conf.url_param = :some_method
      end

      expect(described_class.config.url_param).to eq(:some_method)
    end

    it "initializes config with default values" do
      expect(described_class.config.url_param).to eq(described_class::URL_PARAM)
      expect(described_class.config.cookie_key).to eq(described_class::COOKIE_KEY)
      expect(described_class.config.localized_domains).to eq({})
    end
  end
end
