module CustomFieldPatch
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def add_possible_values(arg)
      if arg.is_a?(Array)
        self.possible_values = self.possible_values + arg
      else
        add_possible_values arg.to_s.split(/[\n\r]+/)
      end
    end

  end

end

CustomField.send(:include, CustomFieldPatch)
