"""A po file"""

__version__ = "$Revision$"
# $Source$

import os
import i18n

class PoFile:
    """A po file"""
    

    def __init__ (self, filepath):
        """Initialize po file with filepath"""
        
        # require
        assert not os.path.isdir(filepath)
        assert not os.path.isfile(filepath) or os.access (filepath, os.W_OK)
        
        self.filepath = filepath
        self.entries = []
        self.entries.append (i18n.PoMessage())
        self.header().msgstr = [[
                 "Plural-Forms: nplurals=2; plural=n>1;\\n",
                 "Content-Type: text/plain; charset=UTF-8\\n",
                 "Content-Transfer-Encoding: 8bit\\n",
                 "MIME-Version: 1.0\\n"
             ]]

    def save (self):
        """Save file to file system"""
        
        file = open (self.filepath, 'w')

        for entry in self.entries:
            file.write("\n")
            entry.write_to_file (file)
        
        file.close()


    def header (self):
        """Po file header"""
        
        return self.entries[0]


    def add_message (self, msg):
        """Add PO message to file"""
        
        # Check if message already exist in the file
        found = False
        for entry in self.entries:
            if entry.msgid == msg.msgid and entry.msgctxt == msg.msgctxt:
                assert not found
                found = True
                entry.reference = self._merge_fields_unique(entry.reference, msg.reference)
                entry.extracted_comment = self._merge_fields(entry.extracted_comment, "-----------------")
                entry.extracted_comment = self._merge_fields(entry.extracted_comment, msg.extracted_comment)
                pass

        if not found:
            self.entries.append (msg)

    
    def _merge_fields(self, a, b):
        if isinstance(a, list):
            result = a
        else:
            result = [a]
        if isinstance(b, list):
            result.extend(b)
        else:
            result.append(b)
        return result

    def _merge_fields_unique(self, a, b):
        if isinstance(a, list):
            result = a
        else:
            result = [a]
        if isinstance(b, list):
            for x in b:
                if not x in result:
                    result.append(x)
        else:
            if b not in result:
                result.append(b)
        return result
        
