# ClientSideValidations Initializer

require 'client_side_validations/simple_form' if defined?(::SimpleForm)
require 'client_side_validations/formtastic'  if defined?(::Formtastic)

ClientSideValidations::Config.disabled_validators = []

# Uncomment the following block if you want each input field to have the validation messages attached.
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if html_tag =~ /^<label/
    %(<div class="field_with_errors">#{html_tag}</div>).html_safe
  else
    %(<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div>).html_safe
    # {}%{<div class="field_with_errors">#{html_tag}<div class="alert alert-error"><p>#{instance.error_message.first}</p></div></div>}.html_safe
    # {}%{<div class="alert alert-error">#{instance.error_message.first}</div>}.html_safe
  end
end
