#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""List keywords from catalog file given as first argument
"""
import sys
import re

fn = sys.argv[1] #"catalog"
f = open (fn, 'r');
folders = {}
while True:
    line = f.readline()
    if not line:
            break
    # "test	invalid-creation-instruction	valid012 tcf pass validity extra..."
    words = re.split('\s+', line)
    if words[0] == 'test' and len(words) >= 6: 
        l_name = words[2]
        l_name = l_name.strip()
        p = re.search('\d', l_name)
        if p is not None:
            l_name = l_name[:p.start()]
        if len(l_name) == 0:
            l_name="_"
        if folders.has_key (l_name):
            count = folders[l_name] + 1
        else:
            count = 1
        folders[l_name]=count
        #print "%s %d" % (l_name, count)
f.close()

total=0
for n in sorted(folders, key=folders.get, reverse=True):
    total=total + folders[n]
    print "%s %d" % (n, folders[n])

print "" 
print "TOTAL %d (out of %d folders)" % (total, len(folders))
