# patches
require_dependency 'field_format_patch'
require_dependency 'custom_field_patch'
require_dependency 'custom_fields_helper_patch'
require_dependency 'user_patch'

# hooks
require_dependency 'dynamic_list_hook_listener'

Redmine::Plugin.register :redmine_dynamic_list_plugin do
  name 'Redmine Dynamic List Plugin plugin'
  author 'Ilya Andreyuk'
  description 'This plugin allows to add values to the list while selecting'
  version '1.0.0'
  url 'https://github.com/IluhaAndr/redmine_dynamic_list_plugin'
  author_url 'https://github.com/IluhaAndr'
end
