# frozen_string_literal: true

SimpleForm.setup do |config|
  # Tailwind CSS用のデフォルトwrapper
  config.wrappers :default, class: "mb-4" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "block text-sm font-medium text-gray-700 mb-1"
    b.use :input, class: "form-input", error_class: "form-input-error", valid_class: "form-input-valid"
    b.use :hint, wrap_with: { tag: :p, class: "mt-1 text-sm text-gray-500" }
    b.use :error, wrap_with: { tag: :p, class: "mt-1 text-sm text-red-600" }
  end

  # checkbox用wrapper
  config.wrappers :boolean, class: "mb-4 flex items-center" do |b|
    b.use :html5
    b.optional :readonly

    b.use :input, class: "form-checkbox"
    b.use :label, class: "ml-2 text-sm text-gray-700"
    b.use :hint, wrap_with: { tag: :p, class: "mt-1 text-sm text-gray-500" }
    b.use :error, wrap_with: { tag: :p, class: "mt-1 text-sm text-red-600" }
  end

  # inline form用wrapper
  config.wrappers :inline, class: "inline-block mr-4" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "block text-sm font-medium text-gray-700 mb-1"
    b.use :input, class: "form-input", error_class: "form-input-error"
    b.use :hint, wrap_with: { tag: :p, class: "mt-1 text-sm text-gray-500" }
    b.use :error, wrap_with: { tag: :p, class: "mt-1 text-sm text-red-600" }
  end

  config.default_wrapper = :default
  config.boolean_style = :inline
  config.button_class = "btn btn-primary"
  config.error_notification_tag = :div
  config.error_notification_class = "bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4"
  config.browser_validations = false
  config.boolean_label_class = "ml-2 text-sm text-gray-700"

  # input type毎のwrapper指定
  config.wrapper_mappings = {
    boolean: :boolean
  }
end
