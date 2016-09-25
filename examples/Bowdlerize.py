#!/usr/bin/python

import socket
import re

bowdlator = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
bowdlator.connect('/usr/local/var/run/bowdlator.sock')

data = bowdlator.recv(160)
composed = ''
while data:
    data = data[:-1]
    if re.match('\b', data):
        if len(composed) >= 2:
            data = composed[-2]
        else:
            data = '\b'

        composed = composed[:-2]
    
    if re.match('^[^\41-\176]', data):
        composed = composed.replace('shit', "s**t") \
                           .replace('damn', "d**n") \
                           .replace('arse', "a**e")

        bowdlator.send(composed + "\0\4\0")
        composed = ''
        continue


    composed += data;

    bowdlator.send(composed)
    data = bowdlator.recv(160)
