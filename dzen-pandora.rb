
require 'socket'
require 'uri'

PORT = 1338

def make_button (action, image)
  icon_path = '/'+File.expand_path($0).split('/')[1..-2].join('/')+'/icons/'
  "^ca(1,curl http://localhost:#{PORT}/click%7c#{action}) ^i(#{icon_path}#{image}.xbm) ^ca()"
end

PLAY = make_button 'play', 'pause'
UP   = make_button 'up',   'thumbsup'
DOWN = make_button 'down', 'thumbsdown'
SKIP = make_button 'skip', 'skip'

$action_queue = ''

def pandora (song, artist, album, liked)
  color = liked == 'true' ? '^fg(#cb4b16)' : ''
  $stdout.puts "#{artist} - #{song}  #{DOWN}#{color}#{UP}^fg()#{PLAY}#{SKIP}"
  $stdout.flush
  retval = $action_queue
  $action_queue = ''
  retval
end

def click (action)
  $action_queue = action
end

webserver = TCPServer.new('localhost', PORT)

while (session = webserver.accept)
  session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
  request = session.gets.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
  session.print (send *URI.decode(request).split('|',-1))
  session.close
end

