indexing
	description: "Enable user  to modify or add rename clauses."
	external_name: "ISE.AssemblyManager.RenameClausesViewer"

class
	RENAME_CLAUSES_VIEWER
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_eiffel_class: like eiffel_class; a_parent_name: like parent_name; a_type_view: like type_view) is
			-- Set `eiffel_class' with `an_eiffel_class'.
			-- Set `parent_name' with `a_parent_name'.
			-- Set `type_view' with `a_type_view'.
		indexing
			external_name: "Make"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_parent_name: a_parent_name /= Void
			not_empty_parent_name: a_parent_name.Length > 0
			non_void_type_view: a_type_view /= Void
		local
			return_value: INTEGER
		do
			make_form
			create dictionary
			eiffel_class := an_eiffel_class
			parent_name := a_parent_name
			type_view := a_type_view
			create rename_table.make
			build_rename_clauses
			initialize_gui
			return_value := showdialog
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			parent_name_set: parent_name.equals_string (a_parent_name)
			type_view_set: type_view = a_type_view
		end

feature -- Access
	
	dictionary: RENAME_CLAUSES_VIEWER_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
			-- Current Eiffel class
		indexing
			external_name: "EiffelClass"
		end
	
	parent_name: STRING 
			-- Parent name
		indexing
			external_name: "ParentName"
		end
	
	type_view: TYPE_VIEW
			-- Type view
		indexing
			external_name: "TypeView"
		end
		
	class_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Class label
		indexing
			external_name: "ClassLabel"
		end

	class_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Class name label
		indexing
			external_name: "ClassNameLabel"
		end

	external_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- External name label
		indexing
			external_name: "ExternalNameLabel"
		end
		
	parent_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Parent label
		indexing
			external_name: "ParentLabel"
		end
	
	parent_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Parent name label
		indexing
			external_name: "ParentNameLabel"
		end

	add_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Add button
		indexing
			external_name: "AddButton"
		end
		
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- OK button
		indexing
			external_name: "OkButton"
		end

	cancel_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Cancel button
		indexing
			external_name: "CancelButton"
		end
	
	created_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Label created with `create_label' feature
		indexing
			external_name: "CreatedLabel"
		end
	
	panel: SYSTEM_WINDOWS_FORMS_PANEL
			-- Main panel
		indexing
			external_name: "Panel"
		end

	rename_clauses: RENAME_CLAUSES
			-- Rename clauses for parent with name `parent_name'
		indexing
			external_name: "RenameClauses"
		end
		
	created_list: SYSTEM_WINDOWS_FORMS_LISTVIEW
			-- List view created by `create_list_view'
		indexing
			external_name: "CreatedList"
		end
	
	rename_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			-- Rename list view
		indexing
			external_name: "RenameListView"
		end
	
	rename_source_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Rename source text box
		indexing
			external_name: "RenameSourceTextBox"
		end

	rename_target_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Rename target text box
		indexing
			external_name: "RenameTargetTextBox"
		end
	
	as_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Label with as keyword for rename clause
		indexing
			external_anme: "AsLabel"
		end
	
	inheritance_clause_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Inheritance clause label
		indexing
			external_name: "InheritanceClauseLabel"
		end
	
	rename_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Inheritance clause text (STRING)
			-- Value: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		indexing
			external_name: "RenameTable"
		end
	
	error_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Error text box
		indexing
			external_name: "ErrorTextBox"
		end
			
	Rename_box_width: INTEGER is
			-- Rename box width
		indexing
			external_name: "RenameBoxWidth"
		require
			non_void_as_label: as_label /= Void
		once
			Result := (dictionary.Window_width - 4 * dictionary.Margin - as_label.width) // 2
		end

feature -- Basic Operations
	
	initialize_gui is
			-- Initialize GUI.
		indexing
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			a_font: SYSTEM_DRAWING_FONT
			a_color: SYSTEM_DRAWING_COLOR
			label_font: SYSTEM_DRAWING_FONT
			external_name_text: STRING
			type: SYSTEM_TYPE
			on_add_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_remove_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_remove_all_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_cancel_event_handler_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)

				-- `Class: '
			create class_label.make_label
			class_label.set_text (dictionary.Class_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin)
			class_label.set_location (a_point)
			class_label.set_autosize (True)
			create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style) 
			class_label.set_font (label_font)
			
				-- Class name 
			create class_name_label.make_label
			a_point.set_X (dictionary.Margin + class_label.width)
			a_point.set_Y (dictionary.Margin)
			class_name_label.set_location (a_point)
			class_name_label.set_text (eiffel_class.eiffelname.toupper)
			class_name_label.set_autosize (True)
			class_name_label.set_font (label_font)	
			
				-- External name
			create external_name_label.make_label
			external_name_text := dictionary.Opening_bracket
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, dictionary.External_name_keyword, dictionary.Colon, dictionary.Space)
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, dictionary.Inverted_comma, eiffel_class.fullexternalname, dictionary.Inverted_comma)
			external_name_text := external_name_text.concat_string_string (external_name_text, dictionary.Closing_bracket)
			external_name_label.set_text (external_name_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			external_name_label.set_location (a_point)			
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			a_size.set_height (dictionary.Label_height)
			external_name_label.set_size (a_size)
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style) 
			external_name_label.set_font (a_font)
			
				-- `Parent: '
			create parent_label.make_label
			parent_label.set_text (dictionary.Parent_label_text)
			a_point.set_X (dictionary.Margin)
			a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			parent_label.set_location (a_point)
			parent_label.set_autosize (True)
			parent_label.set_font (label_font)

			create parent_name_label.make_label
			a_point.set_X (dictionary.Margin + parent_label.width)
			a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			parent_name_label.set_location (a_point)			
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin - parent_label.width)
			a_size.set_height (dictionary.Label_height)
			parent_name_label.set_size (a_size)
			parent_name_label.set_text (parent_name)
			parent_name_label.set_font (Label_font)
			
				-- Main panel
			create panel.make_panel
			a_point.set_x (0)
			a_point.set_y (2 * dictionary.Margin + 3 * dictionary.Label_height)
			panel.set_location (a_point)
			a_size.set_width (dictionary.Window_width)
			a_size.set_height (dictionary.Window_height - 6 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)
			panel.set_size (a_size)
			panel.set_borderstyle (dictionary.Panel_border_style)
			
				-- Rename clauses list
			create_list_view (rename_clauses, dictionary.Margin, dictionary.Margin + dictionary.Label_height)
			rename_list_view := created_list
			rename_list_view.items.item (0).set_selected (True)
			rename_list_view.items.item (0).set_checked (True)
			
				-- Rename clauses label
			create_label (dictionary.Rename_clauses_text, dictionary.Margin, dictionary.Margin)
			
				-- Text box for rename clause
			create_label (dictionary.Rename_clause_text, dictionary.Margin, 2 * dictionary.Margin + dictionary.Label_height + dictionary.List_height)
			inheritance_clause_label := created_label
			display_rename_text_boxes
				
				-- Add button
			create add_button.make_button
			a_point.set_X (dictionary.Margin) 
			a_point.set_Y (3 * dictionary.Margin + 3 * dictionary.Label_height + dictionary.List_height)
			add_button.set_location (a_point)
			add_button.set_text (dictionary.Add_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_add_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnAddEventHandler")
			add_button.add_Click (on_add_event_handler_delegate)
			panel.controls.add (add_button)
			
				-- OK button			
			create ok_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)
			
				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			cancel_button.set_location (a_point)
			cancel_button.set_text (dictionary.Cancel_button_label)
			on_cancel_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCancelEventHandler")
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			controls.add (class_label)
			controls.add (class_name_label)
			controls.add (external_name_label)
			controls.add (parent_label)
			controls.add (parent_name_label)
			controls.add (panel)
			controls.add (ok_button)
			controls.add (cancel_button)
		end

feature -- Event handling

	on_add_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `add_button' activation.
		indexing
			external_name: "OnAddEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			old_rename: ISE_REFLECTION_RENAMECLAUSE
			new_rename: ISE_REFLECTION_RENAMECLAUSE
			rename_clause_handler: RENAME_CLAUSE_HANDLER
			new_inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
			support: ISE_REFLECTION_CONVERSIONSUPPORT
		do			
			if rename_list_view.selecteditems.count > 0 then
				create support.make_conversionsupport
				if rename_source_text_box.text /= Void and rename_target_text_box.text /= Void then
					if rename_source_text_box.text.length > 0 and rename_target_text_box.text.length > 0 and not has_rename (rename_source_text_box.text, rename_target_text_box.text) then
						create new_rename.make_renameclause
						new_rename.makefrominfo (rename_source_text_box.text, rename_target_text_box.text)
						create rename_clause_handler.make (eiffel_class, parent_name, Current)
						if source_exists (rename_source_text_box.text) then
							old_rename := support.renameclausefromtext (existing_list_item.text)
							rename_clause_handler.remove_rename_clause (rename_clause_text_from_info (old_rename.sourcename, old_rename.targetname))
							rename_clause_handler.update_features (new_rename)
							if rename_clause_handler.is_valid then
								panel.controls.remove (	error_text_box)
								rename_clauses.replace (old_rename, new_rename)
								panel.refresh
							else
								rename_source_text_box.clear
								rename_target_text_box.clear
								display_error_message (rename_clause_handler.error_message)
							end
						else
							rename_clause_handler.update_features (new_rename)
							if rename_clause_handler.is_valid then
								panel.controls.remove (error_text_box)
								rename_clauses.add (new_rename)
								panel.refresh
							else
								rename_source_text_box.clear
								rename_target_text_box.clear	
								display_error_message (rename_clause_handler.error_message)
							end
						end
						if rename_clause_handler.is_valid then
							set_new_inheritance_clauses (rename_clause_handler.new_inheritance_clauses)
						end 
					elseif has_rename (rename_source_text_box.text, rename_target_text_box.text) then
						rename_source_text_box.clear
						rename_target_text_box.clear
					end
				end				
			end
		end

	on_item_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process click on an inheritance clause.
		indexing
			external_name: "OnItemEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			selected_items: SELECTEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
			an_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			i: INTEGER
			a_rename_clause: ISE_REFLECTION_RENAMECLAUSE
			item_text: STRING
			support: ISE_REFLECTION_CONVERSIONSUPPORT
		do
			create support.make_conversionsupport
			selected_items := rename_list_view.selecteditems
			if selected_items.count = 1 then
				from
				until
					i = selected_items.count
				loop
					an_item := selected_items.item (i)
					item_text := an_item.text
					if item_text /= Void then
						if item_text.length > 0 and not item_text.equals_string (dictionary.New_clause) then
							a_rename_clause := support.renameclausefromtext (item_text)								
							rename_source_text_box.set_text (a_rename_clause.sourcename)									
							rename_target_text_box.set_text (a_rename_clause.targetname)
						elseif item_text.equals_string (dictionary.New_clause) and rename_source_text_box.text /= Void then
							if rename_source_text_box.text.length > 0 then
								rename_source_text_box.clear
								rename_target_text_box.clear
							end							
						end
						panel.controls.remove (error_text_box)
						panel.refresh
					end
					i := i + 1
				end
			end
		end
	
	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `ok_button' activation.
		indexing
			external_name: "OnOkEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			type_view.set_eiffel_class (eiffel_class)
			close
		end

	on_cancel_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `cancel_button' activation.
		indexing
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end

