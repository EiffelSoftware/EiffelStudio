indexing
   description: "objects representing a element";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

deferred class
   XML_ELEMENT_I

inherit
   XML_COMPOSITE_I
   
   XML_NAMED_NODE_I
   
feature {ANY} -- Access
   
feature {ANY} -- Element Change
   
   add_attributes (a_attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]; a_parent: XML_ELEMENT) is
	 -- Add `a_attributes' to this element.
	 -- `parent' is the parent of all attribute nodes added
      require
	 a_attributes_not_void: a_attributes /= Void
	 a_parent_not_void: a_parent /= Void
      deferred
      end

end -- XML_ELEMENT_I

--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Jakominiguertel 6/2
--| 8010 Graz
--| Austria
--| email: nozone@sbox.tu-graz.ac.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------
      
