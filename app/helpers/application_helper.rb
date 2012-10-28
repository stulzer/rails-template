module ApplicationHelper
  def error_messages_for(resource)
    render 'shared/error_messages', :resource => resource
  end

  def flash_messages
    flash.collect do |key, msg|
      content_tag(:p, msg, :id => key, :class => "flash-message")
    end.join.html_safe
  end

  def favicon
    "<link rel=\"shortcut icon\" href=\"/assets/favicon.png\" />".html_safe
  end
  
  def analytics(site_id)
    html = <<-ANALYTICS
    <script>
     var _gaq = [['_setAccount', '#{site_id}'], ['_trackPageview']];
     (function(d, t) {
      var g = d.createElement(t),
          s = d.getElementsByTagName(t)[0];
      g.async = true;
      g.src = '//www.google-analytics.com/ga.js';
      s.parentNode.insertBefore(g, s);
     })(document, 'script');
    </script>
    ANALYTICS
    
    html.html_safe
  end

end
