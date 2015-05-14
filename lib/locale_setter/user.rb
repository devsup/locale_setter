# this is primarily for 1.8.7 support
# see http://www.ruby-doc.org/core-2.0/Symbol.html#method-i-empty-3F
unless :locale.respond_to? :empty?
  class Symbol
    def empty?
      self.to_s.empty?
    end
  end
end

module LocaleSetter
  module User
    def self.for(user_locale, available)
      if user_locale.present?
        LocaleSetter::Matcher.match user_locale, available
      end
    end
  end
end
