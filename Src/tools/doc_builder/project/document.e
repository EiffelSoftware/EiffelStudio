indexing
	description: "Documents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT

inherit	
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS
		undefine 
			copy,
			default_create
		end
	
	XML_ROUTINES		
		undefine 
			copy,
			default_create		
		end
		
create
	make_new,
	make_from_file

feature -- Creation

	make_new (a_name: STRING) is
			-- Make new document
		require
			a_name_not_void: a_name /= Void
		do			
			name := a_name
			create text.make_from_string (" ")
			create saved_text.make_empty
			create schema_validator	
		end
		
	make_from_file (a_file: PLAIN_TEXT_FILE) is
			-- Make from existing file
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do		
			name := a_file.name
			file := a_file
			read
			create schema_validator	
		ensure
			has_file: file /= Void
		end		

feature -- Access	
	
	name: STRING
			-- Name
			
	text: STRING
			-- Text			

feature -- File

	file: PLAIN_TEXT_FILE
			-- File on disk

feature --Validation

	is_valid_to_schema: BOOLEAN is
			-- Is Current valid to the loaded schema?
		do
			if is_valid_xml (text) then
				if shared_document_manager.has_schema then
					schema_validator.validate_against_text (text, Shared_document_manager.schema.name)
				end				
				Result := schema_validator.is_valid					
			end
		end	
		
feature -- XML

	xml: DOCUMENT_XML is
			-- XML Document built from `text'.  Void if text is not valid.
		do
			Result := internal_xml
			if Result = Void or is_modified then				
				create Result.make_from_document (Current)
				if Result.valid then
					internal_xml := Result
				else
					Result := Void
				end				
			end
		end
			
	title: STRING is
			-- Document Title, Void if none or if Current is not valid xml.
		local
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
		do
			if xml /= Void then
				l_element ?= xml.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("title")
					if l_att /= Void then
						Result := l_att.value
					end
				end
			end
			if Result = Void then
				Result := (create {MESSAGE_CONSTANTS}).unknown_toc_title
			end
		ensure
			has_result: Result /= Void
		end
		
	output_filter_text: STRING is
			-- Document level output filter text
		local
			l_element: XM_ELEMENT
			l_att: XM_ATTRIBUTE
			l_value: STRING
		do
			if xml /= Void then
				l_element ?= xml.root_element
				if l_element /= Void then
					l_att := l_element.attribute_by_name ("output")
					if l_att /= Void then
						l_value := l_att.value
					end					
				end
			end
			if 
				l_value = Void or 
				(not shared_constants.output_constants.output_list.has_item (l_value)) or 
				l_value.is_equal (shared_constants.output_constants.unfiltered_flag) 
			then
				Result := shared_constants.output_constants.unfiltered
			elseif l_value.is_equal (shared_constants.output_constants.envision_flag) then
				Result := shared_constants.output_constants.envision_desc
			elseif l_value.is_equal (shared_constants.output_constants.studio_flag) then
				Result := shared_constants.output_constants.studio_desc
			elseif l_value.is_equal (shared_constants.output_constants.none_desc) then				
				Result := shared_constants.output_constants.none_desc
			end
		ensure
			has_result: Result /= Void
		end		
			
feature -- GUI

	properties: DOCUMENT_PROPERTIES_DIALOG is
			-- Properties dialog for Current
		require
			is_valid_to_schema
		do
			create Result.make (Current)
		end		

feature -- Query

	is_modified: BOOLEAN is
			-- Has current been modified since last save?
		do
			Result := not saved_text.is_equal (text)
		end
		
	do_update_link: BOOLEAN
			-- Can links in Current be updated?

	can_display, can_transform: BOOLEAN is
			-- Can we display/transform Current based on `output_filter'?
		local
			l_doc_filter, l_curr_filter: STRING
		do
			l_doc_filter := output_filter_text
			l_curr_filter := Shared_project.filter_manager.filter.description
			
			Result := 
						-- Application defines no filtering
				l_curr_filter.is_equal (shared_constants.output_constants.unfiltered) or
						-- Document defines no filtering
				l_doc_filter.is_equal (shared_constants.output_constants.unfiltered) or			
						-- Application level filtering matches document level filter type
				l_curr_filter.has_substring (l_doc_filter)				
		end	

	is_persisted: BOOLEAN is
			-- Is document persisted to physical disk?
		do
			Result := file /= Void and then file.exists
		end
	
feature -- Status Setting
	
	change_name (a_new_name: STRING) is
			-- Change name of current on disk to `a_new_name'
		local
			l_dir: FILE_NAME
		do
			if is_persisted then
				create file.make (name)
				file.delete
				create l_dir.make_from_string (directory_no_file_name (name))
				l_dir.extend (a_new_name)
				name := l_dir.string
			else
				name := a_new_name
			end
		end

	set_text (a_text: STRING) is
			-- Set `text'
		do			
			text := a_text
		end

	save is
			-- Save `text' to disk
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			if not is_persisted then
				create l_save_dialog
				l_save_dialog.show_modal_to_window (Application_window)
				if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
					internal_save (l_save_dialog.file_name)
				end
			else
				internal_save (name)
			end
		end	

feature {NONE} -- Implementation

	read is
			-- Read `file' and put result in `text'
		require
			persisted: is_persisted
		do			
			file.open_read
			if not file.is_empty then
				file.read_stream (file.count)
				saved_text := file.last_string
				set_text (saved_text)
			else
				saved_text := ""
				set_text (saved_text)
			end					
			file.close			
		end

	internal_xml: like xml
			-- Internal XML			
			
	saved_text: STRING
			-- Last saved text value
			
	schema_validator: SCHEMA_VALIDATOR
			-- Schema Validator

	internal_save (a_filename: STRING) is
			-- Save with `a_filename'
		do
			if not is_persisted then
				name := a_filename
			end
			write_to_disk
			internal_xml := Void
		end		

	write_to_disk is
			-- Write Current text to disk
		do			
			if file /= Void and then not file.is_closed then
				file.close
			end
			create file.make_open_write (name)
			if file.is_open_write then
					-- Add a new line character to end of all files				
				if text.is_empty then
					text.append_character ('%N')
				elseif text.item (text.count) /= '%N' then
					text.append_character ('%N')
				end
				file.putstring (text)
				Shared_document_manager.current_editor.update_date (file.date)
				file.flush
				file.close
				saved_text := text
			end
		end

invariant
	has_name: name /= Void
		
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
end -- class DOCUMENT
