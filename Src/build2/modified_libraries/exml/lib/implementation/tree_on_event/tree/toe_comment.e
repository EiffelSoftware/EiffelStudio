indexing
   description: "class representing xml comment"
   status:	"See notice at end of class.";
   author:	"Andreas Leitner";

class 
   TOE_COMMENT
inherit
   XML_COMMENT_I
   TOE_NODE
   C_STRING_HELPER_NP
creation
   make_from_c,
   make
   
feature {NONE} -- Initialisation
   make_from_c (a_parent: XML_ELEMENT; data_ptr: POINTER) is
      require
	 ptr_not_void: data_ptr /= Void
	 a_parent_not_void: a_parent /= Void
      do
	 parent := a_parent
	 !! data.make_from_utf8 (make_string_from_c_zero_terminated_string (data_ptr))
      end
   
   make (a_parent: XML_COMPOSITE; a_data: UCSTRING) is
      require
	 a_data_not_void: a_data /= Void
	 a_parent_not_void: a_parent /= Void
      do
	 data := a_data
	 parent := a_parent
      end

feature {ANY} -- Access

   data: UCSTRING
	 -- the actual character data of this comment.

end -- TOE_COMMENT

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
