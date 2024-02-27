module ApplicationHelper
  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-danger",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" => "alert-warning"
    }
    bootstrap_alert_class[level]
  end

  def folder_tree_html(nodes, html = '')
    account_id = current_account.id
    nodes.map do |node, sub_nodes|
      padding_left = 5 + node.depth * 18
      html << "<div class='folderTreeRow treeRow noselect folderExpanded' style='padding-left: #{padding_left}px' data-row-expandable data-id='#{node.id}' data-account='#{account_id}'>"
      html << "<i class='folder-expand bi bi-caret-down-fill'></i>"
      html << "#{image_tag ('folder-open.png')}"
      html << "<span title='#{node.name}' class='folderName'>"
      html << (link_to " #{node.name.truncate(10)}", "/accounts/#{current_account.id}/#{controller_name}?folder_id=#{node.id}", remote: true, method: 'get')
      html << "</span>"
      html << "<span class='folder-count badge bg-secondary'>#{node.children.count}</span>"
      html << "</div>"
      html << "</a>"
      unless sub_nodes.blank?
        html << "<div class='folderChildren'>"
        folder_tree_html(sub_nodes, html)
        html << "</div>"
      end
    end
    puts html
    html.html_safe
  end

  def modal_class_name
    controller_name.singularize
  end

  def modal_class
    modal_class_name.camelize
  end
end
