deferred class
   XML_URI_SOURCE 
inherit
   XML_SOURCE
      redefine
	 out
      end
feature
   uri: UCSTRING is
	 -- URI for the source of the XML document
      deferred
      end
   out: STRING is
      do
	 Result := clone (uri.to_utf8)
      end
end
