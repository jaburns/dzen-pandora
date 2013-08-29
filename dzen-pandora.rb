
require 'socket'
require 'uri'

PORT = 1338

def make_button (action)
  icon_path = '/'+File.expand_path($0).split('/')[1..-2].join('/')+'/icons/'
  "^ca(1,curl http://localhost:#{PORT}/click%7c#{action}) ^i(#{icon_path}#{action}.xbm) ^ca()"
end

PLAY  = make_button 'play'
PAUSE = make_button 'pause'
UP    = make_button 'up'
DOWN  = make_button 'down'
SKIP  = make_button 'skip'

$action_queue = ''

def pandora (song, artist, album, liked, playing)
  color = liked   == 'true' ? '^fg(#cb4b16)' : ''
  play  = playing == 'true' ? PAUSE : PLAY
  puts "#{artist} - #{song}  #{DOWN}#{color}#{UP}^fg()#{play}#{SKIP}"
  $stdout.flush
  retval = $action_queue
  $action_queue = ''
  retval
end

def click (action)
  $action_queue = action
end

puts "...Pandora..."
$stdout.flush

webserver = TCPServer.new('localhost', PORT)

while (session = webserver.accept)
  session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
  request = session.gets.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
  session.print (send *URI.decode(request).split('|',-1))
  session.close
end

