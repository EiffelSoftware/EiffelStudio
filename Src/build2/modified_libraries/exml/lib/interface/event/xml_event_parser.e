
indexing
   description: "Class for parsing XML documents"
   status: "See notice at end of class."
   author: "Andreas Leitner"

class
   XML_EVENT_PARSER

inherit
   XML_PARSER
      undefine
	 make_from_imp
      redefine
	 implementation
      end

   BIDIRECTIONAL_INTERFACE
      redefine
	 implementation
      end

creation
   make_from_imp

feature {BIDIRECTIONAL_IMPLEMENTATION} -- Redefinable Callbacks

   on_start_tag (name, ns_prefix: UCSTRING; attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
	 -- called whenever the parser findes a start element
      require
	 name_not_void: name /= Void
      do
	 -- inherit from this class and redefine this feature handle
	 -- this event.
      end
   
--     on_external_entity_ref (ref: XML_EXTERNAL_ENTITY_REF) is
--  	 -- called whenever the parser finds a reference to and 
--  	 -- external entity.
--  	 -- if "ent" would be declared an entity a reference to it 
--  	 -- would look like "&ent;".
--        require
--  	 ref_not_void: ref /= Void
--        do
--  	 -- inherit from this class and redefine this feature to 
--  	 -- handle this event
--        end
   
   on_content (chr_data: UCSTRING) is
	 -- called whenever the parser findes character data
      require
	 chr_data_not_void: chr_data /= Void
      do
	 -- inherit from this class and redefine this feature handle
	 -- this event.
      end

   on_end_tag (name, ns_prefix: UCSTRING) is
	 -- called whenever the parser findes an end element
      require
	 name_not_void: name /= Void
      do
	 -- inherit from this class and redefine this feature handle
	 -- this event.
      end

   on_processing_instruction (target, data: UCSTRING) is
	 -- called whenever the parser findes a proccessing instruction.
      require
	 target_not_void: target /= Void
	 data_not_void: data /= Void
      do
	 -- inherit from this class and redefine this feature handle
	 -- this event.
      end

   on_comment (com: UCSTRING) is
	 -- called whenever the parser findes a comment.
      require
	 com_not_void: com /= Void
      do
	 -- inherit from this class and redefine this feature handle
	 -- this event.
      end


feature {NONE} -- Implementation
   implementation: XML_EVENT_PARSER_I

end	-- XML_EVENT_PARSER

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
