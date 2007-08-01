"""An entry of a po file"""

__version__ = "$Revision$"
# $Source$

import os


class PoMessage:
    """A message entry of a po file"""

    def __init__ (self):
        """Initialize po file with filepath"""

        # message comments
        self.translator_comment = None
        self.extracted_comment = None
        self.reference = None
        self.fuzzy = False
        # message data
        self.msgctxt = None
        self.msgid = ""
        self.msgid_plural = None
        self.msgstr = [""]


    def set_msgid (self, message):
        """Set msgid to message"""
        
        self.msgid = self._process_message (message)
        if self.msgid is None:
            raise Exception("Message ID invalid")


    def set_msgid_plural (self, message):
        """Set msgid_plural to message"""

        self.msgid_plural = self._process_message (message)


    def write_to_file (self, file):
        """Write message to file handle"""

        # message comments
        self._write_with_prefix(file, self.translator_comment, "#")
        self._write_with_prefix(file, self.extracted_comment, "#.")
        self._write_with_prefix(file, self.reference, "#:")
        if self.fuzzy:
            file.write("#, fuzzy\n")
        # message data
        self._write_message(file, self.msgctxt, "msgctxt")
        self._write_message(file, self.msgid, "msgid")
        if self.msgid_plural is not None:
            # plural message
            self._write_message(file, self.msgid_plural, "msgid_plural")
            for i in range(0, len(self.msgstr) - 1):
                self._write_message(file, self.msgstr[i], "msgstr[" + i + "]")
        else:
            # singular message
            if len(self.msgstr) > 1:
                raise Exception("multiple messages in singular message case")
            else:
                self._write_message(file, self.msgstr[0], "msgstr")


    def _process_message (self, message):
        """Process message by splitting it on newlines and escaping characters"""

        # escape newlines and quotation marks
        message = message.replace ("\r", "")
        message = message.replace ("\n", "\\n\n")
        message = message.replace ("\"", "\\\"")
        return message.split ("\n")


    def _write_with_prefix (self, file, message, prefix):
        """Write 'message' to 'file' using a 'prefix' for each line"""
        
        if not (message is None):
            if isinstance (message, basestring):
                file.write (prefix + " " +message + "\n")
            elif isinstance (message, list):
                for line in message:
                    file.write (prefix + " " + line + "\n")
            else:
                raise Exception("invalid message argument")
        # this is necessary as otherwise the python wrongly(?) executes the previous line
        pass


    def _write_message (self, file, message, prefix):
        """write 'message' to 'file' maybe using multiple lines"""
        
        if not (message is None):
            if isinstance (message, basestring):
                file.write (prefix + " \"" + message + "\"" + "\n")
            elif isinstance (message, list):
                if len(message) == 1:
                    file.write(prefix + " \"" + message[0] + "\"" + "\n")
                else:
                    file.write (prefix + " \"\"" + "\n")
                    for line in message:
                        file.write ("\"" + line + "\"" + "\n")
            else:
                raise Exception("invalid message argument")
        # this is necessary as otherwise the python wrongly(?) executes the previous line
        pass


def empty_message(msgid, msgctxt = None, extracted_comment = None, reference = None):
    """Create an empty message with given parameters"""
    
    msg = PoMessage()
    msg.extracted_comment = extracted_comment
    msg.reference = reference
    msg.msgctxt = msgctxt
    msg.set_msgid (msgid)
    return msg

    