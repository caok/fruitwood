class DatePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, :class => 'input-append date') do
      result = @builder.text_field(attribute_name,input_html_options)
      result += template.content_tag(:span, :class => 'add-on') do
        template.content_tag(:i, '', :class => 'icon-calendar datepicker-trigger')
      end

      result.html_safe
    end
  end
end
