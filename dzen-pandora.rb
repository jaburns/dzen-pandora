
require 'socket'
require 'uri'

PORT = 1338

CURL = "^ca(1,curl http://localhost:#{PORT}/click%7c"
BUTTON = "   "

PLAY = "^bg(green)#{CURL}play)#{BUTTON}^ca()^bg()"
UP   = "^bg(blue)#{CURL}up)#{BUTTON}^ca()^bg()"
DOWN = "^bg(red)#{CURL}down)#{BUTTON}^ca()^bg()"
SKIP = "^bg(yellow)#{CURL}skip)#{BUTTON}^ca()^bg()"

$action_queue = ''

def pandora (song, artist, album, liked)
  color = liked == 'true' ? 'cyan' : 'white'
  $stdout.puts "^fg(#{color})#{artist} - #{song}   ^fg()#{PLAY}#{UP}#{DOWN}#{SKIP}"
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

