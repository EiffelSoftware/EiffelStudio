indexing
   description: "Class for parsing XML documents"
   status: "See notice at end of class."
   author: "Andreas Leitner"

deferred class
   XML_EVENT_PARSER_I

inherit
   XML_PARSER_I
--        redefine
--  	 last_error,
--  	 last_error_description
--        end

   BIDIRECTIONAL_IMPLEMENTATION
      redefine
	 interface
      end

feature {ANY} -- Status
--     last_error: INTEGER is
--  	 -- see XML_PARSE_ERROR_CODES
--        deferred
--        end

--     last_error_description: STRING is
--  	 -- gives a text that explain what the error reported by
--  	 -- 'last_error' was all about.
--        deferred
--        end

--     set_base (a_base: STRING) is
--  	 -- sets the base to be used for resolving URIs in system identifiers
--  	 -- in declarations.
--  	 -- NOTE: Is this applicable to all the different parsers out there?
--        require
--  	 a_base_not_void: a_base /= Void
--        deferred
--        end

--     get_base: STRING is
--  	 -- returns the base.
--  	 -- NOTE: Is this applicable to all the different parsers out there?
--        deferred
--        ensure
--  	 result_not_void: Result /= Void
--        end


feature {NONE} -- Redefinable Callbacks

   on_start_tag (name, ns_prefix: UCSTRING; attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
	 -- called whenever the parser findes a start element
      require
	 name_not_void: name /= Void
      do
	 interface.on_start_tag (name, ns_prefix, attributes)
      end

   on_content (chr_data: UCSTRING) is
	 -- called whenever the parser findes character data
      require
	 chr_data_not_void: chr_data /= Void
      do
	 interface.on_content (chr_data)
      end

   on_end_tag (name, ns_prefix: UCSTRING) is
	 -- called whenever the parser findes an end element
      require
	 name_not_void: name /= Void
      do
	 interface.on_end_tag (name, ns_prefix)
      end
   
   
   on_processing_instruction (target, data: UCSTRING) is
	 -- called whenever the parser findes a proccessing instruction.
      require
	 target_not_void: target /= Void
	 data_not_void: data /= Void
      do
	 interface.on_processing_instruction (target, data)
      end

   on_comment (com: UCSTRING) is
	 -- called whenever the parser findes a comment.
      require
	 com_not_void: com /= Void
      do
	 interface.on_comment (com)
      end

feature {NONE} -- Implementation
   interface: XML_EVENT_PARSER

end -- XML_EVENT_PARSER_I

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
