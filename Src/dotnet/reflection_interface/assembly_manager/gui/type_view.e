indexing
	description: "List the features of currently selected type."
	external_name: "ISE.AssemblyManager.TypeView"

class
	TYPE_VIEW

inherit
	DIALOG
		redefine
			dictionary
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; an_eiffel_class: like eiffel_class; children_list: like children; an_assembly_view: like assembly_view) is
		indexing
			description: "[
						Set `assembly_descriptor' with `an_assembly_descriptor'.
						Set `eiffel_class' with `an_eiffel_class'.
						Set `assembly_view' with `an_assembly_view'.
					  ]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.count > 0
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_name: an_eiffel_class.eiffel_name /= Void
			not_empty_eiffel_name: an_eiffel_class.eiffel_name.count > 0
			non_void_children_list: children_list /= Void
			non_void_assembly_view: an_assembly_view /= Void
		local
			return_value: WINFORMS_DIALOG_RESULT
		do
			create main_win.make_winforms_form
			assembly_descriptor := an_assembly_descriptor
			eiffel_class := an_eiffel_class
			children := children_list
			assembly_view := an_assembly_view
			eiffel_dictionary := create {EIFFEL_CODE_GENERATOR_DICTIONARY}
			create type_modifications.make_from_info ( from_reflection_string (eiffel_class.eiffel_name) )
			initialize_gui
			return_value := main_win.show_dialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			eiffel_class_set: eiffel_class = an_eiffel_class
			assembly_view_set: assembly_view = an_assembly_view
			non_void_type_modifications: type_modifications /= Void
		end

feature -- Access
		
	dictionary: TYPE_VIEW_DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end
		
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class"
			external_name: "EiffelClass"
		end
		
	children: LINKED_LIST [EIFFEL_CLASS] 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Children of `eiffel_class'"
			external_name: "Children"
		end
	
	assembly_view: ASSEMBLY_VIEW
		indexing
			description: "Assembly view"
			external_name: "AssemblyView"
		end
		
	assembly_types: LINKED_LIST [EIFFEL_CLASS]  is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Assembly types"
			external_name: "AssemblyTypes"
		require
			non_void_assembly_view: assembly_view /= Void
		do
			Result := assembly_view.type_list
		ensure
			assembly_types_created: Result /= Void
		end
	
	eiffel_path: STRING is 
		indexing
			description: "Path to Eiffel sources"
			external_name: "EiffelPath"
		require
			non_void_assembly_view: assembly_view /= Void
			non_void_assembly: assembly_view.assembly /= Void
		once
			Result := assembly_view.assembly.eiffel_cluster_path
		ensure
			non_void_path: Result /= Void 
			not_empty_path: Result.count > 0
		end
		
	eiffel_dictionary: EIFFEL_CODE_GENERATOR_DICTIONARY
		indexing
			description: "Eiffel dictionary"
			external_name: "EiffelDictionary"
		end
		
	ok_button: WINFORMS_BUTTON
		indexing
			description: "OK button"
			external_name: "OkButton"
		end

	cancel_button: WINFORMS_BUTTON
		indexing
			description: "Cancel button"
			external_name: "CancelButton"
		end

	panel: WINFORMS_PANEL
		indexing
			description: "Panel with class contract form"
			external_name: "Panel"
		end

	class_name_text_box: WINFORMS_TEXT_BOX
		indexing
			description: "Class name text box"
			external_name: "ClassNameTextBox"
		end

	end_class_name_label: WINFORMS_LABEL
		indexing
			description: "Class name label"
			external_name: "EndClassNameLabel"
		end
	
	label_width: INTEGER 
		indexing
			description: "Width of label created by `create_label'"
			external_name: "LabelWidth"
		end

	created_label: WINFORMS_LABEL
		indexing
			description: "Label created by `create_label'"
			external_name: "CreatedLabel"
		end
		
