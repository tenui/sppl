module ApplicationHelper

  # Class Methods
  def ApplicationHelper.Name
    "The Sausage Party Poker League"
  end

  def ApplicationHelper.ShortName
    "SPPL"
  end

  # Returns the text of the main menu markup (XML).
  def resource_menu
    xml = Builder::XmlMarkup.new
    xml.div(:id => "ResourceMenu") do
      xml << resource_tab_link("players", "Players")
      xml << resource_tab_link("games",   "Games")
      xml << resource_tab_link("matches", "Matches")
      xml << resource_tab_link("seasons", "Seasons")
    end
  end

  def resource_selected?(resource)
    resource == controller.controller_name
  end
  
  def resource_tab_link(resource, label)
    html_opts = (resource_selected?(resource)) ? {"class" => "selected"} : {}
    link_to(label, {:controller => resource, :action => "index"}, html_opts) 
  end

  def set_focus(id)
    javascript_tag("$('#{id}').focus()")
  end
  
end
