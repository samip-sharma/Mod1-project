
def play_music(link)
  if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
   system "start #{link}"
  elsif RbConfig::CONFIG["host_os"] =~ /darwin/
   system "open #{link}"
  elsif RbConfig::CONFIG["host_os"] =~ /linux|bsd/
   system "xdg-open #{link}"
  end

end
