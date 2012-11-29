module AdminHelper
  def link_to_edit(url, html_options = {})
    html_options.reverse_merge!(:class => "green")
    link_to t(".edit"), url, html_options
  end

  def link_to_destroy(url, html_options = {})
    html_options.reverse_merge!(:confirm => 'Tem certeza?', :method => :delete, :class => "red")
    link_to t(".delete"), url, html_options
  end
end