feature -- Basic Operations

	initialize_gui is
		indexing
			description: "Initialize GUI."
			external_name: "InitializeGUI"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			label_font: DRAWING_FONT
			on_ok_delegate: EVENT_HANDLER
			on_cancel_delegate: EVENT_HANDLER
			on_resize_delegate: EVENT_HANDLER
			retried: BOOLEAN
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX	
		do
			main_win.set_Enabled (True)
			main_win.set_text (dictionary.Title.to_cil)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			main_win.set_size (a_size)
			if not retried then
				main_win.set_icon (dictionary.Edit_icon)
			else
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (dictionary.Pixmap_not_found_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end			
				-- `Selected assembly: '
			create_form_label (from_reflection_string (assembly_descriptor.name), dictionary.Margin, dictionary.Margin)
			create_assembly_labels
				
				-- Build editable class
			build_class_contract_form (eiffel_class)
			a_size.set_width (main_win.get_width - dictionary.Margin // 2)
			a_size.set_height (dictionary.Window_height - 6 * dictionary.Margin - 5 * dictionary.Label_height - dictionary.Button_height)
			panel.set_size (a_size)
			
				-- OK button
			create ok_button.make_winforms_button
			a_point.set_X (main_win.get_width // 2 - (dictionary.Margin // 2) - dictionary.Button_width) 
			a_point.set_Y (main_win.get_height - 3 * dictionary.Margin - dictionary.Button_height)
			ok_button.set_location (a_point)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			ok_button.set_text (dictionary.Ok_button_label.to_cil)
			create on_ok_delegate.make_event_handler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_delegate)

				-- Cancel button
			create cancel_button.make_winforms_button
			a_point.set_X (main_win.get_width // 2 + dictionary.Margin // 2)
			a_point.set_Y (main_win.get_height - 3 * dictionary.Margin - dictionary.Button_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label.to_cil)
			create on_cancel_delegate.make_event_handler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_delegate)
			
				-- Addition of get_controls
			main_win.get_controls.add (ok_button)		
			main_win.get_controls.add (cancel_button)

			main_win.add_closed (on_cancel_delegate)
			create on_resize_delegate.make_event_handler (Current, $on_resize_action)
			main_win.add_resize (on_resize_delegate)
		rescue
			retried := True
			retry
		end

feature -- Event handling

	on_resize_action (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Resize window and its content."
			external_name: "OnResizeAction"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
		do
				-- Resize `panel'.
			a_size.set_width (main_win.get_width - dictionary.Margin // 2)
			if errors_list_view /= Void and then main_win.get_controls.contains (errors_list_view) then
				a_size.set_height (main_win.get_height - 6 * dictionary.Margin - 7 * dictionary.Label_height - dictionary.Button_height)
			else
				a_size.set_height (main_win.get_height - 6 * dictionary.Margin - 5 * dictionary.Label_height - dictionary.Button_height)
			end
			panel.set_Size (a_size)	
			
				-- Move `ok_button' and `cancel_button'.
			a_point.set_X (main_win.get_width // 2 - (dictionary.Margin // 2) - dictionary.Button_width) 
			a_point.set_Y (main_win.get_height - 3 * dictionary.Margin - dictionary.Button_height)
			ok_button.set_location (a_point)
			a_point.set_X (main_win.get_width // 2 + dictionary.Margin // 2)
			a_point.set_Y (main_win.get_height - 3 * dictionary.Margin - dictionary.Button_height)
			cancel_button.set_location (a_point)
			
				-- Resize and move `errors_list_view' if non Void
			if errors_list_view /= Void and then main_win.get_controls.contains (errors_list_view) then
				a_point.set_X (0)
				a_point.set_Y (main_win.get_height - 5 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)	
				errors_list_view.set_location (a_point)	
				a_size.set_width (main_win.get_width - dictionary.Margin // 2)
				a_size.set_height (4 * dictionary.Label_height)
				errors_list_view.set_size (a_size)	
			end
			main_win.refresh
		end
		
	on_click_action (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Action launched when a text box is entered"
			external_name: "OnClickAction"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			a_font: DRAWING_FONT
			font_style: DRAWING_FONT_STYLE
			name: STRING
			selected_text: STRING
		do
			if selected_text_box /= Void and then selected_text_box.get_text /= Void then
				if selected_text_box = class_name_text_box then
					name := type_modifications.old_name.clone(type_modifications.old_name)
					name.to_lower
					selected_text := from_system_string (selected_text_box.get_text)
					selected_text.to_lower
					if type_modifications.old_name /= Void and then not name.is_equal (selected_text) then
						type_modifications.set_new_name ( from_system_string (selected_text_box.get_text) )
						if selected_text_box.get_text.get_length > 0 then
							create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, font_style.Italic)
							selected_text_box.set_width (text_box_width_from_text ( from_system_string (selected_text_box.get_text), a_font))
						end
					end
				else
					save_feature_modifications (selected_text_box)
				end
			end
		end
		
	on_enter_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Action launched when a text box is entered"
			external_name: "OnEnterEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			is_focused: BOOLEAN
			an_array: ARRAY [ANY]
		do
			feature_modifications := Void
			selected_text_box ?= sender
			if selected_text_box /= Void and then selected_text_box.get_text /= Void then
				if selected_text_box = class_name_text_box then
					type_modifications.set_old_name ( from_system_string (selected_text_box.get_text))
				else
					if feature_names_boxes.has (selected_text_box.get_hash_code) then
						modified_feature ?= feature_names_boxes.item (selected_text_box.get_hash_code)
						create feature_modifications.make_from_info ( from_system_string (selected_text_box.get_text))	
						
					elseif feature_arguments_boxes.has (selected_text_box.get_hash_code) then
						an_array ?= feature_arguments_boxes.item (selected_text_box.get_hash_code)
						if an_array /= Void and then an_array.count = 2 then
							modified_feature ?= an_array.item (0)
							if modified_feature /= Void then
								if type_modifications.features_modifications.has (modified_feature) then
									feature_modifications ?= type_modifications.features_modifications.item (modified_feature)
								else
									create feature_modifications.make_from_info ( from_reflection_string (modified_feature.eiffel_name))
								end
							end									
						end							
					end
				end
			end
		end

	on_leave_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Action launched when a text box is leaved"
			external_name: "OnLeaveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: WINFORMS_TEXT_BOX
		do
			text_box ?= sender
			if text_box /= Void and then text_box.get_text /= Void then
				save_feature_modifications (text_box)
			end
		end

	on_enter_pressed (sender: SYSTEM_OBJECT; arguments: WINFORMS_KEY_EVENT_ARGS) is
		indexing
			description: "Action launched when user presses `Enter' in a text box"
			external_name: "OnEnterPressed"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: WINFORMS_TEXT_BOX
			keys: WINFORMS_KEYS
		do
			if arguments.get_key_code = keys.enter then
				text_box ?= sender
				if text_box /= Void and then text_box.get_text /= Void then
				 	save_feature_modifications (text_box)
				end
			end
		end
		
	on_ok_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `ok_button' activation."
			external_name: "OnOkEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_eiffel_class: eiffel_class /= Void
		local
			type_view_handler: TYPE_VIEW_HANDLER
			xml_generator: XML_CODE_GENERATOR
			i: INTEGER
			a_child: EIFFEL_CLASS
			a_size: DRAWING_SIZE
			regenerate_eiffel_classes_delegate: EVENT_HANDLER	
			cursors: WINFORMS_CURSORS
			wait_cursor: WINFORMS_CURSOR
			normal_cursor: WINFORMS_CURSOR
			retried: BOOLEAN
			message_box: MESSAGE_BOX
		do
			if not retried then
				wait_cursor := cursors.get_Wait_Cursor
				main_win.set_cursor (wait_cursor)
				create type_view_handler.make (eiffel_class, type_modifications, Current)
				type_view_handler.check_and_update
				normal_cursor := cursors.get_Arrow
				main_win.set_cursor (normal_cursor)
				if not type_view_handler.is_valid then
					cancel_button.set_enabled (False)
					a_size.set_width (main_win.get_width - dictionary.Margin // 2)
					a_size.set_height (main_win.get_height - 6 * dictionary.Margin - 7 * dictionary.Label_height - dictionary.Button_height)
					panel.set_size (a_size)
					if errors_list_view /= Void and then main_win.get_controls.contains (errors_list_view) then
						main_win.get_controls.remove (errors_list_view)
					end
					display_errors (type_view_handler.class_error_message, type_view_handler.errors_in_features, type_view_handler.errors_in_arguments, type_view_handler.errors_in_arguments_mappings)
					main_win.refresh
				else
					main_win.close
					eiffel_class := type_view_handler.eiffel_class
					if eiffel_class.assembly_descriptor = Void then
						eiffel_class.set_assembly_descriptor (assembly_descriptor)
					end
					eiffel_class.set_modified (type_modifications.features_modifications /= Void and then type_modifications.features_modifications.count > 0)
					children := type_view_handler.children
					assembly_view.set_children (eiffel_class, children)
					xml_generator := create {XML_CODE_GENERATOR}.make_xml_code_generator
					xml_generator.replace_type (eiffel_class)
					from
						children.start
					until
						children.after
					loop
						a_child ?= children.item
						if a_child /= Void then
							if a_child.assembly_descriptor = Void then
								a_child.set_assembly_descriptor (assembly_descriptor)
							end
							xml_generator.replace_type (a_child)
						end
						children.forth
					end
					assembly_view.update_gui
					create regenerate_eiffel_classes_delegate.make_event_handler (Current, $regenerate_eiffel_classes)
					create message_box.make (dictionary.Eiffel_generation, regenerate_eiffel_classes_delegate)
				end
			else
				normal_cursor := cursors.get_Arrow
				main_win.set_cursor (normal_cursor)
			end
		end

	regenerate_eiffel_classes (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Open Eiffel generation dialog."
			external_name: "RegenerateEiffelClasses"
		require
			non_void_sender: sender /= Void
		local
			message_box: MESSAGE_BOX
			assembly_filename: STRING
			code_generator_from_xml: EIFFEL_CODE_GENERATOR_FROM_XML
			support: REFLECTION_SUPPORT
			type_filename: STRING
			a_child: EIFFEL_CLASS
			i: INTEGER
			returned_value: WINFORMS_DIALOG_RESULT
			message_box_buttons: WINFORMS_MESSAGE_BOX_BUTTONS
			message_box_icon: WINFORMS_MESSAGE_BOX_ICON 
			windows_message_box: WINFORMS_MESSAGE_BOX	
			eiffel_generation_dictionary: EIFFEL_GENERATION_DIALOG_DICTIONARY
			retried: BOOLEAN
			cursors: WINFORMS_CURSORS
			wait_cursor: WINFORMS_CURSOR
		do
			if not retried then
				message_box ?= sender
				if message_box /= Void then
					wait_cursor := cursors.get_Wait_Cursor
					message_box.main_win.set_cursor (wait_cursor)
					message_box.main_win.refresh
					support := create {REFLECTION_SUPPORT}.make
					assembly_filename := support.Xml_assembly_filename (assembly_descriptor)
					assembly_filename.replace_substring_all ( support.Eiffel_key, support.Eiffel_delivery_path)
					if assembly_filename /= Void and then assembly_filename.count > 0 then
						--code_generator_from_xml := create {EIFFEL_CODE_GENERATOR_FROM_XML}.make1
						create code_generator_from_xml.make_from_info (assembly_filename)
						
						type_filename := support.Xml_type_filename (assembly_descriptor, eiffel_class.full_external_name)
						type_filename.replace_substring_all (support.Eiffel_key, support.Eiffel_delivery_path)
						code_generator_from_xml.generate_eiffel_code_from_xml (type_filename)
						from
							children.start
						until
							children.after
						loop
							a_child ?= children.item
							if a_child /= Void then
								type_filename := support.Xml_type_filename (assembly_descriptor, a_child.full_external_name)
								type_filename.replace_substring_all (support.Eiffel_key, support.Eiffel_delivery_path)
								code_generator_from_xml.generate_eiffel_code_from_xml (type_filename)
							end
							children.forth
						end
					end
					message_box.main_win.close
				end
			else
				message_box ?= sender
				if message_box /= Void then
					message_box.main_win.close
				end
				create eiffel_generation_dictionary
				returned_value := windows_message_box.show_string_string_message_box_buttons_message_box_icon (eiffel_generation_dictionary.Eiffel_generation_error.to_cil, dictionary.Error_caption.to_cil, message_box_buttons.Ok, message_box_icon.Error)
			end
		rescue
			retried := True
			retry
		end
	
	on_cancel_event_handler (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Process `cancel_button' activation."
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			main_win.close
		end
	
feature {NONE} -- Implementation
		
	modified_feature: EIFFEL_FEATURE
		indexing
			description: "Feature being modified by the user"
			external_name: "ModifiedFeature"
		end
	
	type_modifications: TYPE_MODIFICATIONS
		indexing
			description: "Type modifications"
			external_name: "TypeModifications"
		end
	
	feature_modifications: FEATURE_MODIFICATIONS
		indexing
			description: "Feature modifications"
			external_name: "FeatureModifications"
		end
	
	--parents: HASH_TABLE [ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]], STRING]
	parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			-- | Key: parent name
			-- | Value: inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]])
		indexing
			description: "Class parents"
			external_name: "Parents"
		end
	
	selected_text_box: WINFORMS_TEXT_BOX
		indexing
			description: "Lastly selected text box"
			external_name: "SelectedTextBox"
		end

	panel_height: INTEGER
		indexing
			description: "Height of panel inside before calling `build_inherit_clause'"
			external_name: "PanelHeight"
		end

	feature_names_boxes: HASH_TABLE [EIFFEL_FEATURE, INTEGER]
			-- | Key: text box
			-- | Value: `EIFFELFEATURE'
		indexing
			description: "Text boxes for feature names"
			external_name: "FeatureNamesBoxes"
		end

	feature_arguments_boxes: HASH_TABLE [ARRAY[ANY], INTEGER]
			-- | Key: text box
			-- | Value: [EIFFELFEATURE, NAMEDSIGNATURETYPE]
		indexing
			description: "Text boxes for feature arguments"
			external_name: "FeatureArgumentsBoxes"
		end

	generic_type_names: ARRAY [STRING]
		indexing
			description: "Generic type names of current Eiffel class"
			external_name: "GenericTypeNames"
		end
	
	build_class_contract_form (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build editable contract form of `an_eiffel_class'."
			external_name: "BuildClassContractForm"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			a_size: DRAWING_SIZE
			a_position: DRAWING_POINT
			an_external_clause: STRING
			an_external_name: STRING
			formatter: FORMATTER
			end_class: STRING
			external_class: STRING
			on_click_delegate: EVENT_HANDLER
			an_enum_type_clause: STRING
			an_enum_type: STRING
			border_style: WINFORMS_BORDER_STYLE
			new_label_width: INTEGER
			constraints: ARRAY [STRING]
			a_constraint: STRING
			class_name: STRING
			i: INTEGER
			support: CODE_GENERATION_SUPPORT
			a_generic_type_name: STRING
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [STRING]
			class_name_string: STRING
		do
			create panel.make_winforms_panel
			a_position.set_x (0)
			a_position.set_y (dictionary.Margin + 4 * dictionary.Label_height)
			panel.set_location (a_position)
			panel.set_border_style (border_style.none)
			panel.set_back_color (dictionary.White_color)
			panel.set_auto_scroll (True)
			main_win.get_controls.add (panel)
			create on_click_delegate.make_event_handler (Current, $on_click_action)
			panel.add_click (on_click_delegate)
			
				-- Indexing clause
			create_label (eiffel_dictionary.Indexing_keyword, dictionary.Margin, dictionary.Margin, dictionary.Keyword_color, True)	
			
				-- External name
			an_external_clause := eiffel_dictionary.External_name_keyword.clone (eiffel_dictionary.External_name_keyword)
			an_external_clause.append (eiffel_dictionary.Colon)
			create_label (an_external_clause, 3 * dictionary.Margin, dictionary.Margin + dictionary.Label_height, dictionary.Keyword_color, True)
			
			create formatter.make
			an_external_name := eiffel_dictionary.Inverted_comma.clone (eiffel_dictionary.Inverted_comma)
			an_external_name.append (an_eiffel_class.full_external_name)
			an_external_name.append (eiffel_dictionary.Inverted_comma )
			create_label ( from_reflection_string (an_external_name), 3 * dictionary.Margin + label_width, dictionary.Margin + dictionary.Label_height, dictionary.Comment_color, False)
			
			panel_height := dictionary.Margin + 2 * dictionary.Label_height
			
				-- Enum type
			if an_eiffel_class.Enum_Type /= Void and then an_eiffel_class.Enum_Type.count > 0 then
				an_enum_type_clause := eiffel_dictionary.Enum_Type_Keyword.clone (eiffel_dictionary.Enum_Type_Keyword)
				an_enum_type_clause.append (eiffel_dictionary.Colon)
				create_label ( from_reflection_string (an_enum_type_clause), 3 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
				
				an_enum_type := eiffel_dictionary.Inverted_comma.clone (eiffel_dictionary.Inverted_comma)
				an_enum_type.append (an_eiffel_class.Enum_Type)
				an_enum_type.append (eiffel_dictionary.Inverted_comma)
				create_label ( from_reflection_string(an_enum_type), 3 * dictionary.Margin + label_width, panel_height, dictionary.Comment_color, False)
				panel_height := panel_height + dictionary.Label_height
			end
			
			panel_height := panel_height + dictionary.Margin + dictionary.Label_height
			new_label_width := dictionary.Margin
				-- frozen
			if an_eiffel_class.is_Frozen then
				create_label (from_reflection_string (eiffel_dictionary.Frozen_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
			end				
				-- expanded
			if an_eiffel_class.Is_Expanded then
				create_label (from_reflection_string (eiffel_dictionary.Expanded_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
			end
				-- deferred
			if an_eiffel_class.Is_Deferred then
				create_label (from_reflection_string (eiffel_dictionary.Deferred_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
			end
			
				-- external class
				-- 	CLASS_NAME
			if an_eiffel_class.is_frozen or an_eiffel_class.is_deferred or an_eiffel_class.is_expanded then
				external_class := eiffel_dictionary.External_keyword
				external_class.append (eiffel_dictionary.Space)
				external_class.append ( eiffel_dictionary.Class_keyword)
				create_label (from_reflection_string (external_class), new_label_width, panel_height, dictionary.Keyword_color, True)
			else
				create_label (from_reflection_string (eiffel_dictionary.Class_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
			end
			panel_height := panel_height + dictionary.Label_height
			create class_name_text_box.make_winforms_text_box

			class_name := from_reflection_string (an_eiffel_class.eiffel_name.clone (an_eiffel_class.eiffel_name))
			class_name.to_upper
			if an_eiffel_class.is_generic then
				class_name.append (dictionary.Space)
				class_name.append ( from_reflection_string (eiffel_dictionary.Opening_square_bracket))
				constraints := conversion_support.from_array_any (an_eiffel_class.constraints)
				support := create {CODE_GENERATION_SUPPORT}.make
				support.compute_generic_names (constraints.count)
				check
					non_void_generic_type_names: support.generic_type_names /= Void
				end
				generic_type_names := support.generic_type_names
				from
					i := 0
				until
					i = generic_type_names.count
				loop
					a_constraint ?= constraints.item (i)
					if a_constraint /= Void then
						a_generic_type_name ?= generic_type_names.item (i)
						if a_generic_type_name /= Void and then a_generic_type_name.count > 0 then
							class_name.append (a_generic_type_name)
							class_name.append (dictionary.Space)
							class_name.append ("->")
							class_name.append (dictionary.Space)
							class_name.append (a_constraint)
							if i < generic_type_names.count - 1 then
								class_name.append ( from_reflection_string (eiffel_dictionary.Comma))
								class_name.append (dictionary.Space)
							end
						end
					end
					i := i + 1
				end
				class_name.append (dictionary.Space)
				class_name.append ( from_reflection_string (eiffel_dictionary.Closing_square_bracket) )
			end

			create_label (class_name, 3 * dictionary.Margin, panel_height, dictionary.Class_color, False)
						
			panel_height := panel_height + dictionary.Label_height
			
				-- inherit
				-- 	PARENT_NAME
				-- 		rename ... undefine ... redefine ... end
			build_inherit_clause (an_eiffel_class)

			create feature_names_boxes.make (0)
			create feature_arguments_boxes.make (0)
			
				-- `create {NONE}' or `create make ...'
			build_create_clause (an_eiffel_class)
			
				-- Generate class features (except initialization ones).
			build_class_features (an_eiffel_class)

				-- `end -- class CLASS_NAME'
			end_class := eiffel_dictionary.End_keyword.clone (eiffel_dictionary.End_keyword)
			end_class.append (eiffel_dictionary.Space)
			end_class.append (eiffel_dictionary.Dashes)
			end_class.append (eiffel_dictionary.Space)
			end_class.append (eiffel_dictionary.Class_keyword)
			create_label ( from_reflection_string (end_class), dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
			class_name_string := class_name.clone (class_name)
			class_name_string.to_upper
			create_label (class_name, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
			end_class_name_label := created_label
		end
	
	create_label (a_text: STRING; x_position, y_position: INTEGER; a_color: DRAWING_COLOR; is_bold_font: BOOLEAN) is
		indexing
			description: "[
						Create a text box with text `a_text' at position (x_position, y_position).
						Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).
					  ]"
			external_name: "CreateLabel"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			non_void_color: a_color /= Void
		local
			a_label: WINFORMS_LABEL
			a_point: DRAWING_POINT
			a_font: DRAWING_FONT
			style: DRAWING_FONT_STYLE
			border_style: WINFORMS_BORDER_STYLE
			alignment: DRAWING_CONTENT_ALIGNMENT
		do
			create a_label.make_winforms_label
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			a_label.set_location (a_point)
			a_label.set_text (a_text.to_cil)	
			a_label.set_auto_size (True)
			a_label.set_border_style (border_Style.none)
			a_label.set_text_align (alignment.middle_center)
			a_label.set_fore_color (a_color)
			if is_bold_font then 
				create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold)
			else
				create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Regular)
			end
			a_label.set_font (a_font)
			panel.get_controls.add (a_label)
			label_width := a_label.get_width
			created_label := a_label
		end
	
	create_form_label (a_text: STRING; x_position, y_position: INTEGER) is
		indexing
			description: "[
						Create a text box with text `a_text' at position (x_position, y_position).
						Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).
					  ]"
			external_name: "CreateFormLabel"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
		local
			a_label: WINFORMS_LABEL
			a_point: DRAWING_POINT
			a_font: DRAWING_FONT
			style: DRAWING_FONT_STYLE
			border_style: WINFORMS_BORDER_STYLE
			alignment: DRAWING_CONTENT_ALIGNMENT
		do
			create a_label.make_winforms_label
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			a_label.set_location (a_point)
			a_label.set_text (a_text.to_cil)	
			a_label.set_auto_size (True)
			a_label.set_border_style (border_style.none)
			a_label.set_text_align (alignment.middle_left)
			create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Bold)
			a_label.set_font (a_font)
			main_win.get_controls.add (a_label)
		end	
		
	set_editable_text_box_properties (a_text_box: WINFORMS_TEXT_BOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: DRAWING_COLOR) is
		indexing
			description: "[
						Set `a_text_box' position: (x_position, y_position).
						Set `a_text_box' size (a_width, Label_height).
						Set font color with `a_color'.
					  ]"
			external_name: "SetEditableTextBoxProperties"
		require
			non_void_text_box: a_text_box /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			positive_width: a_width >= 0
			non_void_color: a_color /= Void
		local
			on_enter_event_handler_delegate: EVENT_HANDLER
			on_leave_event_handler_delegate: EVENT_HANDLER
			on_enter_pressed_delegate: WINFORMS_KEY_EVENT_HANDLER
		do		
			set_text_box_properties (a_text_box, a_text, x_position, y_position, a_width, a_color)
			create on_enter_event_handler_delegate.make_event_handler (Current, $on_enter_event_handler)
			a_text_box.add_got_focus (on_enter_event_handler_delegate)
			create on_leave_event_handler_delegate.make_event_handler (Current, $on_leave_event_handler)
			a_text_box.add_lost_focus (on_leave_event_handler_delegate)
			create on_enter_pressed_delegate.make_winforms_key_event_handler (Current, $on_enter_pressed)
			a_text_box.add_key_down (on_enter_pressed_delegate)
		end

	set_text_box_properties (a_text_box: WINFORMS_TEXT_BOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: DRAWING_COLOR) is
		indexing
			description: "[
						Set `a_text_box' position: (x_position, y_position).
						Set `a_text_box' size (a_width, Label_height).
						Set font color with `a_color'.
					  ]"
			external_name: "SetTextBoxProperties"
		require
			non_void_text_box: a_text_box /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			positive_width: a_width >= 0
			non_void_color: a_color /= Void
		local
			a_point: DRAWING_POINT
			a_size: DRAWING_SIZE
			a_font: DRAWING_FONT
			style: DRAWING_FONT_STYLE
			border_style: WINFORMS_BORDER_STYLE
			alignment: WINFORMS_HORIZONTAL_ALIGNMENT
		do		
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			a_text_box.set_location (a_point)
			a_text_box.set_text (a_text.to_cil)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (a_width)
			a_text_box.set_size (a_size)
			a_text_box.set_border_style (border_style.none)
			a_text_box.set_text_align (alignment.left)
			a_text_box.set_fore_color (a_color)
			a_text_box.set_back_color (dictionary.Editable_color)
			create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Italic)
			a_text_box.set_font (a_font)
			panel.get_controls.add (a_text_box)
		end
		
	build_inherit_clause (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build inherit clause"
			external_name: "BuildInheritClause"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			keys: ARRAY [STRING]
			--parents_names: SYSTEM_COLLECTIONS_ICOLLECTION
			--enumerator: SYSTEM_COLLECTIONS_IENUMERATOR			
			a_parent: STRING
			inheritance_clauses: ARRAY [LINKED_LIST[INHERITANCE_CLAUSE]]
			rename_clauses: LINKED_LIST[RENAME_CLAUSE]
			undefine_clauses: LINKED_LIST[UNDEFINE_CLAUSE]
			redefine_clauses: LINKED_LIST[REDEFINE_CLAUSE]
			select_clauses: LINKED_LIST[SELECT_CLAUSE]
			formatted_parents: ARRAY [STRING]
			i: INTEGER
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [STRING]
		do
			label_width := 0
			parents := an_eiffel_class.Parents
			
			if parents.count > 1 or has_any_in_clause or (parents.count = 1 and (not parents.has (eiffel_dictionary.Any_class))) then
				create_label ( from_reflection_string (eiffel_dictionary.Inherit_keyword), dictionary.Margin, dictionary.Margin + panel_height, dictionary.Keyword_color, True)
				panel_height := panel_height + dictionary.Label_height + dictionary.Margin
				
				--parents_names := conversion_support.from_array_any (parents.Keys)
				--enumerator := parents_names.Get_Enumerator
				--from
				--	parents.start
					--create formatted_parents.make (parents.count)
				--until
				--	parent.after
					--not enumerator.Move_Next
				--loop
				--	--a_parent ?= enumerator.get_Current
				--	a_parent ?= parents.item_for_iteration
				--	if a_parent /= Void then
				--		formatted_parents.put (a_parent, i)
				--	end
				--	i := i + 1
				--end
				
				formatted_parents := parents.current_keys
				
				from
					i := formatted_parents.count
				until
					i = 0
				loop
					a_parent := formatted_parents.item (i)
					if a_parent /= Void then
						if (not a_parent.is_equal ( from_reflection_string (eiffel_dictionary.Any_class))) or has_any_in_clause then
							create_label (a_parent, 3 * dictionary.Margin, panel_height, dictionary.Class_color, False)
						end
					end
					panel_height := panel_height + dictionary.Label_height
					
					inheritance_clauses ?= parents.Item (a_parent)
					if inheritance_clauses /= Void then
							-- rename clauses
						if inheritance_clauses.Item (0).Count > 0 then
							create_label (from_reflection_string (eiffel_dictionary.Rename_keyword), 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							rename_clauses ?= inheritance_clauses.Item (0)
							if rename_clauses /= Void and then rename_clauses.count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (rename_clauses) 
								panel_height := rename_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- undefine clauses
						if inheritance_clauses.Item (1).count > 0 then
							create_label ( from_reflection_string (eiffel_dictionary.Undefine_keyword), 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							undefine_clauses ?= inheritance_clauses.Item (1)
							if undefine_clauses /= Void and then undefine_clauses.count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (undefine_clauses)
								panel_height := undefine_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- redefine clauses
						if inheritance_clauses.Item (2).count > 0 then
							create_label ( from_reflection_string (eiffel_dictionary.Redefine_keyword), 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							redefine_clauses ?= inheritance_clauses.Item (2)
							if redefine_clauses /= Void and then redefine_clauses.count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (redefine_clauses) 
								panel_height := redefine_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- select clauses
						if inheritance_clauses.Item (3).count > 0 then
							create_label (from_reflection_string (eiffel_dictionary.Select_keyword), 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							select_clauses ?= inheritance_clauses.Item (3)
							if select_clauses /= Void and then select_clauses.count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (select_clauses)
								panel_height := select_clauses.count * dictionary.Label_height + panel_height
							end
						end
						
							-- Add `end' keyword at the end of inheritance clauses
						if inheritance_clauses.Item (0).Count > 0 or inheritance_clauses.Item (1).Count > 0 or inheritance_clauses.Item (2).Count > 0 or inheritance_clauses.item (3).count > 0 then
							create_label ( from_reflection_String (eiffel_dictionary.End_keyword), 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							panel_height := panel_height + dictionary.Label_height
						end						
					end
					i := i - 1
				end
			end		
		end

	has_any_in_clause: BOOLEAN is
		indexing
			description: "Does class have inheritance clauses for parent `ANY'?"
			external_name: "HasAnyInClause"
		require
			non_void_parents: parents /= Void
		local
			inheritance_clauses: ARRAY [LINKED_LIST [INHERITANCE_CLAUSE] ]
		do
			if parents.has (from_reflection_string (eiffel_dictionary.Any_class)) then
				inheritance_clauses ?= parents.Item (from_reflection_string (eiffel_dictionary.Any_class))
				if inheritance_clauses /= Void then
					Result := inheritance_clauses.item (0).Count > 0 
							or inheritance_clauses.item (1).Count > 0
							or inheritance_clauses.item (2).Count > 0
							or inheritance_clauses.item (3).Count > 0
				end
			else
				Result := False
			end
		end
		
	build_inheritance_clauses (clauses: LINKED_LIST [INHERITANCE_CLAUSE] ) is
			-- | Add text box to `a_table' for `parent_number'-th parent. 
		indexing
			description: "Build inheritance clauses from `clauses'."
			external_name: "BuildInheritanceClauses"
		require
			non_void_clauses: clauses /= Void
			not_empty_clauses: clauses.count > 0
		local
			i: INTEGER
			a_clause: INHERITANCE_CLAUSE
			a_text_box: WINFORMS_TEXT_BOX
			clause_string: STRING
		do
			from
				clauses.start
			until
				clauses.after
			loop
				a_clause ?= clauses.item
				if a_clause /= Void then
					create a_text_box.make_winforms_text_box
					clause_string := a_clause.string_representation.clone (a_clause.string_representation)
					if not clauses.islast then
						clause_string.append (from_reflection_string (eiffel_dictionary.Comma))
						create_label (clause_string, 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
					else
						create_label (clause_string, 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
					end
				end
				clauses.forth
			end
		end

	build_create_clause (an_eiffel_class: like eiffel_class) is 
		indexing 
			description: "Build create clause."
			external_name: "BuildCreateClause"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local	
			i: INTEGER
			a_feature_name: STRING
			a_feature: EIFFEL_FEATURE
			initialization_features: LINKED_LIST [EIFFEL_FEATURE]
			a_text_box: WINFORMS_TEXT_BOX
			new_label_width: INTEGER
			value: STRING
			feature_string: STRING
		do
			label_width := 0
			initialization_features := an_eiffel_class.Initialization_Features

			if initialization_features.count > 0 and not an_eiffel_class.Is_Deferred and not is_special_class (an_eiffel_class) then			
					-- Do not generate creation clause for expanded classes
				if not an_eiffel_class.Is_Expanded then
					create_label (from_reflection_string (eiffel_dictionary.Create_keyword), dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
					panel_height := panel_height + dictionary.Label_height + dictionary.Margin
					from
						initialization_features.start
					until
						initialization_features.after
					loop
						a_feature ?= initialization_features.item
						if a_feature /= Void then
							a_feature_name := a_feature.eiffel_name
							if a_feature_name /= Void and then a_feature_name.count > 0 then
								create a_text_box.make_winforms_text_box
								if not initialization_features.islast then
									feature_string := a_feature_name.clone (a_feature_name)
									feature_string.append (eiffel_dictionary.Comma)
									create_label (feature_string, 3 * dictionary.Margin, panel_height + i * dictionary.Label_height, dictionary.Feature_color, False)
								else
									create_label (a_feature_name, 3 * dictionary.Margin, panel_height + i * dictionary.Label_height, dictionary.Feature_color, False)
								end
							end
						end
						initialization_features.forth
					end
					panel_height := panel_height + dictionary.Label_height * initialization_features.count
				end				
			elseif initialization_features.count = 0 and not an_eiffel_class.Is_Deferred and not an_eiffel_class.is_expanded then
				create_label (from_reflection_string (eiffel_dictionary.Create_keyword), dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				new_label_width := dictionary.Margin + label_width
				create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				panel_height := panel_height + dictionary.Label_height + dictionary.Margin
			end
			
			if an_eiffel_class.Initialization_Features.count > 0 and not an_eiffel_class.Is_Deferred and not is_special_class (an_eiffel_class) then
					-- Generate initialization feature clause.
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				new_label_width := dictionary.Margin + label_width
				if not an_eiffel_class.is_expanded then
					create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
					new_label_width := new_label_width + label_width
					create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
					new_label_width := new_label_width + label_width
					create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
					new_label_width := new_label_width + label_width
				end
				create_label (dictionary.Initialization_comment, new_label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				initialization_features := an_eiffel_class.Initialization_Features
				from
					initialization_features.start
				until
					initialization_features.after
				loop
					a_feature ?= initialization_features.item
					if a_feature /= Void then
						if a_feature.Is_Field and a_feature.Is_Static and not a_feature.is_enum_literal and a_feature.is_literal then							
							value := a_feature.literal_value
							if value /= Void and then value.count > 0 then
								build_eiffel_feature (an_eiffel_class, a_feature)
							end
						else
							build_eiffel_feature (an_eiffel_class, a_feature)
						end
					end
					initialization_features.forth
				end			
			end
		end

	is_special_class (an_eiffel_class:like eiffel_class): BOOLEAN is
		indexing
			description: "Is `an_eiffel_class' a special class?"
			external_name: "IsSpecialClass"
		require
			non_void_special_classes: special_classes /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			eiffel_class_name: STRING
		do
			eiffel_class_name ?= an_eiffel_class.eiffel_name.clone (an_eiffel_class.eiffel_name)
			eiffel_class_name.to_upper
			Result := special_classes.has (eiffel_class_name)
		end

	special_classes: HASH_TABLE [STRING, STRING] is
		indexing
			description: "Special classes for which no creation routine should be generated"
			external_name: "SpecialClasses"
		once
			create Result.make (8)
			Result.extend (from_reflection_string (eiffel_dictionary.Integer_class), from_reflection_string (eiffel_dictionary.Integer_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Integer_16_class), from_reflection_string (eiffel_dictionary.Integer_16_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Integer_64_class), from_reflection_string (eiffel_dictionary.Integer_64_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Integer_8_class), from_reflection_string (eiffel_dictionary.Integer_8_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Double_class), from_reflection_string (eiffel_dictionary.Double_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Real_class), from_reflection_string (eiffel_dictionary.Real_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Boolean_class), from_reflection_string (eiffel_dictionary.Boolean_class))
			Result.extend (from_reflection_string (eiffel_dictionary.Character_class), from_reflection_string (eiffel_dictionary.Character_class))
		ensure
			special_classes_created: Result /= Void 
			valid_special_classes: Result.count = 8
		end

	build_class_features (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build class features from `an_eiffel_class', except initialization ones."
			external_name: "BuildClassFeatures"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			access_features: LINKED_LIST [EIFFEL_FEATURE]
			element_change_features: LINKED_LIST [EIFFEL_FEATURE]
			basic_operations_features: LINKED_LIST [EIFFEL_FEATURE]
			unary_operators_features: LINKED_LIST [EIFFEL_FEATURE]
			binary_operators_features: LINKED_LIST [EIFFEL_FEATURE]
			specials_features: LINKED_LIST [EIFFEL_FEATURE]
			implementation_features: LINKED_LIST [EIFFEL_FEATURE]
			
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [EIFFEL_FEATURE]
		do	
			label_width := 0
			
				-- Generate access feature clause.
			access_features := an_eiffel_class.Access_Features
			if access_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Access_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, access_features)
			end	
				
				-- Generate element change feature clause.
			element_change_features := an_eiffel_class.Element_Change_Features
			if element_change_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Element_change_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height				
				intern_build_class_features (an_eiffel_class, element_change_features)
			end					

				-- Generate basic operations feature clause.
			basic_operations_features := an_eiffel_class.Basic_Operations
			if basic_operations_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Basic_operations_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, basic_operations_features)
			end	

				-- Generate unary operators feature clause.
			unary_operators_features := an_eiffel_class.Unary_Operators_Features
			if unary_operators_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Unary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, unary_operators_features)
			end	

				-- Generate binary operators feature clause.
			binary_operators_features := an_eiffel_class.Binary_Operators_Features
			if binary_operators_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Binary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, binary_operators_features)
			end	

				-- Generate specials feature clause.
			specials_features := an_eiffel_class.Special_Features
			if specials_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Specials_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, specials_features)
			end	

				-- Generate implementation feature clause.
			implementation_features := an_eiffel_class.Implementation_Features
			if implementation_features.count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Implementation_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, implementation_features)
			end
		end

	intern_build_class_features (an_eiffel_class: like eiffel_class; a_list: LINKED_LIST [EIFFEL_FEATURE]) is
			-- | Call in loop `build_eiffel_feature'.
		indexing
			description: "Build class features from `a_list'."
			external_name: "InternBuildClassFeatures"
		require
			non_void_list: a_list /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			a_feature: EIFFEL_FEATURE
			value: STRING 
		do
			from
				a_list.start
			until
				a_list.after
			loop
				a_feature ?= a_list.item
				if a_feature /= Void and then (a_feature.eiffel_name /= Void and a_feature.eiffel_name.count > 0) then
					if a_feature.Is_Field and a_feature.Is_Static and not a_feature.is_enum_literal and a_feature.is_literal then							
						value := a_feature.literal_value
						if value /= Void and then value.count > 0 then
							build_eiffel_feature (an_eiffel_class, a_feature)
							panel_height := panel_height + dictionary.Margin
						end
					else
						build_eiffel_feature (an_eiffel_class, a_feature)
						panel_height := panel_height + dictionary.Margin
					end
				end
				a_list.forth
			end		
		end

	build_eiffel_feature (an_eiffel_class: like eiffel_class; a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Generate Eiffel feature from `a_feature' and `an_eiffel_class'."
			external_name: "BuildEiffelFeature"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_name: a_feature.eiffel_name /= Void
			not_empty_feature_name: a_feature.eiffel_name.count > 0
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			is_unary_operator: BOOLEAN
			feature_name: STRING
			a_text_box: WINFORMS_TEXT_BOX
			tmp_label: WINFORMS_LABEL
			feature_name_width: INTEGER
			arguments: LINKED_LIST[NAMED_SIGNATURE_TYPE_INTERFACE]
			i: INTEGER
			an_argument: NAMED_SIGNATURE_TYPE_INTERFACE
			formal_argument: FORMAL_NAMED_SIGNATURE_TYPE
			generic_parameter_index: INTEGER
			argument_name: STRING
			argument_type: STRING
			argument_name_width: INTEGER
			argument_type_width: INTEGER
			formal_return_type: FORMAL_SIGNATURE_TYPE
			return_type_name: STRING
			new_label_width: INTEGER
			a_font: DRAWING_FONT
			an_array: ARRAY [ANY]
			is_editable_feature: BOOLEAN
			style: DRAWING_FONT_STYLE
			conversion_support: ASSMEBLY_MANAGER_SUPPORT [NAMED_SIGNATURE_TYPE_INTERFACE]
		do
			is_unary_operator := an_eiffel_class.Unary_Operators_Features.has (a_feature)
			label_width := 0
			create a_font.make_drawing_font_10 (dictionary.Font_family_name.to_cil, dictionary.Font_size, style.Italic)
			is_editable_feature := a_feature.new_slot
			
				-- frozen
			if a_feature.Is_Frozen then
				create_label (from_reflection_string (eiffel_dictionary.Frozen_keyword), 3 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
			end
				
				-- feature name
			create a_text_box.make_winforms_text_box
			create tmp_label.make_winforms_label
			new_label_width := 3 * dictionary.Margin + label_width
			if is_unary_operator and a_feature.Is_Prefix then				
				create_label (from_reflection_string (eiffel_dictionary.Prefix_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
				if a_feature.is_creation_routine then
					create_label (from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, dictionary.Feature_color, False)	
					feature_name_width := label_width
				else					
					if is_editable_feature then
						feature_name_width := text_box_width_from_text (a_feature.eiffel_name, a_font)
						set_editable_text_box_properties (a_text_box, a_feature.eiffel_name, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
					else
						create_label (from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, dictionary.Feature_color, False)
						feature_name_width := label_width
					end
				end
			else
				if a_feature.Is_Infix then
					create_label (from_reflection_string (eiffel_dictionary.Infix_keyword), new_label_width, panel_height, dictionary.Keyword_color, True)
					new_label_width := new_label_width + label_width
					if a_feature.is_creation_routine then
						create_label (from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						if is_editable_feature then
							feature_name_width := text_box_width_from_text (from_reflection_string (a_feature.eiffel_name), a_font)		
							set_editable_text_box_properties (a_text_box, from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
						else
							create_label (from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, dictionary.Feature_color, False)
							feature_name_width := label_width
						end
					end
				else
					if a_feature.is_creation_routine then
						create_label (from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						if is_editable_feature then
							feature_name_width := text_box_width_from_text (a_feature.eiffel_name, a_font)
							set_editable_text_box_properties (a_text_box, from_reflection_string (a_feature.eiffel_name), new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
						else
							create_label (a_feature. eiffel_name, new_label_width, panel_height, dictionary.Feature_color, False)
							feature_name_width := label_width
						end
					end
				end
			end
			new_label_width := new_label_width +  feature_name_width
			feature_names_boxes.extend (a_feature, a_text_box.get_hash_code)
			
				-- feature arguments
			arguments := a_feature.arguments
			if not is_unary_operator and arguments.count > 0 then
				create_label (eiffel_dictionary.Opening_round_bracket, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				from
					arguments.start
				until
					arguments.after
				loop
					an_argument ?= arguments.item
					if an_argument /= Void then						
						argument_name := from_reflection_string (an_argument.eiffel_name)
						formal_argument ?= arguments.item
						if formal_argument /= Void and then generic_type_names /= Void then
							generic_parameter_index := formal_argument.generic_parameter_index
							if generic_parameter_index < generic_type_names.count then
								argument_type ?= generic_type_names.item (generic_parameter_index)
							else
								argument_type := from_reflection_string (an_argument.type_eiffel_name)
							end
						else
							argument_type := from_reflection_string (an_argument.type_eiffel_name)
						end
					end
					if a_feature.is_creation_routine then
						create_label (argument_name, new_label_width, panel_height, dictionary.Feature_color, False)
						new_label_width := new_label_width + label_width 
					else
						create a_text_box.make_winforms_text_box
						if is_editable_feature then
							argument_name_width := text_box_width_from_text (argument_name, a_font)				
							set_editable_text_box_properties (a_text_box, argument_name, new_label_width, panel_height, argument_name_width, dictionary.Feature_color)
						else
							create_label (argument_name, new_label_width, panel_height, dictionary.Feature_color, False)
							argument_name_width := label_width
						end
						new_label_width := new_label_width + argument_name_width 
						create an_array.make (0, 1)
						an_array.put (a_feature, 0)
						an_array.put (an_argument, 1)
						feature_arguments_boxes.extend (an_array, a_text_box.get_hash_code)
					end
					create_label (from_reflection_String (eiffel_dictionary.Colon), new_label_width, panel_height, dictionary.Text_color, False)
					new_label_width := new_label_width + label_width
					
					create_label (argument_type, new_label_width, panel_height, dictionary.Class_color, False)
					new_label_width := new_label_width + label_width
					
					if not arguments.islast then
						create_label (from_reflection_string (eiffel_dictionary.Semi_colon), new_label_width, panel_height, dictionary.Text_color, False)
						new_label_width := new_label_width + label_width
					end
					arguments.forth
				end
				create_label ( eiffel_dictionary.Closing_round_bracket, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
			end
		
				-- feature return type
			if a_feature.Is_Method and then a_feature.Return_Type /= Void and then a_feature.return_type.type_eiffel_name /= Void and then a_feature.return_type.type_eiffel_name.count > 0 then
				formal_return_type ?= a_feature.return_type
				if formal_return_type /= Void and then generic_type_names /= Void then
					generic_parameter_index := formal_return_type.generic_parameter_index
					if generic_parameter_index < generic_type_names.count then
						return_type_name ?= from_reflection_string (generic_type_names.item (generic_parameter_index))
					else
						return_type_name := from_reflection_string (a_feature.return_type.type_eiffel_name)
					end				
				else
					return_type_name := from_reflection_string (a_feature.return_type.type_eiffel_name)
				end
				create_label ( eiffel_dictionary.Colon, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width 
				create_label (return_type_name, new_label_width, panel_height, dictionary.Class_color, False)
			end
			if a_feature.Is_Field and then a_feature.Eiffel_Name.substring_index (eiffel_dictionary.Property_set_prefix, 1) = 0 then
				create_label (from_reflection_string (eiffel_dictionary.Colon), new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (a_feature.return_type.type_eiffel_name, new_label_width, panel_height, dictionary.Class_color, False)
			end
			panel_height := panel_height + dictionary.Label_height
		end	
	
	text_box_width_from_text (a_text: STRING; a_font: DRAWING_FONT): INTEGER is
			-- | FIXME: Should disappear if we can find a feature giving the get_length of a string in pixels.
		indexing
			description: "Width of text box with text `a_text' and font `a_font'."
			external_name: "TextBoxWidthFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
			non_void_font: a_font /= Void
		local
			tmp_label: WINFORMS_LABEL
		do
			create tmp_label.make_winforms_label
			tmp_label.set_text (a_text.to_cil)
			tmp_label.set_auto_size (True)
			tmp_label.set_font (a_font)
			Result := tmp_label.get_width		
		end

	save_feature_modifications (text_box: WINFORMS_TEXT_BOX) is
		indexing
			description: "Save user modifications on the feature."
			external_name: "SaveFeatureModifications"
		require
			non_void_text_box: text_box /= Void
		local
			an_array: ARRAY [ANY]
			a_feature: EIFFEL_FEATURE
			an_argument: NAMED_SIGNATURE_TYPE_INTERFACE
			feature_name: STRING
			argument_name: STRING
		do
			if feature_names_boxes.has (text_box.get_hash_code) and feature_modifications /= Void and modified_feature /= Void then
				feature_name := feature_modifications.old_feature_name.clone (feature_modifications.old_feature_name)
				feature_name.to_lower
				if feature_modifications.old_feature_name /= Void and then not feature_name .is_equal (from_system_string (text_box.get_text.to_lower)) then
					feature_modifications.set_new_feature_name ( from_system_string (text_box.get_text))
					type_modifications.add_feature_modification (modified_feature, feature_modifications)
				end
			elseif feature_arguments_boxes.has (text_box.get_hash_code) then
				an_array ?= feature_arguments_boxes.item (text_box.get_hash_code)
				if an_array /= Void and then an_array.count = 2 then
					a_feature ?= an_array.item (0)
					an_argument ?= an_array.item (1)
					if (a_feature /= Void and then a_feature = modified_feature) and an_argument /= Void then
						argument_name := an_argument.eiffel_name.clone (an_argument.eiffel_name)
						argument_name.to_lower
						if not argument_name.is_equal ( from_system_string (text_box.get_text.to_lower)) then
							feature_modifications.add_argument_modification (an_argument, from_system_string (text_box.get_text))
							type_modifications.add_feature_modification (modified_feature, feature_modifications)
						end
					end									
				end							
			end
			feature_modifications := Void
			modified_feature := Void
		end
		
	errors_list_view: WINFORMS_LIST_VIEW
		indexing
			description: "Errors list view"
			external_name: "ErrorsListView"
		end
	
	errors_table: HASH_TABLE [CLI_CELL[WINFORMS_TEXT_BOX], INTEGER]
		indexing
			description: "Key: Line number in list view; Value: Text box"
			external_name: "ErrorsTable"
		end
		
	display_errors (class_error_message: STRING; errors_in_features:HASH_TABLE[STRING, EIFFEL_FEATURE] errors_in_arguments: HASH_TABLE[STRING, INTEGER]; errors_in_arguments_mappings: HASH_TABLE [ARRAY[ANY], INTEGER]) is
		indexing
			description: "Build errors list view from `class_error_message', errors_in_features' and `errors_in_arguments' and display it."
			external_name: "ErrorsListView"
		local
			a_size: DRAWING_SIZE
			a_point: DRAWING_POINT
			a_feature: EIFFEL_FEATURE
			an_argument: NAMED_SIGNATURE_TYPE
			an_array: ARRAY [ANY]
			an_error_message: STRING
			list_view_item: WINFORMS_LIST_VIEW_ITEM
			--enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			on_item_delegate: EVENT_HANDLER
			border_style: WINFORMS_BORDER_STYLE
			alignment: WINFORMS_LIST_VIEW_ALIGNMENT
			sort_order: WINFORMS_SORT_ORDER
			activation: WINFORMS_ITEM_ACTIVATION
			view: WINFORMS_VIEW
			item: CLI_CELL [WINFORMS_TEXT_BOX]
		do
			create errors_list_view.make_winforms_list_view
			errors_list_view.set_border_style (border_style.fixed_single)
			errors_list_view.set_check_boxes (False)
			errors_list_view.set_full_row_select (True)
			errors_list_view.set_grid_lines (True)
			errors_list_view.set_multi_select (False)
			errors_list_view.set_sorting (sort_order.none)
			errors_list_view.set_view (view.small_icon)
			errors_list_view.set_activation (activation.standard)
			errors_list_view.set_alignment (alignment.left)
			errors_list_view.set_scrollable (True)
			errors_list_view.set_tab_index (0)			
			a_point.set_X (0)
			a_point.set_Y (main_win.get_height - 5 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)	
			errors_list_view.set_location (a_point)			
			a_size.set_width (main_win.get_width - dictionary.Margin // 2)
			a_size.set_height (4 * dictionary.Label_height)
			errors_list_view.set_size (a_size)	
			
			create errors_table.make(0)
			if class_error_message /= Void and then class_error_message.count > 0 then
				create list_view_item.make_1 (message_from_class_error (class_error_message).to_cil)
				list_view_item.set_fore_color (dictionary.Red_color)
				list_view_item := errors_list_view.get_items.add_list_view_item (list_view_item)
				create item.put (class_name_text_box)
				errors_table.extend (item, 0)
			end
			
			if errors_in_features /= Void and then errors_in_features.count > 0 then
				--enumerator := errors_in_features.keys.get_enumerator
				from
					errors_in_features.start
				until
					--not enumerator.move_next
					errors_in_features.after
				loop
					a_feature ?= errors_in_features.key_for_iteration--enumerator.get_current
					if a_feature /= Void then
						--an_error_message ?= errors_in_features.item (a_feature)
						an_error_message ?= errors_in_features.item_for_iteration
						if an_error_message /= Void and then an_error_message.count > 0 then
							create list_view_item.make_1 (message_from_feature_error (a_feature, an_error_message).to_cil)
							list_view_item.set_fore_color (dictionary.Red_color)
							list_view_item := errors_list_view.get_items.add_list_view_item (list_view_item)
							create item.put (feature_text_box (a_feature))
							errors_table.extend (item, errors_list_view.get_items.get_count - 1)
						end
					end
					errors_in_features.forth
				end
			end
			
			if errors_in_arguments /= Void and then errors_in_arguments.count > 0 and then errors_in_arguments_mappings /= void and then errors_in_arguments_mappings.count > 0 then
				--enumerator := errors_in_arguments.get_keys.get_enumerator
				from
					errors_in_arguments.start
					errors_in_arguments_mappings.start
				until
					errors_in_arguments.after or
					errors_in_arguments_mappings.after
				loop
					an_array ?= errors_in_arguments_mappings.item_for_iteration
					if an_array /= Void then
						a_feature ?= an_array.item(0)
						an_argument ?= an_array.item (1)
						if a_feature /= Void and an_argument /= Void then
							an_error_message ?= errors_in_arguments.item (an_array.get_hash_code)
							if an_error_message /= Void and then an_error_message.count > 0 then
								create list_view_item.make_1 (message_from_argument_error (a_feature, an_argument, an_error_message).to_cil)
								list_view_item.set_fore_color (dictionary.Red_color)
								list_view_item := errors_list_view.get_items.add_list_view_item (list_view_item)
								create item.put (argument_text_box (an_argument, a_feature))
								errors_table.extend (item, errors_list_view.get_items.get_count - 1)
							end
						end
					end
					errors_in_arguments.forth
					errors_in_arguments_mappings.forth
				end
			end	
			create on_item_delegate.make_event_handler (Current, $on_item)
			errors_list_view.add_Click (on_item_delegate)
			main_win.get_controls.add (errors_list_view)
		end

	message_from_class_error (an_error_message: STRING): STRING is
		indexing
			description: "Error message from`an_error_message'"
			external_name: "MessageFromClassError"
		require
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.count > 0		
		do
			Result := dictionary.Error.clone (dictionary.Error)
			Result.append (dictionary.Space)
			Result.append (dictionary.Opening_round_bracket)
			Result.append (dictionary.Class_name)
			Result.append (dictionary.Closing_round_bracket)
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (an_error_message)		
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.count > 0		
		end
		
	message_from_feature_error (a_feature: EIFFEL_FEATURE; an_error_message: STRING): STRING is
		indexing
			description: "Error message from `a_feature' and `an_error_message'"
			external_name: "MessageFromFeatureError"
		require
			non_void_feature: a_feature /= Void
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.count > 0
		do
			Result := dictionary.Error.clone (dictionary.Error)
			Result.append (dictionary.Space)
			Result.append (dictionary.Opening_round_bracket)
			Result.append (dictionary.Feature_string)
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (a_feature.eiffel_name)
			Result.append (dictionary.Closing_round_bracket)
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (an_error_message)
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.count > 0
		end

	message_from_argument_error (a_feature: EIFFEL_FEATURE; an_argument: NAMED_SIGNATURE_TYPE; an_error_message: STRING): STRING is
		indexing
			description: "Error message from `a_feature' and `an_error_message'"
			external_name: "MessageFromFeatureError"
		require
			non_void_feature: a_feature /= Void
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.count > 0
			non_void_argument: an_argument /= Void
		do
			Result := dictionary.Error.clone (dictionary.Error)
			Result.append (dictionary.Space)
			Result.append (dictionary.Opening_round_bracket)
			Result.append (dictionary.Feature_string)
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (a_feature.eiffel_name)
			Result.append (dictionary.Comma_separator)
			Result.append (dictionary.Space)
			Result.append (dictionary.Argument_string)
			Result.append (Dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (an_argument.eiffel_name)
			Result.append (dictionary.Closing_round_bracket)
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			Result.append (an_error_message)
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.count > 0
		end
	
	on_item (sender: SYSTEM_OBJECT; arguments: EVENT_ARGS) is
		indexing
			description: "Action performed when user clicks on an item in the errors list view"
			external_name: "OnItem"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_items: WINFORMS_SELECTED_LIST_VIEW_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW		
			is_focused: BOOLEAN
			a_text_box: WINFORMS_TEXT_BOX
			item: CLI_CELL [WINFORMS_TEXT_BOX]
		do
			selected_items := errors_list_view.get_selected_items
			if selected_items /= Void then
				check
					only_one_item_selected: selected_items.get_count = 1
				end
				item ?= errors_table.item (selected_items.get_item (0).get_index)
				if item /= Void then
					a_text_box ?= item.item
					if a_text_box /= Void then
						is_focused := a_text_box.focus
						a_text_box.select_
					end
				end
			end
		end

	feature_text_box (a_feature: EIFFEL_FEATURE): WINFORMS_TEXT_BOX is
		indexing
			description: "Text box corresponding to `a_feature'."
			external_name: "FeatureTextBox"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_names_text_boxes: feature_names_boxes /= Void
			is_in_feature_names_text_boxes: feature_names_boxes.has_item (a_feature)
		local
			--enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_text_box: WINFORMS_TEXT_BOX
			corresponding_feature: EIFFEL_FEATURE
			feature_name: STRING
			feature_name2: STRING
		do
			--enumerator := feature_names_boxes.get_keys.get_enumerator
			from
				feature_names_boxes.start
			until
				feature_names_boxes.after or Result /= Void 
			loop
				a_text_box ?= feature_names_boxes.key_for_iteration
				if a_text_box /= Void then
					corresponding_feature ?= feature_names_boxes.item (a_text_box.get_hash_code)
					feature_name := corresponding_feature.eiffel_name.clone(corresponding_feature.eiffel_name)
					feature_name.to_lower
					feature_name2 := a_feature.eiffel_name.clone(a_feature.eiffel_name)
					feature_name2.to_lower
					if corresponding_feature /= Void and then feature_name.is_equal ( feature_name2 ) then
						Result := a_text_box
					end
				end
				feature_names_boxes.forth
			end
		ensure
			non_void_text_box: Result /= Void
		end

	argument_text_box (an_argument: NAMED_SIGNATURE_TYPE; a_feature: EIFFEL_FEATURE): WINFORMS_TEXT_BOX is
		indexing
			description: "Text box corresponding to `an_argument' in feature `a_feature'."
			external_name: "ArgumentTextBox"
		require
			non_void_feature: a_feature /= Void
			non_void_arguments: an_argument /= Void
			non_void_feature_arguments_boxes: feature_arguments_boxes /= Void
		local
			--enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_text_box: WINFORMS_TEXT_BOX
			a_text_box_hash: INTEGER
			an_array: ARRAY [ANY]
			corresponding_feature: EIFFEL_FEATURE
			corresponding_argument: NAMED_SIGNATURE_TYPE
			feature_name: STRING
			feature_name2: STRING
			argument_name: STRING
			argument_name2: STRING
			i: INTEGER
		do
			--enumerator := feature_arguments_boxes.get_keys.get_enumerator
			from
				feature_arguments_boxes.start
			until
				feature_arguments_boxes.after or Result /= Void 
			loop
				a_text_box_hash ?= feature_arguments_boxes.key_for_iteration
				if a_text_box_hash /= Void then
					an_array ?= feature_arguments_boxes.item (a_text_box_hash)
					if an_array /= Void then
						corresponding_feature ?= an_array.item (0)
						corresponding_argument ?= an_array.item (1)
						feature_name := corresponding_feature.eiffel_name.clone(corresponding_feature.eiffel_name)
						feature_name.to_lower
						feature_name2 := a_feature.eiffel_name.clone(a_feature.eiffel_name)
						feature_name2.to_lower
						argument_name := corresponding_argument.eiffel_name.clone (corresponding_argument.eiffel_name)
						argument_name.to_lower
						argument_name2 := an_argument.eiffel_name.clone (an_argument.eiffel_name)
						argument_name2.to_lower
						if (corresponding_feature /= Void and then feature_name.is_equal (feature_name2)) and (corresponding_argument /= Void and then  argument_name.is_equal (argument_name2)) then
							from
								i := 0
							until
								i = main_win.get_controls.get_count or Result /= Void
							loop
								a_text_box ?= main_win.get_controls.get_item (i)
								if a_text_box.get_hash_code = a_text_box_hash then
									Result := a_text_box
								end
							end
						end
					end
				end
				feature_arguments_boxes.forth
			end
		ensure
			non_void_text_box: Result /= Void
		end
		
invariant
	non_void_type_modifications: type_modifications /= Void
	
end -- class TYPE_VIEW
