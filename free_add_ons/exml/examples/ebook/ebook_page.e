indexing
   description:"Object that represent a eBook page"
   status:		"See notice at end of class."
   author:		"Andreas Leitner"
class
   EBOOK_PAGE
inherit	
   KL_INPUT_STREAM_ROUTINES
   EBOOK_GLOBALS
creation
   make_from_xml_element

feature -- Initialization

   make_from_xml_element (e: XML_ELEMENT; a_ebook_root: DS_LINKED_TREE [EBOOK_PAGE]) is
	 -- takes a 'page' node and converts it to a object
	 -- of the type EBOOK_PAGE
      require
	 good_element: e /= Void and then e.name.is_equal ("page")
	 a_ebook_root_not_void: a_ebook_root /= Void
      local
	 topic_el: XML_ELEMENT
	 text_el: XML_ELEMENT
	 topic_text: XML_TEXT
	 text_text: XML_TEXT
      do
	 -- get the topic node
	 topic_el ?= e.item (1)

	 -- get the text node
	 text_el ?= e.item (2)

	 if 
	    text_el /= Void and topic_el /= Void
	  then
	    -- join all text nodes				
	    topic_el.join_text_nodes
	    text_el.join_text_nodes

	    -- now get the text nodes
	    topic_text ?= topic_el.first
	    text_text ?= text_el.first

	    check
	       topic_text /= Void and text_text /= Void
	    end
				
	    -- copy the text
	    topic := clone (topic_text.string)
	    text := clone (text_text.string)

	    ebook_root := a_ebook_root

	    level := e.level - 1

	 end
	 make_key (e.attributes)

      end
