indexing
   description: "class representing a xml processing instruction."
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class 
   XML_PROCESSING_INSTRUCTION
inherit
   XML_NODE
      redefine
	 implementation
      end
creation
   make_from_imp

feature {ANY} -- Access

   target: UCSTRING is
	 -- target of this processing instruction. XML defines this as being the 
	 -- first token following the markup that begins the processing instruction.
      do
	 Result := implementation.target
      end
   
   data: UCSTRING is
	 -- content of this processing instruction. This is from the first non 
	 -- white space character after the target to the character immediately 
	 -- preceding the ?>. 
      do
	 Result := implementation.data
      end
   
feature {ANY} -- Basic Routines   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_processing_instruction (Current)
      end
   
feature {NONE} -- Implementation
   implementation: XML_PROCESSING_INSTRUCTION_I

invariant
   target_not_void: target /= Void
   data_not_void: data /= Void
end -- XML_PROCESSING_INSTRUCTION

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
