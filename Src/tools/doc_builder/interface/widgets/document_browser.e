indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit 
	DOCUMENT_BROWSER_IMP

create
	make

feature -- Creation

	make is 
			-- Create 
		do
			default_create
		end		

feature -- Access

	browser_container: EV_WINFORM_CONTAINER
			-- Vision 2 Winforms container		

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.	
		do
				-- Browser
			setup_browser
			
				-- Events
			address_bar.key_press_actions.extend (agent address_key_pressed (?))
			address_bar.select_actions.extend (agent lookup_url (?))

			load_url ((create {TEMPLATE_CONSTANTS}).empty_html_template_file_name)
		end	

	setup_browser is
			-- Setup the browser
		do
			create browser_container
			browser_container.extend (Internal_browser)
			browser_box.extend (browser_container)
			
					-- Toolbar events
			--back_button.select_actions.extend (agent navigate_back)
			back_button.select_actions.extend (agent build_composite_document)
			
			forward_button.select_actions.extend (agent navigate_forward)
			refresh_button.select_actions.extend (agent refresh)
		end	

feature -- Commands

	load_url (a_url: STRING) is
			-- Load `a_url'
		local
			l_ptr: SYSTEM_OBJECT
		do
			Internal_browser.navigate (a_url, $l_ptr, $l_ptr, $l_ptr, $l_ptr)
			if not urls.has (a_url) then
				add_url (a_url)
			end
		end		
	
	navigate_back is
			-- Navigate to previous document
		do
			Internal_browser.go_back
		end	
		
	navigate_forward is
			-- Navigate to document loaded before call to `go_back'
		do
			Internal_browser.go_forward
		end	
	
	refresh is
			-- Reload the HTML based upon changes made to `document'.  If there is no
			-- document then simply refresh the loaded url.
		do
			if document /= Void then
				load_url (generated_document)
			else
				Internal_browser.refresh
			end			
		end			
	
feature -- Status Setting

	set_document (a_doc: DOCUMENT) is
			-- Set `document'
		require
			doc_not_void: a_doc /= Void
		local			
			l_util: UTILITY_FUNCTIONS
			l_filename: FILE_NAME
			l_target_dir: DIRECTORY
		do
			document := a_doc
			if document_hash.has (document.name) then
				create l_util
				create l_filename.make_from_string (document_hash.item (document.name).name)
				l_filename.extend (l_util.short_name (l_util.file_no_extension (document.name)))
				l_filename.add_extension ("html")
				load_url (l_filename.string)
			else
				create l_util
				create l_target_dir.make (l_util.temporary_html_location (document.name, False))
				document_hash.extend (l_target_dir, document.name)
				load_url (generated_document)
			end
		ensure
			is_set: document = a_doc
			is_know: document_hash.has (a_doc.name)
		end	
	
feature {NONE} -- Status Setting

	add_url (a_url: STRING) is
			-- Add url to list
		require
			url_not_void: a_url /= Void
		local
			l_item: EV_LIST_ITEM
		do
			if not urls.has (a_url) then
				urls.extend (a_url)
				create l_item.make_with_text (a_url)
				address_bar.select_actions.block
				address_bar.extend (l_item)
				l_item.enable_select
				address_bar.select_actions.resume	
			end					
		end			
	
feature {NONE} -- Events
		
	address_key_pressed (key: EV_KEY) is
			-- A key was pressed in the address bar
		do
			if key.code = feature {EV_KEY_CONSTANTS}.Key_enter then
				load_url (address_bar.text)
				add_url (address_bar.text)
			end
		end
	
feature {NONE} -- Implementation	

	lookup_url (a_item: EV_LIST_ITEM) is
			-- Lookup url and load
		local
			l_url: STRING
		do
			l_url := a_item.text
			if l_url /= Void then
				load_url (l_url)	
			end			
		end		

	internal_browser: AX_WEB_BROWSER is
			-- Web browser control
		once
			create Result.make
		end

	urls: ARRAYED_LIST [STRING] is
			-- Urls
		once
			create Result.make (10)
			Result.compare_objects
		end				

	document_hash: HASH_TABLE [DIRECTORY, STRING] is
			-- Documents hashed by location of HTML or XML file and name
		once
			create Result.make (5)
			Result.compare_objects
		end		

	document: DOCUMENT
			-- Document

	history_stack: ARRAYED_STACK [INTEGER] is
			-- History stack
		once
			create Result.make (1)	
		end		

	generated_document: STRING is
			-- Generated `document' content
		require
			document_known: document_hash.has (document.name)
		local
			l_generator: HTML_GENERATOR
		do
			create l_generator
			l_generator.generate_file (document, document_hash.item (document.name))
			Result := l_generator.last_generated_file.name.string
		ensure
			has_result: Result /= Void
		end		

feature -- temporary

	build_composite_document is
			-- 
		local
			retried: BOOLEAN
			l_string: STRING
			l_parser: XM_EIFFEL_PARSER
			l_composite_document: COMPOSITE_DOCUMENT
			l_composite_document_builder: COMPOSITE_DOCUMENT_BUILDER
		do
			if not retried then
				l_string := document.text
				if not l_string.is_empty then					
					create l_composite_document_builder.make					
					create l_parser.make
					l_parser.set_callbacks (l_composite_document_builder)
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					l_composite_document := l_composite_document_builder.document
				end
				
				if l_composite_document /= Void then
					main_comp_loop (l_composite_document)					
				end
				
			else
				print ("Could not produce composite structure for document " + document.name)
				print ("<BR><BR>Gobo Error description: " + l_parser.last_error_extended_description)
			end
		rescue
			retried := True
			retry		
		end	
		
	main_comp_loop (a_comp: COMPOSITE_DOCUMENT) is
			-- Loop
		local
			l_comp: like a_comp			
		do
			comp_dets (a_comp, tab_count)
			tab_count := tab_count + 1
			from
				a_comp.components.start				
			until
				a_comp.components.after
			loop				
				l_comp ?= a_comp.components.item
				if l_comp /= Void then
					main_comp_loop (l_comp)
				else
					comp_dets (a_comp.components.item, tab_count)
				end
				a_comp.components.forth
			end
			tab_count := tab_count - 1
		end
		
	comp_dets (a_comp: DOCUMENT_COMPONENT; indents: INTEGER) is
			-- Dets
		local
			l_comp: like a_comp
			l_cnt: INTEGER
		do
			if a_comp /= Void then				
				from
					l_cnt := 0
				until
					l_cnt = indents
				loop
					write_to_file ("%T")
					l_cnt := l_cnt + 1
				end
				write_to_file (a_comp.name)
				write_to_file ("%N")
			end			
		end	

	tab_count: INTEGER
	
	write_to_file (a_string: STRING) is
		do
			create file.make ("C:\testing_doc.test")
			if not file.exists then
				file.create_read_write
				file.close
			end
			file.open_append
			file.putstring (a_string)
			file.close
		end
		
	file: PLAIN_TEXT_FILE

end -- class DOCUMENT_BROWSER
