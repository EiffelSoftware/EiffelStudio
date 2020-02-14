#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""List keywords from catalog file given as first argument
"""
import sys
import re

fn = sys.argv[1] #"catalog"
f = open (fn, 'r');
keywords = {}
while True:
    line = f.readline()
    if not line:
            break
    # "test	invalid-creation-instruction	valid012 tcf pass validity extra..."
    words = re.split('\s+', line)
    if words[0] == 'test' and len(words) >= 6: 
        kw = words[5]
        kw = kw.strip()
        if len(kw) == 0:
            kw="_undefined"
        if keywords.has_key (kw):
            count = keywords[kw] + 1
        else:
            count = 1
        keywords[kw]=count
        if False:
            i = 0
            for v in words:
                print ("%d/%d) %s" % (i, len(words), v))
                i = i + 1
        #print "%s %d" % (words[5], count)
f.close()

total=0
for kw in sorted(keywords, key=keywords.get, reverse=True):
    total=total + keywords[kw]
    print "%s %d" % (kw, keywords[kw])

print "" 
print "TOTAL %d" % (total)
