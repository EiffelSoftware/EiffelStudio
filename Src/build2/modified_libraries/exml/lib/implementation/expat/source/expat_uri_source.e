class
   EXPAT_URI_SOURCE
inherit
   XML_URI_SOURCE
creation
   make
feature
   make (a_uri: UCSTRING) is
      do
	 uri := a_uri
      ensure
	 uri_set: equal (uri, a_uri)
      end
feature
   uri: UCSTRING
end
   
   
