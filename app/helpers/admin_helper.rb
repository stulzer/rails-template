module AdminHelper
  def link_to_edit(url, html_options = {})
    html_options.reverse_merge!(class: "button-green edit")
    link_to "Editar", url, html_options
  end

  def link_to_destroy(url, html_options = {})
    html_options.reverse_merge!(confirm: 'Tem certeza?', method: :delete, class: "button-red delete")
    link_to "Deletar", url, html_options
  end
end
