class Nomadic

  def self.mobile?
    case ENV['HTTP_USER_AGENT']
      when /(ipod|iphone)/i then return :iphone
      when /android/i then return :android
      when /opera mini/i then return :opera
      when /blackberry/i then return :blackberry
      when /(palm os|palm|hiptop|avantgo|plucker|xiino|blazer|elaine)/i then return :palm
      when /(windows ce; ppc;|windows ce; smartphone;|windows ce; iemobile)/i then return :windows
      when /(up\.browser|up\.link|mmp|symbian|smartphone|midp|wap|vodafone|o2|pocket|kindle|mobile|pda|psp|treo)/i then return :other
    end

    if ENV['HTTP_ACCEPT'] =~ /(text\/vnd\.wap\.wml|application\/vnd\.wap\.xhtml\+xml)/
      return :wap_accept
    end

    if (ENV['HTTP_X_WAP_PROFILE'] && ENV['HTTP_X_WAP_PROFILE'] != "") || (ENV['HTTP_PROFILE'] && ENV['HTTP_PROFILE'] != "")
      return :wap_profile
    end
  end

end