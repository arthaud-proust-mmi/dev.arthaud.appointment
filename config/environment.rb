# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# enlever le wrapper field_with_errors des formulaires
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html_tag.html_safe
end