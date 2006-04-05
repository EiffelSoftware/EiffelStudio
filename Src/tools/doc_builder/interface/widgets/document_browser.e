indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit 
	DOCUMENT_BROWSER_IMP
	
	OBSERVER
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make
	
feature -- Creation

	make is 
			-- Make
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
			should_update := True
			
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
			
					-- Events
			refresh_button.select_actions.extend (agent refresh)
			
			update
		end	

feature -- Commands

	load_url (a_url: STRING) is
			-- Load `a_url'
		local
			l_ptr: SYSTEM_OBJECT
			l_url: SYSTEM_STRING
		do
			l_url := a_url.to_cil
			Internal_browser.navigate (l_url, $l_ptr, $l_ptr, $l_ptr, $l_ptr)
			if not urls.has (a_url) then
				add_url (a_url)
			end
		end		
	
	refresh is
			-- Reload the HTML based upon changes made to `document'.  If there is no
			-- document then simply refresh the loaded url.
		do
			if document /= Void then
				document.set_text (document.widget.internal_edit_widget.text)
				document.save
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
			l_name: STRING
		do
			document := a_doc
			create l_util
			l_name := document.name
			l_name.replace_substring_all ("\", "/")
			if document_hash.has (l_name) then				
				create l_filename.make_from_string (document_hash.item (l_name).name)
				l_filename.extend (l_util.short_name (l_util.file_no_extension (l_name)))
				l_filename.add_extension ("html")
				load_url (l_filename.string)
			elseif l_util.file_type (l_name).is_equal ("xml") or l_util.file_type (l_name).is_equal ("html") then
				create l_target_dir.make (l_util.temporary_html_location (l_name, False))
				document_hash.extend (l_target_dir, l_name)
				load_url (generated_document)
			end
		ensure
			is_set: document = a_doc
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
			create Result.make_empty
			if document.is_persisted then
				create l_generator			
				l_generator.generate_file (document, document_hash.item (document.name))
				Result.append (l_generator.last_generated_file.name.string)
				Result.replace_substring_all ("\", "/")
			end			
		ensure
			has_result: Result /= Void
		end		

	update is
			-- Update
		local
			l_consts: SHARED_OBJECTS
			l_doc: DOCUMENT
		do
			create l_consts
			l_doc := l_consts.shared_document_editor.current_document
			if l_doc /= Void then
				set_document (l_doc)
			end
		end
	
--	events: DOCUMENT_BROWSER_EVENTS

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class DOCUMENT_BROWSER
