#!/usr/bin/ruby

require 'socket'
bowdlator = UNIXSocket.new '/usr/local/var/run/bowdlator.sock'

composed = ''
while data = bowdlator.recv(160)
    data = data[0...-1]
    if data.eql? "\b"
        data = composed[-2] || "\b"
        composed = composed[0...-2]
    end

    if data =~ /^[^[:graph:]]/n
        composed = composed.gsub('s**t'){"shit"}
                           .gsub('d**n'){"damn"}
                           .gsub('a**e'){"arse"}

        bowdlator.write(composed + "\0\4\0")
        composed = ''
        next
    end

    composed += data
    bowdlator.write composed
end
