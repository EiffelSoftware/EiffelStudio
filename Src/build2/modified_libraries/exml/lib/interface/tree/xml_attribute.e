indexing
   description:"Objects representing a XML-attribute"
   status:		"See notice at end of class."
   author:		"Andreas Leitner"

class
   XML_ATTRIBUTE

inherit
   XML_NAMED_NODE
      redefine
	 implementation
      end

creation
   make_from_imp

feature {ANY} -- Access

   value: UCSTRING is
	 -- the value of the attribute.
      do
	 Result := implementation.value
      end
   
   is_namespace_declaration: BOOLEAN is
	 -- is this attribute a namespace declaration ?
      do
	 if
	    (has_prefix and then (equal (ns_prefix, uc_xmlns))) or 
	     equal (name, uc_xmlns)
	  then
	    Result := True
	 end
      end
   
   namespace_declaration: XML_NAMESPACE is
      require
	 is_namespace_declaration: is_namespace_declaration
      local
	 a_prefix: UCSTRING
	 a_uri: UCSTRING
      do
	 if
	    has_prefix
	  then
	    a_prefix := name
	 else
	    create a_prefix.make (0)
	 end
	 if 
	    value.count > 0
	  then
	    a_uri := value
	 end
	 !! Result.make (a_prefix, a_uri)
      end
   
feature {ANY} -- Basic Routines   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_attribute (Current)
      end
feature {NONE} -- Implementation
   implementation: XML_ATTRIBUTE_I
   
   uc_xmlns: UCSTRING is
      once
	 !! Result.make_from_string ("xmlns")
      end
   
invariant
   value_not_void: value /= Void
end -- class XML_ATTRIBUTE
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------
