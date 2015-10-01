module FieldFormatPatch

  module Base
    def self.included(base)
      base.class_eval do
        # Set this to true if the format supports dynamic adding
        class_attribute :dynamic_supported
        self.dynamic_supported = false
      end
    end
  end

  module ListFormat
    def self.included(base)
      base.class_eval do
        self.dynamic_supported = true
      end
    end

  end

end

Redmine::FieldFormat::Base.send(:include, FieldFormatPatch::Base)
Redmine::FieldFormat::ListFormat.send(:include, FieldFormatPatch::ListFormat)
