indexing
   description:"Objects that parse Ebook XML-documents"
   status:		"See notice at end of class."
   author:		"Andreas Leitner"

class
   EBOOK_XML_PARSER

inherit
   XML_TREE_PARSER
   KL_INPUT_STREAM_ROUTINES
      undefine
	 out
      end
   KL_OUTPUT_STREAM_ROUTINES
      rename
	 close as close_output,
	 is_closed as is_closed_output
      undefine
	 out
      end
   EBOOK_GLOBALS
      undefine
	 out
      end

creation
   make
feature 
   is_valid: BOOLEAN

feature

   parse_file is
	 -- parses a file
	 -- also validates it
      local
	 in_file: like INPUT_STREAM_TYPE
	 buffer: STRING
	 ebook_cursor: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]
	 s: STRING
      do
	 in_file := make_file_open_read (ebook_xml_file_name)

	 if
	    not is_open_read (in_file)
	  then
	    s := clone ("Unable to open file ")
	    s.append_string (ebook_xml_file_name)
	    s.append_string (" in read mode")
	    report_error_and_exit (s)
	 end
	 
	 from
	 until
	    end_of_input (in_file) or not is_correct
	 loop
		
	    buffer := read_string (in_file, 1000)

	    if
	       buffer.count > 0
	     then
	       parse_string (buffer)
	    else
	       set_end_of_file	
	    end

	 end
	 close (in_file)

	 if
	    is_correct
	  then
	    post_parse_actions

	    validate

	    if 
	       is_valid
	     then
	       !! ebook_root.make
	       ebook_root.put_root (Void)
	       ebook_cursor := ebook_root.new_cursor
	       ebook_cursor.to_root
	       generate_ebook_tree (root_element, ebook_cursor)
	    end

	 end
      end

   -- Iterating through pages recursively (not needed with Pylon tree)
   --
   generate_html_pages is
	 -- generates html pages
      require
	 is_correct: is_correct
	 is_valid: is_valid
      local
	 cs: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]
      do
	 cs := ebook_root.new_cursor
	 cs.to_root
	 generate_html_page (cs)
      end

feature {NONE}

   generate_html_page (cs: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]) is
      require
	 cs_not_void: cs /= Void
      local
	 file: like OUTPUT_STREAM_TYPE
      do
	 from
	    cs.child_start
	 until
	    cs.child_off
	 loop
	    -- generate this page
	    file := make_file_open_write (cs.child_item.file_name)
	    check
	       file_is_connected: file.is_connected
	    end
	    -- FIXME: Use real error handling instead of exceptions here. 
	    
	    file.put_string (cs.child_item.html_page)
	    close_output (file)

	    -- process recursive pages
	    cs.down
	    generate_html_page (cs)
	    cs.up

	    cs.child_forth
	 end

      end

feature {NONE}-- post parsing

   post_parse_actions is
      do
	 remove_unwanted_children (root_element)
	 join_text_nodes (root_element)
      end


   remove_unwanted_children (node: XML_NODE) is
	 -- remove node if:
	 -- node is a text block and
	 -- parent of node is not a 'text' or 'topic' element
      require
	 node_not_void: node /= Void
      local
	 text: XML_TEXT
	 element: XML_ELEMENT
	 cs: DS_BILINKED_LIST_CURSOR [XML_NODE]
      do
	 from
	    cs := node.new_cursor
	    cs.start
	 until 
	    cs.off
	 loop
	    text ?= cs.item
	    if
	       text /= Void and then
	       (not text.parent.name.is_equal ("topic") and
		not text.parent.name.is_equal ("text"))
	     then	
	       node.remove_at_cursor (cs)
	    else
	       remove_unwanted_children (cs.item)
	       cs.forth
	    end
	 end		
      end


   join_text_nodes (node: XML_NODE) is
	 -- join all sequences of text nodes
      require
	 node_not_void: node /= Void
      local
	 element: XML_ELEMENT
	 cs: DS_LINKED_LIST_CURSOR [XML_NODE]
      do
	 from
	    cs := node.new_cursor
	    cs.start
	 until 
	    cs.off
	 loop
	    element ?= cs.item
	    if
	       element /= Void
	     then	
	       element.join_text_nodes
	       -- proces recursively
	       join_text_nodes (element)
	    end
	    cs.forth
	 end
      end

feature {NONE} -- validating
   validate is
	 -- needed since the XML-parser is not validating at the moment ):
      require
	 is_correct: is_correct
      local
	 element: XML_ELEMENT
      do
	 is_valid := True
	 if
	    not root_element.name.is_equal ("ebook")
	  then
	    is_valid := False
	 else
	    -- process further pages
	 end
      end

feature {NONE} -- 

   ebook_root: DS_LINKED_TREE [EBOOK_PAGE]

   generate_ebook_tree (el: XML_ELEMENT; ebook_cs: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]) is
      require
	 is_correct: is_correct
	 is_valid: is_valid
	 el_not_void: el /= Void
      local
	 a_page: EBOOK_PAGE
	 a_page_el: XML_ELEMENT
	 file_name: STRING
	 cs: DS_LINKED_LIST_CURSOR [XML_NODE]
	 first_node: BOOLEAN
	 current_level: INTEGER
      do
	 from
	    cs := el.new_cursor
	    cs.start
	    first_node := True
	 until
	    cs.off
	 loop
	    a_page_el ?= cs.item

	    if
	       a_page_el /= Void and then
	       a_page_el.name.is_equal ("page")
	     then
	       -- generate this page
	       !! a_page.make_from_xml_element (a_page_el, ebook_root)

	       -- add page to the tree on the same level
	       if
		  first_node
		then
		  ebook_root.put_first_child (a_page, ebook_cs)
		  ebook_cs.child_start
		  first_node := False
		  -- add_child automatically goes down one level


	       else
		  ebook_root.put_right_child (a_page, ebook_cs)
		  ebook_cs.child_forth
		  -- add right stays on the same level

	       end

	       -- process recursivly (one level deeper - child of current node)
	       current_level := ebook_cs.depth
	       ebook_cs.down
	       generate_ebook_tree (a_page_el, ebook_cs)
	       ebook_cs.up

	       -- if we went down a level in the recursion go up again
	       check
		  level_check: current_level = ebook_cs.depth or current_level = ebook_cs.depth - 1
	       end

	    end

	    cs.forth
	 end
      end



end -- class EBOOK_XML_PARSER
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
