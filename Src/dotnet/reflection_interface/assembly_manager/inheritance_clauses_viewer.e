indexing
	description: "Enable user  to modify, add or remove inheritance clauses."
	external_name: "AssemblyManager.InheritanceClausesViewer"

class
	INHERITANCE_CLAUSES_VIEWER
	
inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_eiffel_class: like eiffel_class; a_parent_name: like parent_name) is
			-- Set `eiffel_class' with `an_eiffel_class'.
			-- Set `parent_name' with `a_parent_name'.
		indexing
			external_name: "Make"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_parent_name: a_parent_name /= Void
			not_empty_parent_name: a_parent_name.Length > 0
		local
			return_value: INTEGER
		do
			make_form
			eiffel_class := an_eiffel_class
			parent_name := a_parent_name
			create rename_table.make
			create undefine_table.make
			create redefine_table.make
			build_inheritance_clauses
			initialize_gui
			return_value := showdialog
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			parent_name_set: parent_name.equals (a_parent_name)
		end

feature -- Access
	
	console: SYSTEM_CONSOLE
	
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

	remove_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Remove button
		indexing
			external_name: "RemoveButton"
		end

	remove_all_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- Remove all button
		indexing
			external_name: "RemoveAllButton"
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
		
	undefine_clauses: UNDEFINE_CLAUSES
			-- Undefine clauses for parent with name `parent_name'
		indexing
			external_name: "UndefineClauses"
		end

	redefine_clauses: REDEFINE_CLAUSES
			-- Redefine clauses for parent with name `parent_name'
		indexing
			external_name: "RedefineClauses"
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

	undefine_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			-- Undefine list view
		indexing
			external_name: "UndefineListView"
		end

	redefine_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
			-- Redefine list view
		indexing
			external_name: "RedefineListView"
		end
	
	inheritance_clause_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Inheritance clause text box
		indexing
			external_name: "InheritanceClauseTextBox"
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

	undefine_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Inheritance clause text (STRING)
			-- Value: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		indexing
			external_name: "UndefineTable"
		end

	redefine_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Inheritance clause text (STRING)
			-- Value: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		indexing
			external_name: "RedefineTable"
		end
		
