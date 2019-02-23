module FormatHelper
  def place(rank)
    if rank&.dsq
      "DSQ"
    elsif rank
      "#{rank.result}<sup>#{rank.result == 1 ? 're' : 'e'}</sup> place".html_safe
    else
      ""
    end
  end

  def result(rank)
    return unless rank
    if rank.result == 1
      '<span class="trophies"><i class="fa fa-trophy"></i></span>'.html_safe
    elsif rank.dsq
      "DSQ"
    else
      rank.result
    end
  end

  def track_result(rank)
    return unless rank
    if rank.result == 1
      '<span class="medals"><i class="icomoon icon-medal"></i></span>'.html_safe
    else
      rank.result
    end
  end

  def page_title
    current_page.data.title || yield_content(:page_title) || "Somewherexpress"
  end

  def page_description
    current_page.data.description || yield_content(:page_description) || ""
  end
end
