indexing
	description: "Properties dialog for editor xml documents."
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
			xm_document := deserialize_document (create {FILE_NAME}.make_from_string (document.name))
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
			override_12_check.select_actions.extend (agent toggle_studio_override)
			override_20_check.select_actions.extend (agent toggle_envision_override)
			output_combo.select_actions.extend (agent toggle_override_widgets)
			output_combo.disable_edit
		end

	initialize_output is
			-- Initialize output options
		local
			l_outputs: ARRAYED_LIST [STRING]
			l_item: EV_LIST_ITEM
		do
			l_outputs := Shared_constants.Application_constants.Output_list
			from
				l_outputs.start
			until
				l_outputs.after
			loop
				create l_item.make_with_text (l_outputs.item)
				output_combo.extend (l_item)
				if document.output_filter_text.is_equal (l_outputs.item) then
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
			-- Build the dialog with information from `'a_doc
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
				l_toc_element := xm_document.root_element.element_by_name ("help").element_by_name ("toc")
				if l_toc_element /= Void then
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
				end
				toggle_studio_override
				toggle_envision_override
			end
		end

	set_options is
			-- Set options chosen in widgets
		local
			l_formatter: XM_ESCAPED_FORMATTER			
		do
			if has_name_changed then
				display_name_change_warning
			end
			document.set_attribute (xm_document, <<"document">>, "title", toc_title_text.text)
			if output_combo.selected_item.text.is_equal ("all") then
				document.set_attribute (xm_document, <<"document">>, "output", "")
			else
				document.set_attribute (xm_document, <<"document">>, "output", output_combo.selected_item.text)
			end
			if override_12_check.is_sensitive and then override_12_check.is_selected then
				document.set_element (xm_document, <<"document", "help", "toc">>, "studio_title", toc_12_title_text.text)
				document.set_element (xm_document, <<"document", "help", "toc">>, "studio_location", toc_12_location_text.text)
			else
				document.set_element (xm_document, <<"document", "help", "toc">>, "studio_title", "")
				document.set_element (xm_document, <<"document", "help", "toc">>, "studio_location", "")
			end
			if override_20_check.is_sensitive and then override_20_check.is_selected then
				document.set_element (xm_document, <<"document", "help", "toc">>, "envision_title", toc_20_title_text.text)
				document.set_element (xm_document, <<"document", "help", "toc">>, "envision_location", toc_20_location_text.text)
			else
				document.set_element (xm_document, <<"document", "help", "toc">>, "envision_title", "")
				document.set_element (xm_document, <<"document", "help", "toc">>, "envision_location", "")
			end		
				
			save_xml_document (xm_document, create {FILE_NAME}.make_from_string (document.name))
			create l_formatter.make
			l_formatter.process_document (xm_document)
			document.set_text (l_formatter.last_string)
			
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
			if output_combo.selected_item.text.is_equal ("all") then
				override_12_check.enable_sensitive
				override_20_check.enable_sensitive
			elseif output_combo.selected_item.text.is_equal ("studio") then
				override_12_check.disable_sensitive
				override_20_check.disable_sensitive
			elseif output_combo.selected_item.text.is_equal ("envision") then
				override_12_check.disable_sensitive
				override_20_check.disable_sensitive
			end
			toggle_studio_override
			toggle_envision_override
		end

	toggle_studio_override is
			-- Toggle overide widgets accordingly
		do
			if override_12_check.is_sensitive and then override_12_check.is_selected then
				toc_12_title_text.enable_sensitive
				toc_12_location_text.enable_sensitive
			else
				toc_12_title_text.disable_sensitive
				toc_12_location_text.disable_sensitive
			end
		end
		
	toggle_envision_override is
			-- Toggle overide widgets accordingly
		do
			if override_20_check.is_sensitive and then override_20_check.is_selected then
				toc_20_title_text.enable_sensitive
				toc_20_location_text.enable_sensitive
			else
				toc_20_title_text.disable_sensitive
				toc_20_location_text.disable_sensitive
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
	
end -- class DOCUMENT_PROPERTIES_DIALOG