feature -- Gui Update

	update_add (a_clause: ISE_REFLECTION_RENAMECLAUSE) is
			-- Add `a_clause' in the list view of current inheritance clauses.
		indexing
			external_name: "UpdateAdd"
		require
			non_void_clause: a_clause /= Void
		local
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			a_new_clause: STRING
		do
			a_new_clause := rename_clause_text_from_info (a_clause.sourcename, a_clause.targetname)
			create list_view_item.make_1 (a_new_clause)
			list_view_item := rename_list_view.items.add_listviewitem (list_view_item)
			rename_table.add (a_new_clause, list_view_item)
			rename_source_text_box.clear
			rename_target_text_box.clear
			rename_list_view.items.item (0).set_selected (True)
			rename_list_view.items.item (0).set_checked (True)
			panel.refresh
		end

	update_replace (an_old_clause, a_new_clause: ISE_REFLECTION_RENAMECLAUSE) is
			-- Replace `an_old_clause' from the list view of current inheritance clauses by `a_new_clause'.
		indexing
			external_name: "UpdateReplace"
		require
			non_void_old_clause: an_old_clause /= Void
			non_void_new_clause: a_new_clause /= Void
		local
			old_text: STRING
			new_text: STRING
			an_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			new_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		do
			old_text := rename_clause_text_from_info (an_old_clause.sourcename, an_old_clause.targetname)
			if rename_table.contains (old_text) then
				an_item ?= rename_table.item (old_text)
				rename_list_view.items.remove (an_item)
				rename_table.remove (old_text)
				new_text := rename_clause_text_from_info (a_new_clause.sourcename, a_new_clause.targetname)
				create new_item.make_1 (new_text)
				new_item := rename_list_view.items.add_listviewitem (new_item)
				rename_table.add (new_text, new_item)
				rename_source_text_box.clear
				rename_target_text_box.clear
				rename_list_view.items.item (0).set_selected (True)
				rename_list_view.items.item (0).set_checked (True)
			end
			panel.refresh
		end

