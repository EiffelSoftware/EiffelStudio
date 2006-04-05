indexing
	description: "Properties dialog for editor XML documents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROPERTIES_DIALOG

inherit
	DOCUMENT_PROPERTIES_DIALOG_IMP
	
	XML_ROUTINES
		undefine
			default_create,
			copy
		end
		
	SHARED_OBJECTS
		undefine
			default_create,
			copy
		end
		
	UTILITY_FUNCTIONS
		undefine
			default_create,
			copy
		end

create
	make

feature -- Creation

	make (a_doc: DOCUMENT) is
			-- Make with `a_doc'
		require
			a_doc_not_void: a_doc /= Void
			a_doc_valid: a_doc.is_valid_to_schema
		do
			default_create
			document := a_doc
			xm_document := a_doc.xml
			populate_widgets	
		end		

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			okay_button.select_actions.extend (agent okay)
			apply_button.select_actions.extend (agent apply)
			cancel_button.select_actions.extend (agent destroy)
			override_12_check.select_actions.extend (agent toggle_override_widgets)
			override_20_check.select_actions.extend (agent toggle_override_widgets)
			output_combo.disable_edit
			toggle_override_widgets
		end

	initialize_output is
			-- Initialize output options
		local
			l_outputs: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_item: EV_LIST_ITEM
		do
			l_outputs := shared_project.filter_manager.filters
			from
				l_outputs.start
			until
				l_outputs.after
			loop
				create l_item.make_with_text (l_outputs.key_for_iteration)
				output_combo.extend (l_item)
				if document.output_filter_text.is_equal (l_outputs.key_for_iteration) then
					l_item.enable_select
				end
				l_outputs.forth
			end			
		end		

feature -- Commands

	apply is
			-- Apply
		do
			set_options		
		end
		
	okay is
			-- Okay
		do
			set_options
			destroy	
		end		

feature {NONE} -- Implementation

	document: DOCUMENT
			-- Associated document
		
	xm_document: XM_DOCUMENT
			-- Associated document XML tree
			
	old_name: STRING
			-- Name prior to editing
			
	populate_widgets is
			-- Build the dialog with information from `a_doc'
		local
			l_toc_element, l_element: XM_ELEMENT
		do
				-- General
			name_text.set_text (short_name (document.name))
			old_name := name_text.text
			location_label.set_text (document.name)
			
				-- Output	
			initialize_output
			
				-- Help
			if document.title /= Void then
				toc_title_text.set_text (document.title)
			end
			if xm_document /= Void then
					-- Meta Data
				l_toc_element := xm_document.root_element.element_by_name ("meta_data")
				
					-- Help
				l_toc_element ?= l_toc_element.element_by_name ("help")
				if l_toc_element /= Void then
						-- TOC
					l_toc_element ?= l_toc_element.element_by_name ("toc")
					if l_toc_element /= Void then
						if l_toc_element /= Void then
									-- Title information
							l_element := l_toc_element.element_by_name ("studio_title")
							if l_element /= Void then
								override_12_check.enable_select
								set_text_from_element (toc_12_title_text, l_element)
							end
							l_element := l_toc_element.element_by_name ("envision_title")
							if l_element /= Void then
								override_20_check.enable_select
								set_text_from_element (toc_20_title_text, l_element)
							end
									-- Location information
							l_element := l_toc_element.element_by_name ("studio_location")
							if l_element /= Void then
								override_12_check.enable_select
								set_text_from_element (toc_12_location_text, l_element)
							end
							l_element := l_toc_element.element_by_name ("envision_location")
							if l_element /= Void then
								override_20_check.enable_select
								set_text_from_element (toc_20_location_text, l_element)
							end
									-- Alphabetical information
							l_element := l_toc_element.element_by_name ("studio_pseudo_name")
							if l_element /= Void then
								override_12_check.enable_select
								set_text_from_element (toc_12_pseudo_text, l_element)
							end
							l_element := l_toc_element.element_by_name ("envision_pseudo_namen")
							if l_element /= Void then
								override_20_check.enable_select
								set_text_from_element (toc_20_pseudo_text, l_element)
							end
						end		
					end
				end				
			end
		end

	set_options is
			-- Set options chosen in widgets
		local
			l_meta_array,
			l_toc_array: ARRAY [STRING]
		do
			l_meta_array := <<"document", "meta_data">>
			l_toc_array := <<"document", "meta_data", "help", "toc">>
			
			document.clear_element (xm_document, l_meta_array)
			
					-- File name
			if has_name_changed then
				display_name_change_warning
			end
					-- Title
			document.set_attribute (xm_document, <<"document">>, "title", toc_title_text.text)
			
			document.set_element (xm_document, l_meta_array, "", "")
			
					-- Output filter
			if output_combo.selected_item.text.is_equal (shared_constants.output_constants.unfiltered) then
				document.set_attribute (xm_document, <<"document">>, "output", "")
			else
				document.set_attribute (xm_document, <<"document">>, "output", shared_constants.output_constants.output_list.item (output_combo.selected_item.text))
			end
			
					-- EiffelStudio Overrides
			if override_12_check.is_selected then
				if not toc_12_title_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "studio_title", toc_12_title_text.text)				
				end
				if not toc_12_location_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "studio_location", toc_12_location_text.text)
				end			
				if not toc_12_pseudo_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "studio_pseudo_name", toc_12_pseudo_text.text)
				end
			end
			
					-- Envision Override
			if override_20_check.is_selected then
				if not toc_20_title_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "envision_title", toc_20_title_text.text)
				end
				if not toc_20_location_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "envision_location", toc_20_location_text.text)
				end
				if not toc_20_pseudo_text.text.is_empty then
					document.set_element (xm_document, l_toc_array, "envision_pseudo_name", toc_20_pseudo_text.text)
				end
			end					
			
			document.set_text (document_text (xm_document))