feature -- Constants

	Title: STRING is "Inheritance clauses viewer"
			-- Window title
		indexing
			external_name: "Title"
		end
	
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
		
	Class_label_text: STRING is "Class: "
			-- Text of class label
		indexing
			external_name: "ClassLabelText"
		end
	
	Left_margin: INTEGER is 13
			-- Left margin
		indexing
			external_name: "LeftMargin"
		end

	Middle_margin: INTEGER is 12
			-- Margin between lists
		indexing
			external_name: "MiddleMargin"
		end
		
	Top_margin: INTEGER is 10
			-- Top margin
		indexing
			external_name: "TopMargin"
		end
	
	Label_height: INTEGER is 20
			-- Label height
		indexing
			external_name: "LabelHeight"
		end
	
	Font_family_name: STRING is "Verdana"
			-- Name of label font family
		indexing
			external_name: "FontFamilyName"
		end
	
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
		
	Parent_label_text: STRING is "Parent: " 
			-- Text of parent label
		indexing
			external_name: "ParentLabelText"
		end

	Add_button_label: STRING is "Add"
			-- Add button label
		indexing
			external_name: "AddButtonLabel"
		end

	Remove_button_label: STRING is "Remove"
			-- Remove button label
		indexing
			external_name: "RemoveButtonLabel"
		end

	Remove_all_button_label: STRING is "Remove All"
			-- Remove all button label
		indexing
			external_name: "RemoveAllButtonLabel"
		end
		
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end
		
	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
		end

	System_event_handler_type: STRING is "System.EventHandler"
			-- `System.EventHandler' type
		indexing
			external_name: "SystemEventHandlerType"
		end
	
	Space: STRING is " "
			-- Space
		indexing
			external_name: "Space"
		end
	
	Opening_bracket: STRING is "("
			-- Opening bracket
		indexing
			external_name: "OpeningBracket"
		end

	Closing_bracket: STRING is ")"
			-- Closing bracket
		indexing
			external_name: "ClosingBracket"
		end
	
	Colon: STRING is ":"
			-- Colon
		indexing
			external_name: "Colon"
		end
	
	Inverted_comma: STRING is "%""
			-- Inverted comma
		indexing
			external_name: "ExternalName"
		end
	
	External_name_keyword: STRING is "External name"
			-- External name
		indexing
			external_name: "ExternalNameKeyword"
		end

	Large_button_width: INTEGER is 85
			-- Large button width
		indexing
			external_name: "LargeButtonWidth"
		end
		
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

	Italic_style: INTEGER is 2
			-- Italic style
		indexing
			external_name: "ItalicStyle"
		end

	List_width: INTEGER is 250
			-- Inheritance list width
		indexing
			external_name: "ListWidth"
		end
		
	List_height: INTEGER is 
			-- Inheritance list height
		indexing
			external_name: "ListHeight"
		once
			Result := Window_height - 13 * Top_margin - 6 * Label_height - 2 * Button_height
		end
	
	Rename_clauses_text: STRING is "Rename clauses: "
			-- Rename clauses label text
		indexing
			external_name: "RenameClausesText"
		end

	Undefine_clauses_text: STRING is "Undefine clauses: "
			-- Undefine clauses label text
		indexing
			external_name: "UndefineClausesText"
		end

	Redefine_clauses_text: STRING is "Redefine clauses: "
			-- Redefine clauses label text
		indexing
			external_name: "RedefineClausesText"
		end

	Rename_clause_text: STRING is "Rename clause: "
			-- Rename clause label text
		indexing
			external_name: "RenameClauseText"
		end

	Undefine_clause_text: STRING is "Undefine clause: "
			-- Undefine clause label text
		indexing
			external_name: "UndefineClauseText"
		end
		
	Redefine_clause_text: STRING is "Redefine clause: "
			-- Redefine clause label text
		indexing
			external_name: "RedefineClauseText"
		end
		
	List_view_border_style: INTEGER is 1
			-- List view border style
		indexing
			external_name: "ListViewBorderStyle"
		end
	
	New_clause: STRING is "-- New clause"
			-- New clause
		indexing
			external_name: "NewClause"
		end
	
	As_keyword: STRING is "as"
			-- As keyword
		indexing
			external_name: "AsKeyword"
		end
	
	Undefine_keyword: STRING is "undefine"
			-- Undefine keyword
		indexing
			external_name: "UndefineKeyword"
		end

	Redefine_keyword: STRING is "redefine"
			-- Redefine keyword
		indexing
			external_name: "UndefineKeyword"
		end

	Rename_box_width: INTEGER is
			-- Rename box width
		indexing
			external_name: "RenameBoxWidth"
		require
			non_void_as_label: as_label /= Void
		once
			Result := (Window_width - 2 * Left_margin - 2 * Middle_margin - as_label.width) // 2
		end

feature -- Status Report

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
			a_rename_clause := a_source
			a_rename_clause := a_rename_clause.concat_string_string_string_string (a_rename_clause, Space, As_keyword, Space)
			a_rename_clause := a_rename_clause.concat_string_string (a_rename_clause, a_target)
			list_items := undefine_list_view.items
			from
			until
				i = list_items.count or Result
			loop
				Result := list_items.item (i).text.equals (a_rename_clause)
				i := i + 1
			end
		end	
		
	has_undefine (a_feature_name: STRING): BOOLEAN is
			-- Is `a_feature_name' already in undefine clauses?
		indexing
			external_name: "HasUndefine"
		require
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
		local
			list_items: LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
			i: INTEGER
		do
			list_items := undefine_list_view.items
			from
			until
				i = list_items.count or Result
			loop
				Result := list_items.item (i).text.equals (a_feature_name)
				i := i + 1
			end
		end	
		
	has_redefine (a_feature_name: STRING): BOOLEAN is
			-- Is `a_feature_name' already in redefine clauses?
		indexing
			external_name: "HasRedefine"
		require
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
		local
			list_items: LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
			i: INTEGER
		do
			list_items := redefine_list_view.items
			from
			until
				i = list_items.count or Result
			loop
				Result := list_items.item (i).text.equals (a_feature_name)
				i := i + 1
			end
		end		

feature -- Basic Operations

	build_inheritance_clauses is
			-- Build `rename_clauses', `undefine_clauses' and `redefine_clauses'.
		indexing
			external_name: "BuildInheritanceClauses"
		local
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
			renames: SYSTEM_COLLECTIONS_ARRAYLIST
			undefines: SYSTEM_COLLECTIONS_ARRAYLIST
			redefines: SYSTEM_COLLECTIONS_ARRAYLIST
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
							as_index := a_rename_clause.indexof_string_int32 (As_keyword, 0)
							if as_index /= 0 then
								source := a_rename_clause.substring_int32_int32 (0, as_index - 1)
								target := a_rename_clause.substring (as_index + As_keyword.length + 1)
								create rename_clause.make (source, target)
								added := a_list.add (rename_clause)
							end
						end
						i := i + 1
					end
					create rename_clauses.make (a_list)
					
					undefines := inheritance_clauses.item (1)
					build_clauses (undefines, Undefine_keyword)
					
					redefines := inheritance_clauses.item (2)
					build_clauses (redefines, Redefine_keyword)
				end	
			end
			rename_clauses.set_add_agent (Current)
			undefine_clauses.set_add_agent (Current)
			redefine_clauses.set_add_agent (Current)

			rename_clauses.set_remove_agent (Current)
			undefine_clauses.set_remove_agent (Current)
			redefine_clauses.set_remove_agent (Current)

			rename_clauses.set_remove_all_agent (Current)
			undefine_clauses.set_remove_all_agent (Current)
			redefine_clauses.set_remove_all_agent (Current)
		end
		
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
			class_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		do
			set_Enabled (True)
			set_text (Title)
			set_borderstyle (Border_style)
			a_size.set_Width (Window_width)
			a_size.set_Height (Window_height)
			set_size (a_size)

				-- `Class: '
			create class_label.make_label
			class_label.set_text (Class_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin)
			class_label.set_location (a_point)
			class_label.set_autosize (True)
			create label_font.make_font_10 (Font_family_name, Label_font_size,  Bold_style) 
			class_label.set_font (label_font)
			
				-- Class name (editable)
			create class_name_text_box.make_textbox
			a_point.set_X (Left_margin + class_label.width)
			a_point.set_Y (Top_margin)
			class_name_text_box.set_location (a_point)
			class_name_text_box.set_text (eiffel_class.eiffelname.toupper)
			a_size.set_height (Label_height)
			a_size.set_width (Window_width - 2 * Left_margin - class_label.width)
			class_name_text_box.set_size (a_size)
			class_name_text_box.set_borderstyle (0)
			class_name_text_box.set_textalign (0)
			create a_font.make_font_10 (Font_family_name, Label_font_size, Italic_style)
			class_name_text_box.set_font (a_font)	
			
				-- External name
			create external_name_label.make_label
			external_name_text := Opening_bracket
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, External_name_keyword, Colon, Space)
			external_name_text := external_name_text.concat_string_string_string_string (external_name_text, Inverted_comma, eiffel_class.dotnetfullname, Inverted_comma)
			external_name_text := external_name_text.concat_string_string (external_name_text, Closing_bracket)
			external_name_label.set_text (external_name_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin + Label_height)
			external_name_label.set_location (a_point)			
			a_size.set_width (Window_width - 2 * Left_margin)
			a_size.set_height (Label_height)
			external_name_label.set_size (a_size)
			create a_font.make_font_10 (Font_family_name, Font_size,  Bold_style) 
			external_name_label.set_font (a_font)
			
				-- `Parent: '
			create parent_label.make_label
			parent_label.set_text (Parent_label_text)
			a_point.set_X (Left_margin)
			a_point.set_Y (Top_margin + 2 * Label_height)
			parent_label.set_location (a_point)
			parent_label.set_autosize (True)
			parent_label.set_font (label_font)

			create parent_name_label.make_label
			a_point.set_X (Left_margin + parent_label.width)
			a_point.set_Y (Top_margin + 2 * Label_height)
			parent_name_label.set_location (a_point)			
			a_size.set_width (Window_width - 2 * Left_margin - parent_label.width)
			a_size.set_height (Label_height)
			parent_name_label.set_size (a_size)
			parent_name_label.set_text (parent_name)
			parent_name_label.set_font (Label_font)
			
				-- Main panel
			create panel.make_panel
			a_point.set_x (0)
			a_point.set_y (2 * Top_margin + 3 * Label_height)
			panel.set_location (a_point)
			a_size.set_width (Window_width)
			a_size.set_height (Window_height - 8 * Top_margin - 3 * Label_height - Button_height)
			panel.set_size (a_size)
			panel.set_borderstyle (Panel_border_style)
			
				-- Inheritance clauses list
			create_list_view (rename_clauses, Left_margin, Top_margin + Label_height)
			rename_list_view := created_list
			rename_list_view.items.item (0).set_selected (True)
			rename_list_view.items.item (0).set_checked (True)
			create_list_view (undefine_clauses, Left_margin + Middle_margin + List_width, Top_margin + Label_height)			
			undefine_list_view := created_list
			create_list_view (redefine_clauses, Left_margin + 2 * Middle_margin + 2 * List_width, Top_margin + Label_height)			
			redefine_list_view := created_list
			
				-- Inheritance clauses label
			create_label (Rename_clauses_text, Left_margin, Top_margin)
			create_label (Undefine_clauses_text, Left_margin + Middle_margin + List_width, Top_margin)
			create_label (Redefine_clauses_text, 2 * Left_margin + 2 * Middle_margin + 2 * List_width, Top_margin)

				-- Text box for inheritance clause
			create_label (Rename_clause_text, Left_margin, 3 * Top_margin + Label_height + List_height)
			inheritance_clause_label := created_label
			display_rename_text_boxes
				
				-- Add button
			create add_button.make_button
			a_point.set_X (Left_margin) 
			a_point.set_Y (4 * Top_margin + 3 * Label_height + List_height)
			add_button.set_location (a_point)
			add_button.set_text (Add_button_label)
			type := type_factory.GetType_String (System_event_handler_type)
			on_add_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnAddEventHandler")
			add_button.add_Click (on_add_event_handler_delegate)
			panel.controls.add (add_button)
			
				-- Remove button
			create remove_button.make_button
			a_point.set_X (Window_width - 2 * Left_margin - Button_width - Large_button_width) 
			a_point.set_Y (4 * Top_margin + 3 * Label_height + List_height)
			remove_button.set_location (a_point)
			remove_button.set_text (Remove_button_label)
			on_remove_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnRemoveEventHandler")
			remove_button.add_Click (on_remove_event_handler_delegate)
			panel.controls.add (remove_button)

				-- Remove all button
			create remove_all_button.make_button
			a_point.set_X (Window_width - Left_margin - Large_button_width) 
			a_point.set_Y (4 * Top_margin + 3 * Label_height + List_height)
			remove_all_button.set_location (a_point)
			a_size.set_width (Large_button_width)
			a_size.set_height (Button_height)
			remove_all_button.set_size (a_size)
			remove_all_button.set_text (Remove_all_button_label)
			on_remove_all_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnRemoveAllEventHandler")
			remove_all_button.add_Click (on_remove_all_event_handler_delegate)
			panel.controls.add (remove_all_button)
			
				-- OK button			
			create ok_button.make_button
			a_point.set_X ((Window_width // 2) - (Left_margin //2) - Button_width) 
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			ok_button.set_location (a_point)
			ok_button.set_text (Ok_button_label)
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnOkEventHandler")
			ok_button.add_Click (on_ok_event_handler_delegate)
			
				-- Cancel button
			create cancel_button.make_button
			a_point.set_X ((Window_width // 2) + (Left_margin //2))
			a_point.set_Y (Window_height - 4 * Top_margin - Button_height)
			cancel_button.set_location (a_point)
			cancel_button.set_text (Cancel_button_label)
			on_cancel_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnCancelEventHandler")
			cancel_button.add_Click (on_cancel_event_handler_delegate)
			
				-- Addition of controls
			controls.add (class_label)
			controls.add (class_name_text_box)
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
			new_rename: RENAME_CLAUSE
			new_undefine: UNDEFINE_CLAUSE
			new_redefine: REDEFINE_CLAUSE
		do
			if rename_list_view.selecteditems.count > 0 then
				if rename_source_text_box.text /= Void and rename_target_text_box.text /= Void then
					if rename_source_text_box.text.length > 0 and rename_target_text_box.text.length > 0 and not has_rename (rename_source_text_box.text, rename_target_text_box.text) then
						create new_rename.make (rename_source_text_box.text, rename_target_text_box.text)
						rename_clauses.add (new_rename)
					elseif has_rename (rename_source_text_box.text, rename_target_text_box.text) then
						rename_source_text_box.clear
						rename_target_text_box.clear
					end
				end				
			elseif undefine_list_view.selecteditems.count > 0 then
				if inheritance_clause_text_box.text /= Void then
					if inheritance_clause_text_box.text.length > 0 and not has_undefine (inheritance_clause_text_box.text)  then
						create new_undefine.make (inheritance_clause_text_box.text)
						undefine_clauses.add (new_undefine)
					elseif has_undefine (inheritance_clause_text_box.text) then
						inheritance_clause_text_box.clear
					end
				end		
			elseif redefine_list_view.selecteditems.count > 0 and not has_redefine (inheritance_clause_text_box.text) then
				if inheritance_clause_text_box.text /= Void then
					if inheritance_clause_text_box.text.length > 0 then
						create new_redefine.make (inheritance_clause_text_box.text)
						redefine_clauses.add (new_redefine)
					elseif has_redefine (inheritance_clause_text_box.text) then
						inheritance_clause_text_box.clear
					end
				end	
			end
		end

	on_remove_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `remove_button' activation.
		indexing
			external_name: "OnRemoveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			old_rename: RENAME_CLAUSE
			old_undefine: UNDEFINE_CLAUSE
			old_redefine: REDEFINE_CLAUSE
		do
			if rename_list_view.selecteditems.count > 0 then
				if rename_source_text_box.text /= Void and rename_target_text_box.text /= Void then
					if rename_source_text_box.text.length > 0 and rename_target_text_box.text.length > 0 then
						create old_rename.make (rename_source_text_box.text, rename_target_text_box.text)
						rename_clauses.remove (old_rename)
					end
				end				
			elseif undefine_list_view.selecteditems.count > 0 then
				if inheritance_clause_text_box.text /= Void then
					if inheritance_clause_text_box.text.length > 0 then
						create old_undefine.make (inheritance_clause_text_box.text)
						undefine_clauses.remove (old_undefine)
					end
				end		
			elseif redefine_list_view.selecteditems.count > 0 then
				if inheritance_clause_text_box.text /= Void then
					if inheritance_clause_text_box.text.length > 0 then
						create old_redefine.make (inheritance_clause_text_box.text)
						redefine_clauses.remove (old_redefine)
					end
				end	
			end
		end

	on_remove_all_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process `remove_all_button' activation.
		indexing
			external_name: "OnRemoveAllEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			if rename_list_view.selecteditems.count > 0 then
				rename_clauses.remove_all	
			elseif undefine_list_view.selecteditems.count > 0 then
				undefine_clauses.remove_all		
			elseif redefine_list_view.selecteditems.count > 0 then
				redefine_clauses.remove_all		
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
			as_index: INTEGER
			source: STRING
			target: STRING
			item_text: STRING
		do
			if rename_list_view.focused then
				undefine_list_view.selecteditems.clear
				redefine_list_view.selecteditems.clear
				if panel.controls.contains (inheritance_clause_text_box) then
					panel.controls.remove (inheritance_clause_text_box)
				end
				if rename_source_text_box = Void or not panel.controls.contains (rename_source_text_box) then
					display_rename_text_boxes
				end
				selected_items := rename_list_view.selecteditems
				if selected_items.count = 1 then
					inheritance_clause_label.set_text (Rename_clause_text)
					from
					until
						i = selected_items.count
					loop
						an_item := selected_items.item (i)
						item_text := an_item.text
						if item_text /= Void then
							if item_text.length > 0 and not item_text.equals (New_clause) then
								as_index := item_text.indexof_string_int32 (As_keyword, 0)
								if as_index /= 0 then
									source := item_text.substring_int32_int32 (0, as_index - 1)
									target := item_text.substring (as_index + As_keyword.length + 1)								
									rename_source_text_box.set_text (source)									
									rename_target_text_box.set_text (target)
									panel.refresh
								end
							elseif item_text.equals (New_clause) and rename_source_text_box.text /= Void then
								if rename_source_text_box.text.length > 0 then
									rename_source_text_box.clear
									rename_target_text_box.clear
									panel.refresh
								end							
							end
						end
						i := i + 1
					end
				end
			elseif undefine_list_view.focused then
				rename_list_view.selecteditems.clear
				redefine_list_view.selecteditems.clear				
				if panel.controls.contains (rename_source_text_box) then
					panel.controls.remove (rename_source_text_box)
					panel.controls.remove (as_label)
					panel.controls.remove (rename_target_text_box)
					panel.refresh
				end
				if inheritance_clause_text_box = Void or not panel.controls.contains (inheritance_clause_text_box) then
					display_inheritance_clause_text_box
				end
				selected_items := undefine_list_view.selecteditems
				if selected_items.count = 1 then
					inheritance_clause_label.set_text (Undefine_clause_text)
					display_item (selected_items)
				end
			elseif redefine_list_view.focused then
				rename_list_view.selecteditems.clear
				undefine_list_view.selecteditems.clear
				if panel.controls.contains (rename_source_text_box) then
					panel.controls.remove (rename_source_text_box)
					panel.controls.remove (as_label)
					panel.controls.remove (rename_target_text_box)
					panel.refresh
				end
				if inheritance_clause_text_box = Void or not panel.controls.contains (inheritance_clause_text_box) then
					display_inheritance_clause_text_box
				end
				selected_items := redefine_list_view.selecteditems
				if selected_items.count = 1 then
					inheritance_clause_label.set_text (Redefine_clause_text)
					display_item (selected_items)
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
			console.writeline_string ("ok pressed: will save changes")
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

	update_add (a_clause: INHERITANCE_CLAUSE) is
			-- Add `a_clause' in the list view of current inheritance clauses.
		indexing
			external_name: "UpdateAdd"
		require
			non_void_clause: a_clause /= Void
		local
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			rename_clause: RENAME_CLAUSE
			undefine_clause: UNDEFINE_CLAUSE
			redefine_clause: REDEFINE_CLAUSE
			a_new_clause: STRING
		do
			rename_clause ?= a_clause
			if rename_clause /= Void then
				a_new_clause := rename_clause.source
				a_new_clause := a_new_clause.concat_string_string_string_string (a_new_clause, Space, As_keyword, Space)
				a_new_clause := a_new_clause.concat_string_string (a_new_clause, rename_clause.target)
				create list_view_item.make_1 (a_new_clause)
				list_view_item := rename_list_view.items.add (list_view_item)
				rename_table.add (a_new_clause, list_view_item)
				rename_source_text_box.clear
				rename_target_text_box.clear
			end
			undefine_clause ?= a_clause
			if undefine_clause /= Void then
				create list_view_item.make_1 (undefine_clause.feature_name)
				list_view_item := undefine_list_view.items.add (list_view_item)
				undefine_table.add (undefine_clause.feature_name, list_view_item)
				inheritance_clause_text_box.clear
			end
			redefine_clause ?= a_clause
			if redefine_clause /= Void then
				create list_view_item.make_1 (redefine_clause.feature_name)
				list_view_item := redefine_list_view.items.add (list_view_item)
				redefine_table.add (redefine_clause.feature_name, list_view_item)
				inheritance_clause_text_box.clear
			end
			panel.refresh
		end

	update_remove (a_clause: INHERITANCE_CLAUSE) is
			-- Remove `a_clause' from the list view of current inheritance clauses.
		indexing
			external_name: "UpdateRemove"
		require
			non_void_clause: a_clause /= Void
		local
			rename_clause: RENAME_CLAUSE
			undefine_clause: UNDEFINE_CLAUSE
			redefine_clause: REDEFINE_CLAUSE
			an_old_clause: STRING
			an_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		do
			rename_clause ?= a_clause
			if rename_clause /= Void then
				an_old_clause := rename_clause.source
				an_old_clause := an_old_clause.concat_string_string_string_string (an_old_clause, Space, As_keyword, Space)
				an_old_clause := an_old_clause.concat_string_string (an_old_clause, rename_clause.target)
				if rename_table.contains (an_old_clause) then
					an_item ?= rename_table.item (an_old_clause)
					rename_list_view.items.remove (an_item)
					rename_table.remove (an_old_clause)
					rename_source_text_box.clear
					rename_target_text_box.clear
				end
			end
			undefine_clause ?= a_clause
			if undefine_clause /= Void then
				if undefine_table.contains (undefine_clause.feature_name) then
					an_item ?= undefine_table.item (undefine_clause.feature_name)
					undefine_list_view.items.remove (an_item)
					undefine_table.remove (undefine_clause.feature_name)
					inheritance_clause_text_box.clear
				end
			end
			redefine_clause ?= a_clause
			if redefine_clause /= Void then
				if redefine_table.contains (redefine_clause.feature_name) then
					an_item ?= redefine_table.item (redefine_clause.feature_name)
					redefine_list_view.items.remove (an_item)
					redefine_table.remove (redefine_clause.feature_name)
					inheritance_clause_text_box.clear
				end
			end
			panel.refresh
		end

	update_remove_all is
			-- Remove all clauses from the list view of current inheritance clauses.
		indexing
			external_name: "UpdateRemoveAll"
		local
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		do
			if rename_list_view.selecteditems.count > 0 then
				rename_list_view.clear
				rename_table.clear
				rename_source_text_box.clear
				rename_target_text_box.clear
				create list_view_item.make_1 (New_clause)
				list_view_item := rename_list_view.items.add (list_view_item)
			elseif undefine_list_view.selecteditems.count > 0 then
				undefine_list_view.clear
				undefine_table.clear
				inheritance_clause_text_box.clear	
				create list_view_item.make_1 (New_clause)
				list_view_item := undefine_list_view.items.add (list_view_item)
			elseif redefine_list_view.selecteditems.count > 0 then
				redefine_list_view.clear
				redefine_table.clear
				inheritance_clause_text_box.clear	
				create list_view_item.make_1 (New_clause)
				list_view_item := redefine_list_view.items.add (list_view_item)
			end
			
			panel.refresh
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
			create a_font.make_font_10 (Font_family_name, Font_size, Bold_style)
			a_label.set_font (a_font)
			panel.controls.add (a_label)
			created_label := a_label
		end
	
	create_list_view (clauses: INHERITANCE_CLAUSES; x_position, y_position: INTEGER) is
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
			undefine_clause: UNDEFINE_CLAUSE
			redefine_clause: REDEFINE_CLAUSE
		do
			create list_view.make_listview
			list_view.set_borderstyle (List_view_border_style)
			list_view.set_checkboxes (False)
			list_view.set_fullrowselect (True)
			list_view.set_gridlines (False)
			list_view.set_multiselect (False)
			list_view.set_sorting (0)
			list_view.set_view (3)
			list_view.set_activation (0)
			list_view.set_alignment (5)
			list_view.set_scrollable (True)
			list_view.set_tabindex (0)
			
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			list_view.set_location (a_point)
			a_size.set_width (List_width)
			a_size.set_height (List_height)
			list_view.set_size (a_size)	
			create list_view_item.make_1 (New_clause)
			list_view_item := list_view.items.add (list_view_item)
			a_list := clauses.inheritance_clauses
			from
			until
				i = a_list.count
			loop
				rename_clause ?= a_list.item (i)
				if rename_clause /= Void then
					clause_text := rename_clause.source
					clause_text := clause_text.concat_string_string_string_string (clause_text, Space, As_keyword, Space)
					clause_text := clause_text.concat_string_string (clause_text, rename_clause.target)
					create list_view_item.make_1 (clause_text)
					rename_table.add (clause_text, list_view_item)
				end
				undefine_clause ?= a_list.item (i)
				if undefine_clause /= Void then
					create list_view_item.make_1 (undefine_clause.feature_name)
					undefine_table.add (undefine_clause.feature_name, list_view_item)
				end
				redefine_clause ?= a_list.item (i)
				if redefine_clause /= Void then
					create list_view_item.make_1 (redefine_clause.feature_name)
					redefine_table.add (redefine_clause.feature_name, list_view_item)
				end
				list_view_item := list_view.items.add (list_view_item)
				i := i + 1
			end
			type := type_factory.GetType_String (System_event_handler_type)
			on_item_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnItemEventHandler")
			list_view.add_Click (on_item_event_handler_delegate)		
			panel.controls.add (list_view)
			created_list := list_view
		end
	
	build_clauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST; type: STRING) is
			-- Build `undefine_clauses'' or `redefine_clauses' from `clauses' depending on `type'.
		indexing
			external_name: "BuildClauses"
		require
			non_void_clauses: clauses /= Void
			non_void_type: type /= Void
			not_empty_type: type.length > 0
			valid_type: type.equals (Undefine_keyword) or type.equals (Redefine_keyword)
		local
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_clause: STRING
			added: INTEGER
			undefine_clause: UNDEFINE_CLAUSE
			redefine_clause: REDEFINE_CLAUSE
		do
			from
				create a_list.make
				i := 0
			until
				i = clauses.count
			loop
				a_clause ?= clauses.item (i)
				if a_clause /= Void then
					if type.equals (Undefine_keyword) then
						create undefine_clause.make (a_clause)
						added := a_list.add (undefine_clause)
					elseif type.equals (Redefine_keyword) then
						create redefine_clause.make (a_clause)
						added := a_list.add (redefine_clause)
					end
				end
				i := i + 1
			end
			if type.equals (Undefine_keyword) then
				create undefine_clauses.make (a_list)
			elseif type.equals (Redefine_keyword) then
				create redefine_clauses.make (a_list)
			end
		end
	
	display_item (selected_items: SELECTEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW) is
			-- Display the item of `selected_items' (there is only one) in `inheritance_clause_text_box'.
		indexing
			external_name: "DisplayItem"
		require
			non_void_items: selected_items /= Void
			only_one_selected_item: selected_items.count = 1
		local
			i: INTEGER
			an_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
		do
			from
			until
				i = selected_items.count
			loop
				an_item := selected_items.item (i)
				if an_item.text /= Void then
					if an_item.text.length > 0 and not an_item.text.equals (New_clause) then
						inheritance_clause_text_box.set_text (an_item.text)
						panel.refresh
					elseif an_item.text.equals (New_clause) and inheritance_clause_text_box.text /= Void then
						if inheritance_clause_text_box.text.length > 0 then
							inheritance_clause_text_box.clear
							panel.refresh
						end
					end
				end
				i := i + 1
			end
		end
	
	display_inheritance_clause_text_box is
			-- Display `inheritance_clause_text_box'.
		indexing
			external_name: "DisplayInheritanceClauseTextBox"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT			
		do
			create inheritance_clause_text_box.make_textbox
			a_point.set_x (Left_margin)
			a_point.set_y (3 * Top_margin + 2 * Label_height + List_height)
			inheritance_clause_text_box.set_location (a_point)
			a_size.set_width (Window_width - 2 * Left_margin)
			a_size.set_height (Label_height)
			inheritance_clause_text_box.set_size (a_size)
			panel.controls.add (inheritance_clause_text_box)		
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
			tmp_label.set_text (As_keyword)
			as_label_width := tmp_label.width
			
			create_label (As_keyword, Window_width // 2 - as_label_width //2, 3 * Top_margin + 2 * Label_height + List_height)
			as_label := created_label
			
			create rename_source_text_box.make_textbox
			a_point.set_x (Left_margin)
			a_point.set_y (3 * Top_margin + 2 * Label_height + List_height)
			rename_source_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			a_size.set_height (Label_height)
			rename_source_text_box.set_size (a_size)
			panel.controls.add (rename_source_text_box)	

			create rename_target_text_box.make_textbox			
			a_point.set_x (Left_margin + created_label.width + Rename_box_width + 2 * Middle_margin)
			a_point.set_y (3 * Top_margin + 2 * Label_height + List_height)
			rename_target_text_box.set_location (a_point)
			a_size.set_width (Rename_box_width)
			a_size.set_height (Label_height)
			rename_target_text_box.set_size (a_size)
			panel.controls.add (rename_target_text_box)	
		end
		
end -- class INHERITANCE_CLAUSES_VIEWER
