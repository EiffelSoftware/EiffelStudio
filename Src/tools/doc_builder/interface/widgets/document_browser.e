indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit 
	EV_VERTICAL_BOX	

create
	make

feature -- Creation

	make is 
			-- Create 
		do
			default_create
			build_interface		
			setup_events
		end		

feature {NONE} -- Initialization

	build_interface is
			-- Build interface elements
		do
			create address_bar
			extend (address_bar)
			
			create browser_container
			browser_container.put (internal_browser)
			extend (browser_container)
			set_padding_width (2)
			
			disable_item_expand (address_bar)
			enable_item_expand (browser_container)
		end

	setup_events is
			-- Setup interface events for browser interaction
		do
			address_bar.key_press_actions.extend (agent address_key_pressed (?))
			address_bar.select_actions.extend (agent lookup_url (?))
		end

feature -- Commands

	load_document_html (a_doc_loc, a_doc_html_loc: STRING) is
			-- Load html document
		require
			document_not_void: a_doc_loc /= Void
			html_not_void: a_doc_html_loc /= Void
		do
			if not File_hash.has (a_doc_loc) then
				File_hash.extend (a_doc_html_loc, a_doc_loc)
				add_url (a_doc_loc)
			end			
			load_url (a_doc_html_loc)
		end		

	load_document_xml (a_doc_loc, a_doc_xml_loc: STRING) is
			-- Load xml document
		require
			document_not_void: a_doc_loc /= Void
			xml_not_void: a_doc_xml_loc /= Void
			document_valid: (create {XML_ROUTINES}).is_valid_xml (a_doc_xml_loc)
			is_xml_file_type: (create {UTILITY_FUNCTIONS}).file_type (a_doc_xml_loc).is_equal ("xml")
		do
			if not File_hash.has (a_doc_loc) then
				File_hash.extend (a_doc_xml_loc, a_doc_loc)
				add_url (a_doc_loc)			
			end
			load_url (a_doc_xml_loc)
		end	

	load_url (a_url: STRING) is
			-- Load `a_url'
		local
			l_ptr: SYSTEM_OBJECT
		do
			Internal_browser.navigate (a_url, $l_ptr, $l_ptr, $l_ptr, $l_ptr)			
		end		

feature -- Interface	
	
	address_bar: EV_COMBO_BOX
			-- Combo box of url addresses
	
feature {NONE} -- Status Setting

	add_url (a_url: STRING) is
			-- Add url to list
		require
			url_not_void: a_url /= Void
		local
			l_item: EV_LIST_ITEM
		do
			create l_item.make_with_text (a_url)
			address_bar.select_actions.block
			address_bar.extend (l_item)
			address_bar.select_actions.resume			
		end		
	
feature {NONE} -- Events
		
	address_key_pressed (key: EV_KEY) is
			-- A key was pressed in the address bar
		do
			if key.code = feature {EV_KEY_CONSTANTS}.Key_enter then
				load_url (address_bar.text)				
			end
		end
	
feature {NONE} -- Implementation

	lookup_url (a_item: EV_LIST_ITEM) is
			-- Lookup url from hash adn load
		local
			l_url: STRING
		do
			l_url := File_hash.item (a_item.text)
			if l_url /= Void then
				load_url (l_url)	
			end			
		end		

	browser_container: EV_WINFORM_CONTAINER
			-- Vision 2 Winforms container

	internal_browser: AX_WEB_BROWSER is
			-- Web browser control
		once
			create Result.make
		end

	file_hash: HASH_TABLE [STRING, STRING] is
			-- Hash of document files and document names
		once
			create Result.make (10)
			Result.compare_objects
		end		

end -- class DOCUMENT_BROWSER
