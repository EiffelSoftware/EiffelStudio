indexing
   description:	"A tree based XML Parser using any XML_EVENT_PARSER implementation as back end."
   status:	"See notice at end of class."
   author:	"Andreas Leitner"
   note:	"Although it is not DOM (Level 1) conforming, it has %
   %been writen with DOM in mind. I prefer to have this %
   %parser follow the Eiffel design guide lines";
class
   TOE_TREE_PARSER

inherit
   XML_TREE_PARSER_I
   
   XML_EVENT_PARSER
      rename
	 implementation as event_implementation,
	 make_from_imp as make_from_imp_event
      undefine
	 is_equal,
	 copy
      redefine
	 on_start_tag,
	 on_content,
	 on_end_tag,
	 on_processing_instruction,
	 on_comment
      end
   
creation
   make_from_imp
   
feature {NONE} -- Initialisation
   
   make_from_imp (a_imp: XML_EVENT_PARSER_I) is
      local
	 toe_document: TOE_DOCUMENT
      do
	 make_from_imp_event (a_imp)
	 !! toe_document.make
	 !! document.make_from_imp (toe_document)
      end
   
feature {ANY} -- Access
   
   document: XML_DOCUMENT
   
   
   is_position_table_enabled: BOOLEAN is
      do
	 Result := last_position_table /= Void
      end
   
   last_position_table: XML_POSITION_TABLE

feature {ANY} -- Basic Opertations   
   
   enable_position_table is
      do
	 !! last_position_table.make
      end
   
   disable_position_table is
      do
	 last_position_table := Void
      end
   
feature {NONE} -- call backs
   --FIXME: Set current_element to Current before first callback is 
   --beeing called (creation procedure?)
   on_start_tag (name, ns_prefix: UCSTRING; attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
	 -- called whenever the parser findes a start element
      local
	 element: XML_ELEMENT
	 toe_element: TOE_ELEMENT
      do
	 check
	    document_not_finished: document.root_element /= Void implies current_open_composite /= Void
	 end
	 
	 if 
	    document.root_element = Void
	  then
	    -- this is the first element in the document
	    create toe_element.make_root (name, ns_prefix)
	    create element.make_from_imp (toe_element)
	    -- add root element
	    document.force_last (element)
	 else
	    -- this is not the first element in the document
	    create toe_element.make_child (current_open_composite, name, ns_prefix)
	    create element.make_from_imp (toe_element)
	    current_open_composite.force_last (element)
	 end
	 
	 handle_position (element)
	 
	 -- add attributes
	 element.add_attributes (attributes)
	 
	 check
	    element_not_void: element /= Void
	 end
	 current_node := element
	 current_open_composite := element
      end

   on_content (chr_data: UCSTRING) is
	 -- called whenever the parser findes character data
      local
	 xml: XML_CHARACTER_DATA
	 toe: TOE_CHARACTER_DATA
      do
	 check
	    not_finished: current_open_composite /= Void
	 end
	 !! toe.make (current_open_composite, chr_data)
	 !! xml.make_from_imp (toe)
	 current_open_composite.force_last (xml)
	 
	 handle_position (xml)
	 
	 current_node := xml
      end

   on_end_tag (name, ns_prefix: UCSTRING) is
	 -- called whenever the parser findes an end element
      do
	 check
	    open_composite_exists: current_open_composite /= Void
	 end

	 current_open_composite := next_open_composite (current_open_composite)
	 current_node := current_node.parent
      end
   
   on_processing_instruction (target, data: UCSTRING) is
	 -- called whenever the parser findes a processing instruction.
      local
	 toe: TOE_PROCESSING_INSTRUCTION
	 xml: XML_PROCESSING_INSTRUCTION
      do
	 !! toe.make (target, data)
	 !! xml.make_from_imp (toe)
	 if
	    current_open_composite = Void
	  then
	    document.force_last (xml)
	 else
	    current_open_composite.force_last (xml)
	 end
	 
	 handle_position (xml)
	 
	 current_node := xml
      end
   
   on_comment (com: UCSTRING) is
	 -- called whenever the parser finds a comment.
      local
	 toe: TOE_COMMENT
	 xml: XML_COMMENT
      do
	 !! toe.make (current_open_composite, com)
	 !! xml.make_from_imp (toe)
	 if
	    current_open_composite = Void
	  then
	    document.force_last (xml)
	 else
	    current_open_composite.force_last (xml)
	 end
	 
	 handle_position (xml)
	 
	 current_node := xml
      end

feature {NONE} -- Implementation
   current_node: XML_NODE
   current_open_composite: XML_COMPOSITE

   next_open_composite (composite: XML_COMPOSITE): XML_COMPOSITE is
      require
	 composite /= Void
      do
	 Result := composite.parent
      end
   
   handle_position (node: XML_NODE) is
      require
	 node_not_void: node /= Void
      do
	 if 
	    is_position_table_enabled
	  then
	    last_position_table.put (position, node)
	 end
      end
   
   
   
   
invariant
   --TODO:
   --inv1: (root_element /= Void) implies (current_node /= Void)
   --inv2: (current_open_element = Void) implies (current_node = root_element)
   --inv3: ((root_element /= Void) and then (current_node = root_element)) implies current_node.is_root

   
end -- class TOE_TREE_PARSER
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
