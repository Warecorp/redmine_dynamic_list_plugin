module UserPatch
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def allowed_to_edit?(object, project)
      if object.is_a?(Issue)
        allowed_to?(:edit_issues, project)
      elsif object.is_a?(Project)
        allowed_to?(:edit_project, project)
      elsif object.is_a?(TimeEntry)
        allowed_to?(:edit_own_time_entries, project)
      elsif object.is_a?(TimeEntryActivity)
        allowed_to?(:manage_project_activities, project)
      elsif object.is_a?(Version)
        allowed_to?(:manage_versions, project)
      elsif object.is_a?(Document)
        allowed_to?(:edit_documents, project)
      end || admin?
    end

  end

end

User.send(:include, UserPatch)
