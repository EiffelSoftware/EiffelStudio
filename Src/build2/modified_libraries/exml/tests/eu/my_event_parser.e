-- This class parses a speical (that we know staticalls) and check 
-- whether the callbacks are called (with the right data suplied)
class
   MY_EVENT_PARSER

inherit
   XML_EVENT_PARSER
      redefine
	 on_start_tag,
	 on_content,
	 on_end_tag
      end
   EXPAT_EVENT_FACTORY
   DEBUG_TOOLS
   
creation
   make

feature -- Initialization
   make is
      local
	 expat_event_parser: EXPAT_EVENT_PARSER
      do
	 make_from_imp (create_event_parser_imp)
      end

feature

   on_start_tag (name, ns_prefix: UCSTRING; attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
	 -- called whenever the parser findes a start element
      do
	 is_start_tag_ok := equal (name.to_utf8, "mydoc")
      end

   on_content (chr_data: UCSTRING) is
	 -- called whenever the parser findes character data
      do
	 is_content_ok := equal (chr_data.to_utf8, "ABC")
      end

   on_end_tag (name, ns_prefix: UCSTRING) is
	 -- called whenever the parser findes an end element
      do
	 is_end_tag_ok := equal (name.to_utf8, "mydoc")
      end
   
feature -- Test verification		
   
   is_start_tag_ok: BOOLEAN
   is_end_tag_ok: BOOLEAN
   is_content_ok: BOOLEAN

end -- class MY_EVENT_PARSER



