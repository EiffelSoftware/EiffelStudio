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
		
feature -- Constants

--	Title: STRING is "Inheritance clauses viewer"
--			-- Window title
--		indexing
--			external_name: "Title"
--		end
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
		end

	Panel_border_style: INTEGER is 0
			-- Panel border style: none
		indexing
			external_name: "PanelBorderStyle"
		end
		
	Window_width: INTEGER is 800
			-- Window width
		indexing
			external_name: "WindowWidth"
		end

	Window_height: INTEGER is 600
			-- Window height
		indexing
			external_name: "WindowHeight"
		end
		
--	Class_label_text: STRING is "Class: "
--			-- Text of class label
--		indexing
--			external_name: "ClassLabelText"
--		end
--	
	Margin: INTEGER is 10
			-- Margin
		indexing
			external_name: "Margin"
		end
	
	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
	
--	Font_family_name: STRING is "Verdana"
--			-- Name of label font family
--		indexing
--			external_name: "FontFamilyName"
--		end
	
	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end

	Font_size: REAL is 8.0
			--Font size
		indexing
			external_name: "FontSize"
		end
		
	Bold_style: INTEGER is 1
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end
		
--	Parent_label_text: STRING is "Parent: " 
--			-- Text of parent label
--		indexing
--			external_name: "ParentLabelText"
--		end
--
--	Add_button_label: STRING is "Add"
--			-- Add button label
--		indexing
--			external_name: "AddButtonLabel"
--		end
--		
--	Ok_button_label: STRING is "OK"
--			-- OK button label
--		indexing
--			external_name: "OkButtonLabel"
--		end
--		
--	Cancel_button_label: STRING is "Cancel"
--			-- Cancel button label
--		indexing
--			external_name: "CancelButtonLabel"
--		end
--
--	System_event_handler_type: STRING is "System.EventHandler"
--			-- `System.EventHandler' type
--		indexing
--			external_name: "SystemEventHandlerType"
--		end
--	
--	Space: STRING is " "
--			-- Space
--		indexing
--			external_name: "Space"
--		end
--	
--	Opening_bracket: STRING is "("
--			-- Opening bracket
--		indexing
--			external_name: "OpeningBracket"
--		end
--
--	Closing_bracket: STRING is ")"
--			-- Closing bracket
--		indexing
--			external_name: "ClosingBracket"
--		end
--	
--	Colon: STRING is ":"
--			-- Colon
--		indexing
--			external_name: "Colon"
--		end
--	
--	Inverted_comma: STRING is "%""
--			-- Inverted comma
--		indexing
--			external_name: "ExternalName"
--		end
--	
--	External_name_keyword: STRING is "External name"
--			-- External name
--		indexing
--			external_name: "ExternalNameKeyword"
--		end
		
	Button_width: INTEGER is 75
			-- Button width
		indexing
			external_name: "ButtonWidth"
		end

	Button_height: INTEGER is 23
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
		
	List_height: INTEGER is 
			-- Rename list height
		indexing
			external_name: "ListHeight"
		once
			--Result := dictionary.Window_height - 14 * dictionary.Margin - 6 * dictionary.Label_height - 2 * dictionary.Button_height
			Result := Window_height - 14 * Margin - 6 * Label_height - 2 * Button_height
		end
	
--	Rename_clauses_text: STRING is "Rename clauses: "
--			-- Rename clauses label text
--		indexing
--			external_name: "RenameClausesText"
--		end
--		
--	Rename_clause_text: STRING is "Rename clause: "
--			-- Rename clause label text
--		indexing
--			external_name: "RenameClauseText"
--		end
--
	List_view_border_style: INTEGER is 1
			-- List view border style
		indexing
			external_name: "ListViewBorderStyle"
		end
	
--	New_clause: STRING is "-- New clause"
--			-- New clause
--		indexing
--			external_name: "NewClause"
--		end
--	
--	As_keyword: STRING is "as"
--			-- As keyword
--		indexing
--			external_name: "AsKeyword"
--		end
		
	Rename_box_width: INTEGER is
			-- Rename box width
		indexing
			external_name: "RenameBoxWidth"
		require
			non_void_as_label: as_label /= Void
		once
			--Result := (dictionary.Window_width - 4 * dictionary.Margin - as_label.width) // 2
			Result := (Window_width - 4 * Margin - as_label.width) // 2
		end
	
--	Red_color: SYSTEM_DRAWING_COLOR is
--			-- Red color
--		indexing
--			external_name: "RedColor"
--		once
--			Result := Result.Red
--		end

	View: INTEGER is 3
			-- View property for list view
		indexing
			external_name: "View"
		end

	Alignment: INTEGER is 5
			-- Alignment in list view
		indexing
			external_name: "Alignment"
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
			--set_borderstyle (dictionary.Border_style)
			--a_size.set_Width (dictionary.Window_width)
			--a_size.set_Height (dictionary.Window_height)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)

				-- `Class: '
			create class_label.make_label
			class_label.set_text (dictionary.Class_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Margin)
			a_point.set_Y (Margin)
			class_label.set_location (a_point)
			class_label.set_autosize (True)
			--create label_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style) 						create label_font.make_font_10 (dictionary.Font_family_name, Label_font_size,  Bold_style) 
			create label_font.make_font_10 (dictionary.Font_family_name, Label_font_size, Bold_style) 						create label_font.make_font_10 (dictionary.Font_family_name, Label_font_size,  Bold_style) 
			class_label.set_font (label_font)
			
				-- Class name 
			create class_name_label.make_label
			--a_point.set_X (dictionary.Margin + class_label.width)
			--a_point.set_Y (dictionary.Margin)
			a_point.set_X (Margin + class_label.width)
			a_point.set_Y (Margin)
			class_name_label.set_location (a_point)
			class_name_label.set_text (eiffel_class.eiffelname.toupper)
			class_name_label.set_autosize (True)
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style)
			--create a_font.make_font_10 (dictionary.Font_family_name, Label_font_size, Bold_style)
			class_name_label.set_font (label_font)	
			
				-- External name
			create external_name_label.make_label
			external_name_text := dictionary.Opening_bracket
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, dictionary.External_name_keyword, dictionary.Colon, dictionary.Space)
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, dictionary.Inverted_comma, eiffel_class.fullexternalname, dictionary.Inverted_comma)
			external_name_text := external_name_text.concat_string_string (external_name_text, dictionary.Closing_bracket)
			external_name_label.set_text (external_name_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin + dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin + Label_height)
			external_name_label.set_location (a_point)			
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			--a_size.set_height (dictionary.Label_height)
			a_size.set_width (Window_width - 2 * Margin)
			a_size.set_height (Label_height)
			external_name_label.set_size (a_size)
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style) 
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size,  Bold_style) 
			external_name_label.set_font (a_font)
			
				-- `Parent: '
			create parent_label.make_label
			parent_label.set_text (dictionary.Parent_label_text)
			--a_point.set_X (dictionary.Margin)
			--a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			a_point.set_X (Margin)
			a_point.set_Y (Margin + 2 * Label_height)
			parent_label.set_location (a_point)
			parent_label.set_autosize (True)
			parent_label.set_font (label_font)

			create parent_name_label.make_label
			--a_point.set_X (dictionary.Margin + parent_label.width)
			--a_point.set_Y (dictionary.Margin + 2 * dictionary.Label_height)
			a_point.set_X (Margin + parent_label.width)
			a_point.set_Y (Margin + 2 * Label_height)
			parent_name_label.set_location (a_point)			
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin - parent_label.width)
			a_size.set_width (Window_width - 2 * Margin - parent_label.width)
			--a_size.set_height (dictionary.Label_height)
			a_size.set_height (Label_height)
			parent_name_label.set_size (a_size)
			parent_name_label.set_text (parent_name)
			parent_name_label.set_font (Label_font)
			
				-- Main panel
			create panel.make_panel
			a_point.set_x (0)
			--a_point.set_y (2 * dictionary.Margin + 3 * dictionary.Label_height)
			a_point.set_y (2 * Margin + 3 * Label_height)
			panel.set_location (a_point)
			--a_size.set_width (dictionary.Window_width)
			--a_size.set_height (dictionary.Window_height - 6 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)
			a_size.set_width (Window_width)
			a_size.set_height (Window_height - 6 * Margin - 3 * Label_height - Button_height)
			panel.set_size (a_size)
			panel.set_borderstyle (Panel_border_style)
			
				-- Rename clauses list
			--create_list_view (rename_clauses, dictionary.Margin, dictionary.Margin + dictionary.Label_height)
			create_list_view (rename_clauses, Margin, Margin + Label_height)
			rename_list_view := created_list
			rename_list_view.items.item (0).set_selected (True)
			rename_list_view.items.item (0).set_checked (True)
			
				-- Rename clauses label
			--create_label (dictionary.Rename_clauses_text, dictionary.Margin, dictionary.Margin)
			create_label (dictionary.Rename_clauses_text, Margin, Margin)
			
				-- Text box for rename clause
			--create_label (dictionary.Rename_clause_text, dictionary.Margin, 2 * dictionary.Margin + dictionary.Label_height + List_height)
			create_label (dictionary.Rename_clause_text, Margin, 2 * Margin + Label_height + List_height)
			inheritance_clause_label := created_label
			display_rename_text_boxes
				
				-- Add button
			create add_button.make_button
			a_point.set_X (Margin) 
			a_point.set_Y (3 * Margin + 3 * Label_height + List_height)
			--a_point.set_X (dictionary.Margin) 
			--a_point.set_Y (3 * dictionary.Margin + 3 * dictionary.Label_height + List_height)
			add_button.set_location (a_point)
			add_button.set_text (dictionary.Add_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_add_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnAddEventHandler")
			add_button.add_Click (on_add_event_handler_delegate)
			panel.controls.add (add_button)
			
				-- OK button			
			create ok_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			--a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) - (Margin //2) - Button_width) 
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)
			
				-- Cancel button
			create cancel_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) + (dictionary.Margin //2))
			--a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) + (Margin //2))
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
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
			old_rename: RENAME_CLAUSE
			new_rename: RENAME_CLAUSE
			rename_clause_handler: RENAME_CLAUSE_HANDLER
			new_inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			if rename_list_view.selecteditems.count > 0 then
				if rename_source_text_box.text /= Void and rename_target_text_box.text /= Void then
					if rename_source_text_box.text.length > 0 and rename_target_text_box.text.length > 0 and not has_rename (rename_source_text_box.text, rename_target_text_box.text) then
						create new_rename.make (rename_source_text_box.text, rename_target_text_box.text)
						create rename_clause_handler.make (eiffel_class, parent_name, Current)
						if source_exists (rename_source_text_box.text) then
							old_rename := rename_clause_from_text (existing_list_item.text)
							rename_clause_handler.remove_rename_clause (rename_clause_text_from_info (old_rename.source, old_rename.target))
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
			a_rename_clause: RENAME_CLAUSE
			item_text: STRING
		do
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
							a_rename_clause := rename_clause_from_text (item_text)								
							rename_source_text_box.set_text (a_rename_clause.source)									
							rename_target_text_box.set_text (a_rename_clause.target)
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

	update_add (a_clause: RENAME_CLAUSE) is
			-- Add `a_clause' in the list view of current inheritance clauses.
		indexing
			external_name: "UpdateAdd"
		require
			non_void_clause: a_clause /= Void
		local
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			a_new_clause: STRING
		do
			a_new_clause := rename_clause_text_from_info (a_clause.source, a_clause.target)
			create list_view_item.make_1 (a_new_clause)
			list_view_item := rename_list_view.items.add_listviewitem (list_view_item)
			rename_table.add (a_new_clause, list_view_item)
			rename_source_text_box.clear
			rename_target_text_box.clear
			rename_list_view.items.item (0).set_selected (True)
			rename_list_view.items.item (0).set_checked (True)
			panel.refresh
		end

	update_replace (an_old_clause, a_new_clause: RENAME_CLAUSE) is
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
			old_text := rename_clause_text_from_info (an_old_clause.source, an_old_clause.target)
			if rename_table.contains (old_text) then
				an_item ?= rename_table.item (old_text)
				rename_list_view.items.remove (an_item)
				rename_table.remove (old_text)
				new_text := rename_clause_text_from_info (a_new_clause.source, a_new_clause.target)
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
		do
			Result := a_source
			Result := Result.concat_string_string_string_string (Result, dictionary.Space, dictionary.As_keyword, dictionary.Space)
			Result := Result.concat_string_string (Result, a_target)
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
			rename_clause: RENAME_CLAUSE
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
			added: INTEGER
		do
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
							added := a_list.add (rename_clause_from_text (a_rename_clause))
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
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Bold_style)
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
			clause_text: STRING
			rename_clause: RENAME_CLAUSE
		do
			create list_view.make_listview
			--list_view.set_borderstyle (dictionary.List_view_border_style)
			list_view.set_borderstyle (List_view_border_style)
			list_view.set_checkboxes (False)
			list_view.set_fullrowselect (True)
			list_view.set_gridlines (False)
			list_view.set_multiselect (False)
			list_view.set_sorting (0)
			--list_view.set_view (dictionary.View)
			list_view.set_view (View)
			list_view.set_activation (0)
			--list_view.set_alignment (dictionary.Alignment)
			list_view.set_alignment (Alignment)
			list_view.set_scrollable (True)
			list_view.set_tabindex (0)
			
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			list_view.set_location (a_point)
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			a_size.set_width (Window_width - 2 * Margin)
			a_size.set_height (List_height)
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
					clause_text := rename_clause.source
					clause_text := clause_text.concat_string_string_string_string (clause_text, dictionary.Space, dictionary.As_keyword, dictionary.Space)
					clause_text := clause_text.concat_string_string (clause_text, rename_clause.target)
					create list_view_item.make_1 (clause_text)
					rename_table.add (clause_text, list_view_item)
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
			
			--create_label (dictionary.As_keyword, dictionary.Window_width // 2 - as_label_width //2, 3 * dictionary.Margin + 2 * dictionary.Label_height + List_height)
			create_label (dictionary.As_keyword, Window_width // 2 - as_label_width //2, 3 * Margin + 2 * Label_height + List_height)
			as_label := created_label
			
			create rename_source_text_box.make_textbox
			--a_point.set_x (dictionary.Margin)
			--a_point.set_y (2 * dictionary.Margin + 2 * dictionary.Label_height + List_height)
			a_point.set_x (Margin)
			a_point.set_y (2 * Margin + 2 * Label_height + List_height)
			rename_source_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			--a_size.set_height (dictionary.Label_height)
			a_size.set_height (Label_height)
			rename_source_text_box.set_size (a_size)
			panel.controls.add (rename_source_text_box)	

			create rename_target_text_box.make_textbox			
			--a_point.set_x (dictionary.Margin + created_label.width + Rename_box_width + 2 * dictionary.Margin)
			--a_point.set_y (2 * dictionary.Margin + 2 * dictionary.Label_height + List_height)
			a_point.set_x (Margin + created_label.width + Rename_box_width + 2 * Margin)
			a_point.set_y (2 * Margin + 2 * Label_height + List_height)
			rename_target_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			--a_size.set_height (dictionary.Label_height)
			a_size.set_height (Label_height)
			rename_target_text_box.set_size (a_size)
			panel.controls.add (rename_target_text_box)	
		end
	
	rename_clause_from_text (a_text: STRING): RENAME_CLAUSE is
			-- Rename clause corresponding to `a_text'
		indexing
			external_name: "RenameClauseFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
		local
			as_index: INTEGER
			source: STRING
			target: STRING
			test_string: STRING
		do
			test_string := dictionary.Space
			test_string := test_string.concat_string_string_string (test_string, dictionary.As_keyword, dictionary.Space)
			as_index := a_text.indexof_string_int32 (test_string, 0)
			if as_index /= 0 then
				source := a_text.substring_int32_int32 (0, as_index)
				target := a_text.substring (as_index + test_string.length)	
				create Result.make (source, target)
			end
		ensure
			rename_clause_created: Result /= Void
		end
	
	source_from_text (a_text: STRING): STRING is
			-- Rename clause source from `a_text'
		indexing
			external_name: "SourceFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := dictionary.Space
			test_string := test_string.concat_string_string_string (test_string, dictionary.As_keyword, dictionary.Space)
			as_index := a_text.indexof_string_int32 (test_string, 0)
			if as_index > 0 then
				Result := a_text.substring_int32_int32 (0, as_index)
			end
		ensure
			source_built: Result /= Void
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
		do
			list_items := rename_list_view.items
			from
				i := 1
			until
				i = list_items.count or Result
			loop
				existing_source := source_from_text (list_items.item (i).text)
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
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			--a_size.set_height (dictionary.Label_height)
			a_size.set_width (Window_width - 2 * Margin)
			a_size.set_height (Label_height)
			error_text_box.set_size (a_size)
			--a_point.set_x (dictionary.Margin)
			--a_point.set_y (4 * dictionary.Margin + 4 * dictionary.Label_height + dictionary.List_height)
			a_point.set_x (Margin)
			a_point.set_y (4 * Margin + 4 * Label_height + List_height)
			error_text_box.set_location (a_point)
			panel.controls.add (error_text_box)
		end
			
end -- class RENAME_CLAUSES_VIEWER
