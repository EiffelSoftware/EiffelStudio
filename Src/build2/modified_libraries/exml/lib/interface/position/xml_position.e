deferred class
   XML_POSITION
inherit
   ANY
      redefine
	 out
      end
feature {ANY}
   source: XML_SOURCE is
      deferred
      end
   out: STRING is
      do
	 Result := clone (source.out)
      end
invariant
   source_not_void: source /= Void
end   
