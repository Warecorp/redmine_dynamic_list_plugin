class CustomField::ValuesController < ApplicationController
  unloadable

  helper :custom_fields

  before_filter :find_custom_field, :find_project, :find_customized, :find_tracker, :authorize_editing

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @custom_field.add_possible_values params[:value]
    @custom_field.save
    @custom_value = find_custom_value
    @with_label = params[:with_label] == '1'
    respond_to do |format|
      format.js
    end
  end

  private

  def find_custom_value
    @customized.custom_field_values.find { |v| v.custom_field_id == @custom_field.id }
  end

  def find_tracker
    if @customized.is_a?(Issue)
      @customized.tracker ||= Tracker.find(params[:tracker_id])
    end
  end

  def find_custom_field
    @custom_field = CustomField.find(params[:custom_field_id])
  end

  def find_customized
    klazz = params[:customized_type].constantize
    @customized = if params[:customized_id].present?
      klazz.find params[:customized_id]
    else
      klazz.new
    end
    if klazz.method_defined?(:project)
      if @customized.project.nil?
        if klazz.method_defined?(:project=)
          @customized.project = @project
        end
      else
        @project = @customized.project
      end
    end
  end

  def find_project
    @project = Project.find(params[:project_id]) if params[:project_id].present?
  end

  def authorize_editing
    unless User.current.allowed_to_edit?(@customized, @project)
      deny_access
    end
  end
end
