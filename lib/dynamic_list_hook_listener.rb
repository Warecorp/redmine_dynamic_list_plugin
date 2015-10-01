class DynamicListHookListener < Redmine::Hook::ViewListener
  render_on :view_custom_fields_form_upper_box, partial: "list/dynamic_supported_field"
end