feature {RENAME_CLAUSE_HANDLER} -- Basic Operations

	rename_clause_text_from_info (a_source, a_target: STRING): STRING is
			-- Rename clause text built from `a_source' and `a_target'
		indexing
			external_name: "RenameClauseTextFromInfo"
		require
			non_void_source: a_source /= Void
			non_void_target: a_target /= Void
			not_empty_source: a_source.length > 0
			not_empty_target: a_target.length > 0	
		local
			a_rename_clause: ISE_REFLECTION_RENAMECLAUSE
		do
			create a_rename_clause.make_renameclause
			a_rename_clause.makefrominfo (a_source, a_target)
			Result := a_rename_clause.tostring
		ensure
			rename_clause_text_created: Result /= Void
			not_empty_rename_clause_Text: Result.length > 0
		end
		
feature {NONE} -- Implementation

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type
		indexing
			external_name: "TypeFactory"
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate
		indexing
			external_name: "DelegateFactory"
		end
		
	build_rename_clauses is
			-- Build `rename_clauses'.
		indexing
			external_name: "BuildRenameClauses"
		local
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
			renames: SYSTEM_COLLECTIONS_ARRAYLIST
			a_rename_clause: STRING
			i: INTEGER
			as_index: INTEGER
			source: STRING
			target: STRING
			rename_clause: ISE_REFLECTION_RENAMECLAUSE
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
			added: INTEGER
			support: ISE_REFLECTION_CONVERSIONSUPPORT
		do
			create support.make_conversionsupport
			parents := eiffel_class.parents
			inheritance_clauses ?= parents.item (parent_name)
			if inheritance_clauses /= Void then
				if inheritance_clauses.count = 5 then
					renames := inheritance_clauses.item (0)
					from
						create a_list.make
					until
						i = renames.count
					loop
						a_rename_clause ?= renames.item (i)
						if a_rename_clause /= Void then
							added := a_list.add (support.renameclausefromtext (a_rename_clause))
						end
						i := i + 1
					end
					create rename_clauses.make (a_list)
				end	
			end
			rename_clauses.set_add_agent (Current)
			rename_clauses.set_replace_agent (Current)
		end
		
	create_label (a_text: STRING; x_position, y_position: INTEGER) is
			-- Create a text box with text `a_text' at position (x_position, y_position).
		indexing
			external_name: "CreateTextBox"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
		local
			a_label: SYSTEM_WINDOWS_FORMS_LABEL
			a_point: SYSTEM_DRAWING_POINT
			a_font: SYSTEM_DRAWING_FONT
		do
			create a_label.make_label
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			a_label.set_location (a_point)
			a_label.set_text (a_text)	
			a_label.set_autosize (True)
			a_label.set_borderstyle (0)
			a_label.set_textalign (32)
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			a_label.set_font (a_font)
			panel.controls.add (a_label)
			created_label := a_label
		end
	
	create_list_view (clauses: RENAME_CLAUSES; x_position, y_position: INTEGER) is
			-- Create a list view corresponding to `clauses' at position (x_position, y_position).
		indexing
			external_name: "CreateListView"
		require
			non_void_clauses: clauses /= Void
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
		local
			list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			i: INTEGER
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			type: SYSTEM_TYPE
			on_item_event_handler_delegate: SYSTEM_EVENTHANDLER
			rename_clause: ISE_REFLECTION_RENAMECLAUSE
		do
			create list_view.make_listview
			list_view.set_borderstyle (dictionary.List_view_border_style)
			list_view.set_checkboxes (False)
			list_view.set_fullrowselect (True)
			list_view.set_gridlines (False)
			list_view.set_multiselect (False)
			list_view.set_sorting (0)
			list_view.set_view (dictionary.View)
			list_view.set_activation (0)
			list_view.set_alignment (dictionary.Alignment)
			list_view.set_scrollable (True)
			list_view.set_tabindex (0)
			
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			list_view.set_location (a_point)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			a_size.set_height (dictionary.List_height)
			list_view.set_size (a_size)	
			create list_view_item.make_1 (dictionary.New_clause)
			list_view_item := list_view.items.add_listviewitem (list_view_item)
			a_list := clauses.rename_clauses
			from
			until
				i = a_list.count
			loop
				rename_clause ?= a_list.item (i)
				if rename_clause /= Void then
					create list_view_item.make_1 (rename_clause.tostring)
					rename_table.add (rename_clause.tostring, list_view_item)
					list_view_item := list_view.items.add_listviewitem (list_view_item)
				end				
				i := i + 1
			end
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_item_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnItemEventHandler")
			list_view.add_Click (on_item_event_handler_delegate)		
			panel.controls.add (list_view)
			created_list := list_view
		end
	
	display_rename_text_boxes is
			-- Display `rename_source_text_box' and `rename_target_text_box'.
		indexing
			external_name: "DisplayRenameTextBoxes"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			tmp_label: SYSTEM_WINDOWS_FORMS_LABEL
			as_label_width: INTEGER
		do
			create tmp_label.make_label
			tmp_label.set_autosize (True)
			tmp_label.set_text (dictionary.As_keyword)
			as_label_width := tmp_label.width
			
			create_label (dictionary.As_keyword, dictionary.Window_width // 2 - as_label_width //2, 3 * dictionary.Margin + 2 * dictionary.Label_height + dictionary.List_height)
			as_label := created_label
			
			create rename_source_text_box.make_textbox
			a_point.set_x (dictionary.Margin)
			a_point.set_y (2 * dictionary.Margin + 2 * dictionary.Label_height + dictionary.List_height)
			rename_source_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			a_size.set_height (dictionary.Label_height)
			rename_source_text_box.set_size (a_size)
			panel.controls.add (rename_source_text_box)	

			create rename_target_text_box.make_textbox			
			a_point.set_x (dictionary.Margin + created_label.width + Rename_box_width + 2 * dictionary.Margin)
			a_point.set_y (2 * dictionary.Margin + 2 * dictionary.Label_height + dictionary.List_height)
			rename_target_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			a_size.set_height (dictionary.Label_height)
			rename_target_text_box.set_size (a_size)
			panel.controls.add (rename_target_text_box)	
		end
	
	existing_list_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM 
			-- Existing list view item (Result of `source_exists').
		indexing
			external_name: "ExistingListItem"
		end

	has_rename (a_source, a_target: STRING): BOOLEAN is
			-- Is rename clause built from `a_source' and `a_target' already in rename clauses?
		indexing
			external_name: "HasRename"
		require
			non_void_source: a_source /= Void
			not_empty_source: a_source.length > 0
			non_void_target: a_target /= Void
			not_empty_target: a_target.length > 0
		local
			a_rename_clause: STRING
			list_items: LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
			i: INTEGER
		do
			a_rename_clause := rename_clause_text_from_info (a_source, a_target)
			list_items := rename_list_view.items
			from
			until
				i = list_items.count or Result
			loop
				Result := list_items.item (i).text.tolower.equals_string (a_rename_clause.tolower)
				i := i + 1
			end
		end	
	
	source_exists (a_source: STRING): BOOLEAN is
			-- Does a rename clause has `a_source' as source feature name?
			-- | If found, make list view item available in `existing_ist_item'.
		indexing
			external_name: "SourceExists"
		require
			non_void_source: a_source /= Void
			not_empty_source: a_source.length > 0
		local
			list_items: LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
			i: INTEGER
			existing_source: STRING
			support: ISE_REFLECTION_CONVERSIONSUPPORT
		do
			create support.make_conversionsupport
			list_items := rename_list_view.items
			from
				i := 1
			until
				i = list_items.count or Result
			loop
				existing_source := support.sourcefromtext (list_items.item (i).text)
				if existing_source.tolower.equals_string (a_source.tolower) then
					existing_list_item := list_items.item (i)
					Result := True
				end
				i := i + 1
			end
		end
	
	set_new_inheritance_clauses (clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]) is
			-- Set inheritance clauses of `eiffel_class' for `parent_name' with `clauses'.
		indexing
			external_name: "SetNewInheritanceClauses"
		require
			non_void_clauses: clauses /= Void
		do
			eiffel_class.parents.remove (parent_name)
			eiffel_class.parents.add (parent_name, clauses)
		end
	
	display_error_message (a_message: STRING) is
			-- Display `a_message' in a text box at the bottom of the window.
		indexing
			external_name: "DisplayErrorMessage"
		require
			non_void_message: a_message /= Void
			not_empty_message: a_message.length > 0
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
		do
			create error_text_box.make_textbox
			error_text_box.set_forecolor (dictionary.Red_color)
			error_text_box.set_text (a_message)
			a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			a_size.set_height (dictionary.Label_height)
			error_text_box.set_size (a_size)
			a_point.set_x (dictionary.Margin)
			a_point.set_y (4 * dictionary.Margin + 4 * dictionary.Label_height + dictionary.List_height)
			error_text_box.set_location (a_point)
			panel.controls.add (error_text_box)
		end
			
end -- class RENAME_CLAUSES_VIEWER
