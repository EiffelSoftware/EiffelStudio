indexing
   description: "class representing a xml processing instruction."
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class 
   TOE_PROCESSING_INSTRUCTION

inherit
   TOE_NODE
   XML_PROCESSING_INSTRUCTION_I
   C_STRING_HELPER_NP
   
creation
   make_from_c,
   make

feature {NONE} -- Initialisation
   make_from_c (target_ptr, data_ptr: POINTER) is
      require
	 target_ptr_not_void: target_ptr /= Void
	 data_ptr_not_void: data_ptr /= Void
      do
	 !! target.make_from_utf8 (make_string_from_c_zero_terminated_string (target_ptr))
	 !! data.make_from_utf8 (make_string_from_c_zero_terminated_string (data_ptr))
      end
   
   make (a_target, a_data: UCSTRING) is
      require
	 a_target_not_void: a_target /= Void
	 a_data_not_void: a_data /= Void
      do
	 target := a_target
	 data := a_data
      end

feature {ANY} -- Access

   target: UCSTRING
   data: UCSTRING
      
      
end -- TOE_PROCESSING_INSTRUCTION

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