feature {NONE}
   key_generator: STRING_KEY_GENERATOR is
      once
	 !! Result.make
      end
   make_key (attributes: XML_ATTRIBUTE_TABLE) is
	 -- get the key from the "key" attribute
	 -- of the "page" tag.
	 -- if the value of "key" is "auto"
	 -- then use `key_generator' to
	 -- automatically generate a key.
      require
	 key_exists: attributes.has ("key")
      local
      do
	 key := clone (attributes.item ("key")).value
	 if
	    key.is_equal ("auto")				
	  then
	    key_generator.next_key
	    key := clone (key_generator.last_key)
	    key.append (html_page_extension)
	 end
      end

feature -- access
   topic: STRING
   text: STRING
   ebook_root: DS_LINKED_TREE [EBOOK_PAGE]

   key: STRING

   file_name: STRING is
      do
	 Result := clone (key)
	 Result.prepend (directory_seperator)
	 Result.prepend (output_directory)
      ensure
	 Result_not_void: Result /= Void
      end

   level: INTEGER
	 -- page recursion level

feature
   ready_for_output: BOOLEAN is
      do
	 Result := (topic /= Void) and	(text /= Void)
      end

feature -- output generation
   html_page: STRING is
      require
	 ready_for_output
      do
	 !! Result.make (0)
	 Result.append ("<HTML>")

	 Result.append (html_title)

	 Result.append (html_pre_body)

	 Result.append (html_body)

	 Result.append ("</HTML>")
      end


   html_pre_body: STRING is
      do
	 !! Result.make (0)
	 Result.append (html_css_definitions)
      end

   html_css_definitions: STRING is
      local
	 file: like INPUT_STREAM_TYPE
	 s: STRING
      do
		   
	 file := make_file_open_read (ccs_definitions_file)
	 
	 if
	    not is_open_read (file)
	  then
	    s := clone ("Unable to open file ")
	    s.append_string (ccs_definitions_file)
	    s.append_string (" in read mode")
	    report_error_and_exit (s)
	 end
	 

	 !! Result.make (0)
	 from
	 until
	    end_of_input (file)
	 loop
	    Result.append (read_string (file, 1000))
	 end
      end


   html_body: STRING is
      local
	 cs: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]
      do
	 !! Result.make (0)
	 Result.append ("<BODY>")

	 Result.append (html_pre_body_title)

	 Result.append (html_body_title)

	 -- the menu
	 cs := ebook_root.new_cursor
	 cs.to_root
	 Result.append (html_menu (cs))

	 -- the actual text
	 Result.append (html_body_text)

	 Result.append ("</BODY>")
      end

   html_pre_body_title: STRING is
      local
	 file: like INPUT_STREAM_TYPE
      do
	 file := make_file_open_read (pre_body_title_file)
	 check
	    file_open: is_open_read (file)
	 end

	 !! Result.make (0)
	 from
	 until
	    end_of_input (file)
	 loop
	    -- Result.append (file.last_string)
	    -- file.read_line
	    Result.append (read_string (file, 1000))
	 end
      end



   html_body_text: STRING is
      do
	 !! Result.make (0)
	 Result.append ("<DIV class=%"BodyText%">")
	 Result.append (text)
	 Result.append ("</DIV>")
      end

   html_body_title: STRING is
      do
	 !! Result.make (0)
	 Result.append ("<H1 class=%"BodyTitle")
	 Result.append (level.out)
	 Result.append ("%">")
	 Result.append (topic)
	 Result.append ("</H1>")
      end


   html_title: STRING is
      do
	 !! Result.make (0)
	 Result.append ("<TITLE>")
	 Result.append (topic)
	 Result.append ("</TITLE>")
      end

	
   html_menu (cs: DS_LINKED_TREE_CURSOR [EBOOK_PAGE]): STRING is
      require
	 cs_not_void: cs /= Void
      local

      do

	 !! Result.make (0)

	 if
	    cs.item = Void
	  then
	    Result.append ("<DIV class=%"Menu%">")
	 end

	 from
	    cs.child_start
	 until
	    cs.child_off
	 loop
	    -- generate this page
	    if
	       cs.child_item = Current
	     then
	       Result.append (html_selected_menu_link (cs.child_item.topic, cs.child_item.key, cs.child_item.level))
	    else
	       Result.append (html_menu_link (cs.child_item.topic, cs.child_item.key, cs.child_item.level))
	    end

	    cs.down
	    -- process recursive pages if page is current.
	    -- only show sub menus when the current page
	    -- is listed in it somewhere
	    if
	       cs.has (Current)
	     then
	       Result.append (html_menu (cs))
	    end
	    cs.up

	    cs.child_forth
	 end

	 if
	    cs.item = Void
	  then
	    Result.append ("</DIV>")
	 end


      end
   html_menu_link (a_topic, a_key: STRING; a_level: INTEGER): STRING is
      require
	 a_topic /= Void
	 a_key /= Void
      local
	 a_class: STRING
	 a_id: STRING
      do

	 a_class := clone ("MenuLink")
	 a_class.append (a_level.out)

	 a_id := clone (a_key)
	 a_id.append ("menu")

	 Result := html_text_link (a_topic, a_class, a_key, a_id)
	 Result.append ("<br>")

      end

   html_selected_menu_link (a_topic, a_key: STRING; a_level: INTEGER): STRING is
      require
	 a_topic /= Void
	 a_key /= Void
      local
	 a_class: STRING
	 a_id: STRING
      do

	 a_class := clone ("SelectedMenuLink")
	 a_class.append (a_level.out)

	 a_id := clone (a_key)
	 a_id.append ("menu")

	 Result := html_text_link (a_topic, a_class, a_key, a_id)
	 Result.append ("<br>")

      end
	
   html_text_link (a_text, a_class, a_href, a_id: STRING): STRING is
      require
	 a_text /= Void
	 a_class /= Void
	 a_href /= Void
	 a_id /= Void
      do
	 !! Result.make (0)
	 Result.append ("<A ")

	 -- the CLASS parameter
	 Result.append ("class=%"")	
	 Result.append (a_class)
	 Result.append ("%" ")

	 -- the ID parameter
	 Result.append ("ID=%"")
	 Result.append (a_id)
	 Result.append ("%" ")

	 -- the HREF parameter
	 Result.append ("HREF=%"")
	 Result.append (a_href)
	 Result.append ("%" ")

	 if
	    enable_java_script_hot_links
	  then
	    -- the onMouseover parameter
	    Result.append ("onMouseover=%"HighLight('")
	    Result.append (a_id)
	    Result.append ("');%" ")
	
	    -- the onMouseout parameter
	    Result.append ("onMouseout=%"UndoHighLight('")
	    Result.append (a_id)
	    Result.append ("');%"")
	 end

	 Result.append (">")

	 Result.append (a_text)

	 Result.append ("</A>")
      end

		

end -- class EBOOK_PAGE
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
