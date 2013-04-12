# written in Ruby 2.0.0p0 on MRI, Mac OS X 10.7

require 'thread'

sounds = ["Ping!", "Pong!"]
threads = []
iterations = 3

mx = Mutex.new
cv = ConditionVariable.new

puts "Ready... Set... Go!"

sounds.each do |sound|
  threads << Thread.new do
    iterations.times do |i|
      mx.synchronize do
        puts sound
        cv.signal
        cv.wait(mx) unless i == iterations - 1
      end
    end
  end
end

threads.each { |t| t.join }

puts "Done!"