--			document.widget.internal_edit_widget.set_text (pretty_xml (document.text))
			
					-- Synchronization
			Shared_document_manager.Synchronizer.add_document (document)
			Shared_document_manager.Synchronizer.synchronize
		end		

feature {NONE} -- Commands

	set_text_from_element (widget: EV_TEXT_FIELD; element: XM_ELEMENT) is
			-- Set the text of `widget' from `element' text.
		require
			widget_not_void: widget /= Void
			element_not_void: element /= Void
		local
			l_new_text: STRING
		do
			if not (element.text = Void or element.text.is_empty) then
				l_new_text := element.text
				if not l_new_text.is_empty then
					l_new_text.prune_all ('%N')
					l_new_text.prune_all ('%T')
					widget.set_text (l_new_text)
				end
			end
		end		

	toggle_override_widgets is
			-- Toggle widgets used for overriding default TOC options
			-- based on output type in `output_combo'
		do
			if override_12_check.is_selected then
				toc_12_title_box.enable_sensitive
				toc_12_location_box.enable_sensitive
				toc_12_pseudo_box.enable_sensitive
			else
				toc_12_title_box.disable_sensitive
				toc_12_location_box.disable_sensitive
				toc_12_pseudo_box.disable_sensitive
			end
			if override_20_check.is_selected then
				toc_20_title_box.enable_sensitive
				toc_20_location_box.enable_sensitive
				toc_20_pseudo_box.enable_sensitive
			else
				toc_20_title_box.disable_sensitive
				toc_20_location_box.disable_sensitive
				toc_20_pseudo_box.disable_sensitive
			end			
		end

	display_name_change_warning is
			-- Display warning when attempting name change
		local
			l_question_dialog: EV_MESSAGE_DIALOG
			l_filename, l_name: STRING
			l_new_filename: FILE_NAME
		do
			create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).document_name_change_warning)
			l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).report_title)
			l_question_dialog.set_buttons (<<"Change", "Change and fix broken links", (create {EV_DIALOG_CONSTANTS}).ev_cancel>>)
			l_question_dialog.show_modal_to_window (Application_window)
			l_name := name_text.text
			if l_question_dialog.selected_button.is_equal ("Change") then
				document.change_name (l_name)
				l_question_dialog.destroy
			elseif l_question_dialog.selected_button.is_equal ("Change and fix broken links") then
				l_filename := document.name
				create l_new_filename.make_from_string (directory_no_file_name (l_filename))
				l_new_filename.extend (l_name)
				Shared_project.update_links (
					(create {DOCUMENT_LINK}.make (l_filename, l_filename)), 
					(create {DOCUMENT_LINK}.make (l_new_filename, l_new_filename)))
				document.change_name (l_name)
				l_question_dialog.destroy
			else
				l_question_dialog.destroy
			end
		end

feature {NONE} -- Query

	has_name_changed: BOOLEAN is
			-- Has new name been entered?
		local
			l_new_name: STRING
		do 
			l_new_name := name_text.text
			l_new_name.prune_all_leading (' ')
			l_new_name.prune_all_trailing (' ')
			Result := not l_new_name.is_equal (old_name)
		end

invariant
	has_doc: document /= Void
	
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
end -- class DOCUMENT_PROPERTIES_DIALOG

