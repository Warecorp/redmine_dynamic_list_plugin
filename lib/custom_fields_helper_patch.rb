module CustomFieldsHelperPatch

  def self.included(base)
    base.send :include, InstanceMethods

    base.class_eval do
      alias_method_chain :custom_field_tag_with_label, :new_value_button
      alias_method_chain :custom_field_tag, :new_value_button
    end
  end

  module InstanceMethods
    def custom_field_tag_with_label_with_new_value_button(name, custom_value, options={})
      custom_field_label_tag(name, custom_value, options) + custom_field_tag_without_new_value_button(name, custom_value) +
        add_new_value_button(name, custom_value, true)
    end

    def custom_field_tag_with_new_value_button(name, custom_value, options={})
      custom_field_tag_without_new_value_button(name, custom_value) +
        add_new_value_button(name, custom_value, false)
    end

    def add_new_value_button(name, custom_value, with_label)
      custom_field = custom_value.custom_field
      customized = custom_value.customized
      project = customized_project(customized)
      if custom_field.format.dynamic_supported && custom_field.dynamic? &&
            User.current.allowed_to_edit?(customized, project)
        path_params = {
          name: name,
          customized_id: customized.id,
          customized_type: customized.class.name,
          project_id: project.try(:id),
          tracker_id: customized_issue_tracker_id(customized),
          with_label: with_label ? 1 : 0
        }
        path = new_custom_field_value_path(custom_field, path_params)
        link_to(image_tag('add.png'), path, remote: true, method: 'get',
                  id: custom_field_add_new_id(name, custom_field))
      else
        ''
      end
    end

    def custom_field_add_new_id prefix, custom_field
      "#{prefix}_custom_field_values_add_new_#{custom_field.id}"
    end

    def customized_project customized
      if [Document, Issue, TimeEntry, TimeEntryActivity,
          Version].include?(customized.class)
        customized.project
      elsif customized.is_a?(Project)
        customized
      end
    end

    def customized_issue_tracker_id customized
      if customized.is_a?(Issue)
        customized.tracker.id
      end
    end
  end

end

CustomFieldsHelper.send(:include, CustomFieldsHelperPatch)
