deferred class
   XML_NAMESPACE_I
inherit
   IMPLEMENTATION
feature
   ns_prefix: UCSTRING is
      deferred
      end
   
   uri: UCSTRING is
      deferred
      end
invariant
   either_uri_not_void_or_prefix: (uri = Void implies ns_prefix /= Void) and (ns_prefix = Void implies uri /= Void)
end
	 
