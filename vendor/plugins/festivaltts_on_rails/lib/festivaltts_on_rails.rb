# FestivalttsOnRails
require "digest/md5"
require "#{File.dirname(__FILE__)}/festival4r.rb"

MP3_FLASH_PLAYER_URL = "/flash/dewplayer.swf"
MP3_FOLDER_URL = "/festivaltts_mp3"
MP3_FOLDER_PATH = "#{RAILS_ROOT}/public/#{MP3_FOLDER_URL}"

# Generates the mp3 file and the javascript utility that shows the
# voice player.
# The options avaliable are:
# - bgcolor: default = "FFFFFF"
# - width: default = 200 
# - height: default = 20
def text_to_flash_player(text, opts = {})
  bgcolor = opts[:bgcolor] if opts[:bgcolor]
  width = opts[:width] if opts[:width]
  height = opts[:height] if opts[:height]

  filename =  Digest::MD5.hexdigest(text).to_s + ".mp3"
    
  text.to_mp3(MP3_FOLDER_PATH + "/" + filename) unless File.exists?(MP3_FOLDER_PATH + "/" + filename)  
  html_for_mp3_flash(MP3_FOLDER_URL + "/" + filename)
end

# Returns needed html for playing mp3.
def html_for_mp3_flash(filename, bgcolor = "FFFFFF", width = 200, height = 20)
  "    <object type=\"application/x-shockwave-flash\"\n \
   data=\"#{MP3_FLASH_PLAYER_URL}?son=#{filename}&amp;bgcolor=#{bgcolor}\" width=\"#{width}\"\n \
   height=\"#{height}\">\n \
   <param name=\"movie\" value=\"#{MP3_FLASH_PLAYER_URL}?son=#{filename}&amp;bgcolor=#{bgcolor}\" />\n \
   </object>"
end

# jQuery jPlayer support
def jPlayer_tts(text)
  filename =  Digest::MD5.hexdigest(text).to_s + ".mp3"
  text.to_mp3(MP3_FOLDER_PATH + "/" + filename) unless File.exists?(MP3_FOLDER_PATH + "/" + filename)  

<<EOS
$(document).ready(function(){
   $("#jquery_jplayer").jPlayer({
    ready: function () {
      $(this).setFile('http://www.miaowmusic.com/mp3/Miaow-05-The-separation.mp3').play();
    }
  })
 
  $("#track-01").click(function() {
    $("#jquery_jplayer").setFile('http://www.miaowmusic.com/mp3/Miaow-05-The-separation.mp3').play();
    return false;
  });
 
  $("#track-02").click(function() {
    $("#jquery_jplayer").setFile('http://www.miaowmusic.com/mp3/Miaow-04-Lismore.mp3').play();
    return false;
  });
 
  $("#track-03").click(function() {
    $("#jquery_jplayer").setFile('http://www.miaowmusic.com/mp3/Miaow-10-Thin-ice.mp3').play();
    return false;
  });
});
EOS
end

def audioPlayer(text)
  filename =  Digest::MD5.hexdigest(text).to_s + ".mp3"
  text.to_mp3(MP3_FOLDER_PATH + "/" + filename) unless File.exists?(MP3_FOLDER_PATH + "/" + filename)  

<<EOS
<script type="text/javascript">  
AudioPlayer.embed("audioPlayer", {  
    soundFile: "#{MP3_FOLDER_URL + "/" + filename}",
    initialvolume: 100,  
    transparentpagebg: "yes",  
    left: "000000",  
    lefticon: "FFFFFF",
    titles: "Fusion AI", 
    autostart: "yes"  
});  
</script> 
EOS
end
