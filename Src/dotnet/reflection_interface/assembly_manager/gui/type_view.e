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
			description: "[Set `assembly_descriptor' with `an_assembly_descriptor'.%
					%Set `eiffel_class' with `an_eiffel_class'.%
					%Set `assembly_view' with `an_assembly_view'.]"
			external_name: "Make"
		require
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
			non_void_assembly_name: an_assembly_descriptor.name /= Void
			not_empty_assembly_name: an_assembly_descriptor.name.Length > 0
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_eiffel_name: an_eiffel_class.eiffelname /= Void
			not_empty_eiffel_name: an_eiffel_class.eiffelname.length > 0
			non_void_children_list: children_list /= Void
			non_void_assembly_view: an_assembly_view /= Void
		local
			return_value: INTEGER
		do
			make_form
			assembly_descriptor := an_assembly_descriptor
			eiffel_class := an_eiffel_class
			children := children_list
			assembly_view := an_assembly_view
			create eiffel_dictionary.make_eiffelcodegeneratordictionary
			create type_modifications.make_from_info (eiffel_class.eiffelname)
			create parents_handler.make (eiffel_class, assembly_descriptor)
			initialize_gui
			return_value := showdialog
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
		
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
		indexing
			description: "Eiffel class"
			external_name: "EiffelClass"
		end
		
	children: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Children of `eiffel_class'"
			external_name: "Children"
		end
	
	assembly_view: ASSEMBLY_VIEW
		indexing
			description: "Assembly view"
			external_name: "AssemblyView"
		end
		
	assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
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
			Result := assembly_view.assembly.eiffelclusterpath
		ensure
			non_void_path: Result /= Void 
			not_empty_path: Result.length > 0
		end
		
	eiffel_dictionary: ISE_REFLECTION_EIFFELCODEGENERATORDICTIONARY
		indexing
			description: "Eiffel dictionary"
			external_name: "EiffelDictionary"
		end
		
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "OK button"
			external_name: "OkButton"
		end

	cancel_button: SYSTEM_WINDOWS_FORMS_BUTTON
		indexing
			description: "Cancel button"
			external_name: "CancelButton"
		end

	panel: SYSTEM_WINDOWS_FORMS_PANEL
		indexing
			description: "Panel with class contract form"
			external_name: "Panel"
		end

	class_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		indexing
			description: "Class name text box"
			external_name: "ClassNameTextBox"
		end

	end_class_name_label: SYSTEM_WINDOWS_FORMS_LABEL
		indexing
			description: "Class name label"
			external_name: "EndClassNameLabel"
		end
	
	label_width: INTEGER 
		indexing
			description: "Width of label created by `create_label'"
			external_name: "LabelWidth"
		end

	created_label: SYSTEM_WINDOWS_FORMS_LABEL
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
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			on_ok_delegate: SYSTEM_EVENTHANDLER
			on_cancel_delegate: SYSTEM_EVENTHANDLER
			on_resize_delegate: SYSTEM_EVENTHANDLER
		do
			set_Enabled (True)
			set_text (dictionary.Title)
			--set_borderstyle (dictionary.Border_style)
			a_size.set_Width (dictionary.Window_width)
			a_size.set_Height (dictionary.Window_height)
			set_size (a_size)
			set_icon (dictionary.Edit_icon)

				-- `Selected assembly: '
			create_form_label (assembly_descriptor.name, dictionary.Margin, dictionary.Margin)
			create_assembly_labels
				
				-- Build editable class
			build_class_contract_form (eiffel_class)
			a_size.set_width (width - dictionary.Margin // 2)
			a_size.set_height (dictionary.Window_height - 6 * dictionary.Margin - 5 * dictionary.Label_height - dictionary.Button_height)
			panel.set_size (a_size)
			
				-- OK button
			create ok_button.make_button
			a_point.set_X (width // 2 - (dictionary.Margin // 2) - dictionary.Button_width) 
			a_point.set_Y (height - 3 * dictionary.Margin - dictionary.Button_height)
			ok_button.set_location (a_point)
			ok_button.set_height (dictionary.Button_height)
			ok_button.set_width (dictionary.Button_width)
			ok_button.set_text (dictionary.Ok_button_label)
			create on_ok_delegate.make_eventhandler (Current, $on_ok_event_handler)
			ok_button.add_Click (on_ok_delegate)

				-- Cancel button
			create cancel_button.make_button
			a_point.set_X (width // 2 + dictionary.Margin // 2)
			a_point.set_Y (height - 3 * dictionary.Margin - dictionary.Button_height)
			cancel_button.set_location (a_point)
			cancel_button.set_height (dictionary.Button_height)
			cancel_button.set_width (dictionary.Button_width)
			cancel_button.set_text (dictionary.Cancel_button_label)
			create on_cancel_delegate.make_eventhandler (Current, $on_cancel_event_handler)
			cancel_button.add_Click (on_cancel_delegate)
			
				-- Addition of controls
			controls.add (ok_button)		
			controls.add (cancel_button)

			add_closed (on_cancel_delegate)
			create on_resize_delegate.make_eventhandler (Current, $on_resize)
			add_resize (on_resize_delegate)
		end

feature -- Event handling

	on_resize (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Resize window and its content."
			external_name: "OnResize"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
		do
				-- Resize `panel'.
			a_size.set_width (width - dictionary.Margin // 2)
			if errors_list_view /= Void and then controls.contains (errors_list_view) then
				a_size.set_height (height - 6 * dictionary.Margin - 7 * dictionary.Label_height - dictionary.Button_height)
			else
				a_size.set_height (height - 6 * dictionary.Margin - 5 * dictionary.Label_height - dictionary.Button_height)
			end
			panel.set_Size (a_size)	
			
				-- Move `ok_button' and `cancel_button'.
			a_point.set_X (width // 2 - (dictionary.Margin // 2) - dictionary.Button_width) 
			a_point.set_Y (height - 3 * dictionary.Margin - dictionary.Button_height)
			ok_button.set_location (a_point)
			a_point.set_X (width // 2 + dictionary.Margin // 2)
			a_point.set_Y (height - 3 * dictionary.Margin - dictionary.Button_height)
			cancel_button.set_location (a_point)
			
				-- Resize and move `errors_list_view' if non Void
			if errors_list_view /= Void and then controls.contains (errors_list_view) then
				a_point.set_X (0)
				a_point.set_Y (height - 5 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)	
				errors_list_view.set_location (a_point)	
				a_size.set_width (width - dictionary.Margin // 2)
				a_size.set_height (4 * dictionary.Label_height)
				errors_list_view.set_size (a_size)	
			end
			refresh
		end
		
--	on_class_name_leave_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
--		indexing
--			description: "Action launched when a text box is entered"
--			external_name: "OnClassNameLeaveEventHandler"
--		require
--			non_void_sender: sender /= Void
--			non_void_arguments: arguments /= Void
--		local
--			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
--			a_font: SYSTEM_DRAWING_FONT
--		do
--			text_box ?= sender
--			if text_box /= Void and then text_box.text /= Void then
--				if type_modifications.old_name /= Void and then not type_modifications.old_name.tolower.equals_string (text_box.text.tolower) then
--					type_modifications.set_new_name (text_box.text)
--					if text_box.text.length > 0 then
--						create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
--						text_box.set_width (text_box_width_from_text (text_box.text, a_font))
--					end
--				end
--			end
--		end
--
--	on_class_name_enter (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
--		indexing
--			description: "Action launched when user presses `Enter' in the class name text box"
--			external_name: "OnClassNameEnter"
--		require
--			non_void_sender: sender /= Void
--			non_void_arguments: arguments /= Void
--		local
--			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
--			a_font: SYSTEM_DRAWING_FONT
--		do
--			if arguments.keycode = dictionary.Enter_key then
--				text_box ?= sender
--				if text_box /= Void and then text_box.text /= Void then
--					if type_modifications.old_name /= Void and then not type_modifications.old_name.tolower.equals_string (text_box.text.tolower) then
--						type_modifications.set_new_name (text_box.text)				
--						if text_box.text.length > 0 then
--							create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
--							text_box.set_width (text_box_width_from_text (text_box.text, a_font))
--						end
--					end
--				end
--			end
--		end
--	
	on_click (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action launched when a text box is entered"
			external_name: "OnClick"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			a_font: SYSTEM_DRAWING_FONT
		do
			if selected_text_box /= Void and then selected_text_box.text /= Void then
				if selected_text_box = class_name_text_box then
					if type_modifications.old_name /= Void and then not type_modifications.old_name.tolower.equals_string (selected_text_box.text.tolower) then
						type_modifications.set_new_name (selected_text_box.text)
						if selected_text_box.text.length > 0 then
							create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
							selected_text_box.set_width (text_box_width_from_text (selected_text_box.text, a_font))
						end
					end
				else
					save_feature_modifications (selected_text_box)
				end
			end
		end
		
	on_enter_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
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
			if selected_text_box /= Void and then selected_text_box.text /= Void then
				if selected_text_box = class_name_text_box then
					type_modifications.set_old_name (selected_text_box.text)
				else
					if feature_names_boxes.containskey (selected_text_box) then
						modified_feature ?= feature_names_boxes.item (selected_text_box)					
						create feature_modifications.make_from_info (selected_text_box.text)				
						
					elseif feature_arguments_boxes.containskey (selected_text_box) then
						an_array ?= feature_arguments_boxes.item (selected_text_box)
						if an_array /= Void and then an_array.count = 2 then
							modified_feature ?= an_array.item (0)
							if modified_feature /= Void then
								if type_modifications.features_modifications.contains (modified_feature) then
									feature_modifications ?= type_modifications.features_modifications.item (modified_feature)
								else
									create feature_modifications.make_from_info (modified_feature.eiffelname)
								end
							end									
						end							
					end
				end
			end
		end

	on_leave_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action launched when a text box is leaved"
			external_name: "OnLeaveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		do
			text_box ?= sender
			if text_box /= Void and then text_box.text /= Void then
				save_feature_modifications (text_box)
			end
		end

	on_enter_pressed (sender: ANY; arguments: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		indexing
			description: "Action launched when user presses `Enter' in a text box"
			external_name: "OnEnterPressed"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		do
			if arguments.keycode = dictionary.Enter_key then
				text_box ?= sender
				if text_box /= Void and then text_box.text /= Void then
				 	save_feature_modifications (text_box)
				end
			end
		end
		
	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
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
			xml_generator: ISE_REFLECTION_XMLCODEGENERATOR
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			a_size: SYSTEM_DRAWING_SIZE
			regenerate_eiffel_classes_delegate: SYSTEM_EVENTHANDLER	
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			normal_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
			retried: BOOLEAN
			message_box: MESSAGE_BOX
		do
			if not retried then
				wait_cursor := cursors.WaitCursor
				set_cursor (wait_cursor)
				create type_view_handler.make (eiffel_class, type_modifications, Current)
				type_view_handler.check_and_update
				normal_cursor := cursors.Arrow
				set_cursor (normal_cursor)
				if not type_view_handler.is_valid then
					cancel_button.set_enabled (False)
					a_size.set_width (width - dictionary.Margin // 2)
					a_size.set_height (height - 6 * dictionary.Margin - 7 * dictionary.Label_height - dictionary.Button_height)
					panel.set_size (a_size)
					if errors_list_view /= Void and then controls.contains (errors_list_view) then
						controls.remove (errors_list_view)
					end
					display_errors (type_view_handler.class_error_message, type_view_handler.errors_in_features, type_view_handler.errors_in_arguments)
					refresh
				else
					close
					eiffel_class := type_view_handler.eiffel_class
					if type_modifications.features_modifications /= Void and then type_modifications.features_modifications.count > 0 then
						eiffel_class.setmodified
					end
					children := type_view_handler.children
					assembly_view.set_children (eiffel_class, children)
					create xml_generator.make_xmlcodegenerator
					xml_generator.makexmlcodegenerator
					xml_generator.replacetype (assembly_descriptor, eiffel_class)
					from
					until
						i = children.count
					loop
						a_child ?= children.item (i)
						if a_child /= Void then
							xml_generator.replacetype (assembly_descriptor, a_child)
						end
						i := i + 1
					end
					assembly_view.update_gui
					create regenerate_eiffel_classes_delegate.make_eventhandler (Current, $regenerate_eiffel_classes)
					create message_box.make (dictionary.Eiffel_generation, regenerate_eiffel_classes_delegate)
				end
			else
				normal_cursor := cursors.Arrow
				set_cursor (normal_cursor)
			end
		end

	regenerate_eiffel_classes (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Open Eiffel generation dialog."
			external_name: "RegenerateEiffelClasses"
		require
			non_void_sender: sender /= Void
		local
			message_box: MESSAGE_BOX
			--assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			--assembly: SYSTEM_REFLECTION_ASSEMBLY
			--conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			--emitter: NEWEIFFELCLASSGENERATOR
			assembly_filename: STRING
			code_generator_from_xml: ISE_REFLECTION_EIFFELCODEGENERATORFROMXML
			support: ISE_REFLECTION_REFLECTIONSUPPORT
			type_filename: STRING
			a_child: ISE_REFLECTION_EIFFELCLASS
			i: INTEGER
			returned_value: INTEGER
			windows_message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX	
			eiffel_generation_dictionary: EIFFEL_GENERATION_DIALOG_DICTIONARY
			retried: BOOLEAN
			cursors: SYSTEM_WINDOWS_FORMS_CURSORS
			wait_cursor: SYSTEM_WINDOWS_FORMS_CURSOR
		do
			if not retried then
				message_box ?= sender
				if message_box /= Void then
					wait_cursor := cursors.WaitCursor
					message_box.set_cursor (wait_cursor)
					message_box.refresh
					--create conversion_support.make_conversionsupport
					--assembly_name := conversion_support.assemblynamefromdescriptor (assembly_descriptor)
					--assembly := assembly.load (assembly_name)
					--create emitter.make_neweiffelclassgenerator
					--emitter.generateeiffelclassesfromxml (assembly)
					create support.make_reflectionsupport
					support.make
					assembly_filename := support.Xmlassemblyfilename (assembly_descriptor)
					assembly_filename := assembly_filename.replace (support.Eiffelkey, support.Eiffeldeliverypath)
					if assembly_filename /= Void and then assembly_filename.length > 0 then
						create code_generator_from_xml.make1
						code_generator_from_xml.makefrominfo (assembly_filename)
						type_filename := support.Xmltypefilename (assembly_descriptor, eiffel_class.fullexternalname)
						type_filename := type_filename.replace (support.Eiffelkey, support. Eiffeldeliverypath)
						code_generator_from_xml.generateeiffelcodefromxml (type_filename)
						from
						until
							i = children.count
						loop
							a_child ?= children.item (i)
							if a_child /= Void then
								type_filename := support.Xmltypefilename (assembly_descriptor, a_child.fullexternalname)
								type_filename := type_filename.replace (support.Eiffelkey, support.Eiffeldeliverypath)
								code_generator_from_xml.generateeiffelcodefromxml (type_filename)
							end
							i := i + 1
						end
					end
					message_box.close
				end
			else
				message_box ?= sender
				if message_box /= Void then
					message_box.close
				end
				create eiffel_generation_dictionary
				returned_value := windows_message_box.show_string_string_messageboxbuttons_messageboxicon (eiffel_generation_dictionary.Eiffel_generation_error, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
			end
		rescue
			retried := True
			retry
		end
	
	on_cancel_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Process `cancel_button' activation."
			external_name: "OnCancelEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		do
			close
		end
	
feature {NONE} -- Implementation
	
	parents_handler: PARENTS_HANDLER
		indexing
			description: "Parents handler"
			external_name: "ParentsHandler"
		end
		
	modified_feature: ISE_REFLECTION_EIFFELFEATURE
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
	
	parents: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: parent name
			-- | Value: inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]])
		indexing
			description: "Class parents"
			external_name: "Parents"
		end
	
	selected_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		indexing
			description: "Lastly selected text box"
			external_name: "SelectedTextBox"
		end

	panel_height: INTEGER
		indexing
			description: "Height of panel inside before calling `build_inherit_clause'"
			external_name: "PanelHeight"
		end

	special_classes: ARRAY [STRING]
			-- | ["ANY", "INTEGER", "INTEGER_64", "INTEGER_16", "INTEGER_8", "CHARACTER",  "DOUBLE", "REAL", "BOOLEAN"]
		indexing
			description: "Special classes"
			external_name: "SpecialClasses"
		end

	feature_names_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: text box
			-- | Value: `ISE_REFLECTION_EIFFELFEATURE'
		indexing
			description: "Text boxes for feature names"
			external_name: "FeatureNamesBoxes"
		end

	feature_arguments_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: text box
			-- | Value: [ISE_REFLECTION_EIFFELFEATURE, ISE_REFLECTION_NAMEDSIGNATURETYPE]
		indexing
			description: "Text boxes for feature arguments"
			external_name: "FeatureArgumentsBoxes"
		end
		
	build_class_contract_form (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build editable contract form of `an_eiffel_class'."
			external_name: "BuildClassContractForm"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_position: SYSTEM_DRAWING_POINT
			an_external_clause: STRING
			an_external_name: STRING
			formatter: FORMATTER
			end_class: STRING
			external_class: STRING
			on_click_delegate: SYSTEM_EVENTHANDLER
			--on_class_name_enter_event_handler_delegate: SYSTEM_EVENTHANDLER
			--on_class_name_leave_event_handler_delegate: SYSTEM_EVENTHANDLER
			--class_name_width: INTEGER
			--a_font: SYSTEM_DRAWING_FONT
			--on_class_name_enter_delegate: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER
		do
			create panel.make_panel
			a_position.set_x (0)
			a_position.set_y (dictionary.Margin + 4 * dictionary.Label_height)
			panel.set_location (a_position)
			panel.set_borderstyle (0)
			panel.set_backcolor (dictionary.White_color)
			panel.set_autoscroll (True)
			controls.add (panel)
			create on_click_delegate.make_eventhandler (Current, $on_click)
			panel.add_click (on_click_delegate)
			
				-- Indexing clause
			create_label (eiffel_dictionary.Indexingkeyword, dictionary.Margin, dictionary.Margin, dictionary.Keyword_color, True)	
			
				-- External name
			an_external_clause := eiffel_dictionary.Externalnamekeyword
			an_external_clause := an_external_clause.concat_string_string (an_external_clause, eiffel_dictionary.Colon)
			create_label (an_external_clause, 3 * dictionary.Margin, dictionary.Margin + dictionary.Label_height, dictionary.Keyword_color, True)
			
			create formatter.make
			an_external_name := eiffel_dictionary.Invertedcomma
			an_external_name := an_external_name.concat_string_string_string (an_external_name, formatter.formatstrongname (an_eiffel_class.fullexternalname), eiffel_dictionary.Invertedcomma)
			create_label (an_external_name, 3 * dictionary.Margin + label_width, dictionary.Margin + dictionary.Label_height, dictionary.Comment_color, False)
			
				-- frozen
			if an_eiffel_class.IsFrozen then
				create_label (eiffel_dictionary.Frozenkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
			end				
				-- expanded
			if an_eiffel_class.IsExpanded then
				create_label (eiffel_dictionary.Expandedkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
			end
				-- deferred
			if an_eiffel_class.IsDeferred then
				create_label (eiffel_dictionary.Deferredkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
			end
			
				-- external class
				-- 	CLASS_NAME
			if an_eiffel_class.isfrozen or an_eiffel_class.isdeferred or an_eiffel_class.isexpanded then
				external_class :=	eiffel_dictionary.Externalkeyword
				external_class := external_class.concat_string_string_string (external_class, eiffel_dictionary.Space, eiffel_dictionary.Classkeyword)
				create_label (external_class, dictionary.Margin + label_width, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
			else
				create_label (eiffel_dictionary.Classkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
			end
			create class_name_text_box.make_textbox
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
			--class_name_width := text_box_width_from_text (an_eiffel_class.eiffelname.toupper, a_font)
			--set_text_box_properties (class_name_text_box, an_eiffel_class.eiffelname.toupper, 3 * dictionary.Margin, 2 * dictionary.Margin + 3 * dictionary.Label_height, class_name_width, dictionary.Class_color)
			create_label (an_eiffel_class.eiffelname.toupper, 3 * dictionary.Margin, 2 * dictionary.Margin + 3 * dictionary.Label_height, dictionary.Class_color, False)
			
			--create on_class_name_enter_event_handler_delegate.make_eventhandler (Current, $on_enter_event_handler)
			--class_name_text_box.add_gotfocus (on_class_name_enter_event_handler_delegate)
			--create on_class_name_leave_event_handler_delegate.make_eventhandler (Current, $on_class_name_leave_event_handler)
			--class_name_text_box.add_lostfocus (on_class_name_leave_event_handler_delegate)
			--create on_class_name_enter_delegate.make_keyeventhandler (Current, $on_class_name_enter)
			--class_name_text_box.add_keydown (on_class_name_enter_delegate)
			
			panel_height := 2 * dictionary.Margin + 4 * dictionary.Label_height
			
				-- inherit
				-- 	PARENT_NAME
				-- 		rename ... undefine ... redefine ... end
			build_inherit_clause (an_eiffel_class)

			create feature_names_boxes.make
			create feature_arguments_boxes.make
			
				-- `create {NONE}' or `create make ...'
			build_create_clause (an_eiffel_class)
			
				-- Generate class features (except initialization ones).
			build_class_features (an_eiffel_class)

				-- `end -- class CLASS_NAME'
			end_class := eiffel_dictionary.Endkeyword
			end_class := end_class.concat_string_string_string_string (end_class, eiffel_dictionary.Space, eiffel_dictionary.Dashes, eiffel_dictionary.Space)
			end_class := end_class.concat_string_string (end_class, eiffel_dictionary.Classkeyword)
			create_label (end_class, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
			create_label (an_eiffel_class.eiffelname.toupper, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
			end_class_name_label := created_label
		end
	
	create_label (a_text: STRING; x_position, y_position: INTEGER; a_color: SYSTEM_DRAWING_COLOR; is_bold_font: BOOLEAN) is
		indexing
			description: "[Create a text box with text `a_text' at position (x_position, y_position).%
					%Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).]"
			external_name: "CreateLabel"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			non_void_color: a_color /= Void
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
			a_label.set_forecolor (a_color)
			if is_bold_font then 
				create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			else
				create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style)
			end
			a_label.set_font (a_font)
			panel.controls.add (a_label)
			label_width := a_label.width
			created_label := a_label
		end
	
	create_form_label (a_text: STRING; x_position, y_position: INTEGER) is
		indexing
			description: "[Create a text box with text `a_text' at position (x_position, y_position).%
					%Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).]"
			external_name: "CreateFormLabel"
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
			a_label.set_textalign (dictionary.Align_left)
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
			a_label.set_font (a_font)
			controls.add (a_label)
	end	
		
	set_editable_text_box_properties (a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: SYSTEM_DRAWING_COLOR) is
		indexing
			description: "[Set `a_text_box' position: (x_position, y_position).%
					%Set `a_text_box' size (a_width, Label_height).%
					%Set font color with `a_color'.]"
			external_name: "SetEditableTextBoxProperties"
		require
			non_void_text_box: a_text_box /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			positive_width: a_width >= 0
			non_void_color: a_color /= Void
		local
			on_enter_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_leave_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_enter_pressed_delegate: SYSTEM_WINDOWS_FORMS_KEYEVENTHANDLER
		do		
			set_text_box_properties (a_text_box, a_text, x_position, y_position, a_width, a_color)
			create on_enter_event_handler_delegate.make_eventhandler (Current, $on_enter_event_handler)
			a_text_box.add_gotfocus (on_enter_event_handler_delegate)
			create on_leave_event_handler_delegate.make_eventhandler (Current, $on_leave_event_handler)
			a_text_box.add_lostfocus (on_leave_event_handler_delegate)
			create on_enter_pressed_delegate.make_keyeventhandler (Current, $on_enter_pressed)
			a_text_box.add_keydown (on_enter_pressed_delegate)
		end

	set_text_box_properties (a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: SYSTEM_DRAWING_COLOR) is
		indexing
			description: "[Set `a_text_box' position: (x_position, y_position).%
					%Set `a_text_box' size (a_width, Label_height).%
					%Set font color with `a_color'.]"
			external_name: "SetTextBoxProperties"
		require
			non_void_text_box: a_text_box /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			valid_x_position: x_position >= 0
			valid_y_position: y_position >= 0
			positive_width: a_width >= 0
			non_void_color: a_color /= Void
		local
			a_point: SYSTEM_DRAWING_POINT
			a_size: SYSTEM_DRAWING_SIZE
			a_font: SYSTEM_DRAWING_FONT
		do		
			a_point.set_X (x_position)
			a_point.set_Y (y_position)
			a_text_box.set_location (a_point)
			a_text_box.set_text (a_text)
			a_size.set_height (dictionary.Label_height)
			a_size.set_width (a_width)
			a_text_box.set_size (a_size)
			a_text_box.set_borderstyle (0)
			a_text_box.set_textalign (0)
			a_text_box.set_forecolor (a_color)
			a_text_box.set_backcolor (dictionary.Editable_color)
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
			a_text_box.set_font (a_font)
			panel.controls.add (a_text_box)
		end
		
	build_inherit_clause (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build inherit clause"
			external_name: "BuildInheritClause"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local			
			parents_names: SYSTEM_COLLECTIONS_ICOLLECTION
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR			
			a_parent: STRING
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
			rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			formatted_parents: ARRAY [STRING]
			i: INTEGER
		do
			label_width := 0
			parents := an_eiffel_class.Parents
			
			if parents.Count > 1 or has_any_in_clause or (parents.Count = 1 and (not parents.Contains (eiffel_dictionary.Anyclass))) then
				create_label (eiffel_dictionary.Inheritkeyword, dictionary.Margin, dictionary.Margin + panel_height, dictionary.Keyword_color, True)
				panel_height := panel_height + dictionary.Label_height + dictionary.Margin
				
				parents_names := parents.Keys
				enumerator := parents_names.GetEnumerator
				from
					create formatted_parents.make (parents.Count)
				until
					not enumerator.MoveNext
				loop
					a_parent ?= enumerator.Current_
					if a_parent /= Void then
						formatted_parents.put (i, a_parent)
					end
					i := i + 1
				end
				
				from
					i := formatted_parents.count - 1
				until
					i = -1
				loop
					a_parent := formatted_parents.item (i)
					if a_parent /= Void then
						if (not a_parent.equals_string (eiffel_dictionary.Anyclass)) or has_any_in_clause then
							create_label (a_parent, 3 * dictionary.Margin, panel_height, dictionary.Class_color, False)
						end
					end
					panel_height := panel_height + dictionary.Label_height
					
					inheritance_clauses ?= parents.Item (a_parent)
					if inheritance_clauses /= Void then
							-- rename clauses
						if inheritance_clauses.Item (0).Count > 0 then
							create_label (eiffel_dictionary.Renamekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							rename_clauses := inheritance_clauses.Item (0)
							if rename_clauses /= Void and then rename_clauses.Count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (rename_clauses) 
								panel_height := rename_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- undefine clauses
						if inheritance_clauses.Item (1).Count > 0 then
							create_label (eiffel_dictionary.Undefinekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							undefine_clauses := inheritance_clauses.Item (1)
							if undefine_clauses /= Void and then undefine_clauses.Count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (undefine_clauses)
								panel_height := undefine_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- redefine clauses
						if inheritance_clauses.Item (2).Count > 0 then
							create_label (eiffel_dictionary.Redefinekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							redefine_clauses := inheritance_clauses.Item (2)
							if redefine_clauses /= Void and then redefine_clauses.Count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (redefine_clauses) 
								panel_height := redefine_clauses.count * dictionary.Label_height + panel_height
							end
						end

							-- select clauses
						if inheritance_clauses.Item (3).Count > 0 then
							create_label (eiffel_dictionary.Selectkeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							select_clauses := inheritance_clauses.Item (3)
							if select_clauses /= Void and then select_clauses.Count > 0 then
								panel_height := panel_height + dictionary.Label_height
								build_inheritance_clauses (select_clauses)
								panel_height := select_clauses.count * dictionary.Label_height + panel_height
							end
						end
						
							-- Add `end' keyword at the end of inheritance clauses
						if inheritance_clauses.Item (0).Count > 0 or inheritance_clauses.Item (1).Count > 0 or inheritance_clauses.Item (2).Count > 0 or inheritance_clauses.item (3).count > 0 then
							create_label (eiffel_dictionary.Endkeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
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
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			if parents.ContainsKey (eiffel_dictionary.Anyclass) then
				inheritance_clauses ?= parents.Item (eiffel_dictionary.Anyclass)
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
		
	build_inheritance_clauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | Add text box to `a_table' for `parent_number'-th parent. 
		indexing
			description: "Build inheritance clauses from `clauses'."
			external_name: "BuildInheritanceClauses"
		require
			non_void_clauses: clauses /= Void
			not_empty_clauses: clauses.Count > 0
		local
			i: INTEGER
			a_clause: ISE_REFLECTION_INHERITANCECLAUSE
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		do
			from
			until
				i = clauses.Count
			loop
				a_clause ?= clauses.Item (i)
				if a_clause /= Void then
					create a_text_box.make_textbox
					if i < (clauses.Count - 1) then
						create_label (a_clause.tostring.concat_string_string (a_clause.tostring, eiffel_dictionary.Comma), 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
					else
						create_label (a_clause.tostring, 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
					end
				end
				i := i + 1
			end
		end

	build_create_clause (an_eiffel_class: like eiffel_class) is 
		indexing 
			description: "Build create clause."
			external_name: "BuildCreateClause"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local	
			creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_routine: STRING
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			initialization_features: SYSTEM_COLLECTIONS_ARRAYLIST
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			new_label_width: INTEGER
		do
			label_width := 0
			creation_routines := an_eiffel_class.CreationRoutines
			
			create special_classes.make (9)
			special_classes.put (0, eiffel_dictionary.Anyclass)
			special_classes.put (1, eiffel_dictionary.Integerclass)
			special_classes.put (2, eiffel_dictionary.Integer64class)
			special_classes.put (3, eiffel_dictionary.Integer16class)
			special_classes.put (4, eiffel_dictionary.Integer8class)
			special_classes.put (5, eiffel_dictionary.Characterclass)
			special_classes.put (6, eiffel_dictionary.Doubleclass)
			special_classes.put (7, eiffel_dictionary.Realclass)
			special_classes.put (8, eiffel_dictionary.Booleanclass)

			if an_eiffel_class.CreationRoutines.Count > 0 and not an_eiffel_class.IsDeferred and not is_special_class (an_eiffel_class) then			
					-- Do not generate creation clause for expanded classes
				if not an_eiffel_class.IsExpanded then
					create_label (eiffel_dictionary.Createkeyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
					panel_height := panel_height + dictionary.Label_height + dictionary.Margin
					from
						i := 0
					until
						i = creation_routines.Count
					loop
						a_routine ?= creation_routines.Item (i)
						if a_routine /= Void and then a_routine.Length > 0 then
							create a_text_box.make_textbox
							if i < (creation_routines.Count - 1) then
								create_label (a_routine.concat_string_string (a_routine, eiffel_dictionary.Comma), 3 * dictionary.Margin, panel_height + i * dictionary.Label_height, dictionary.Feature_color, False)
							else
								create_label (a_routine, 3 * dictionary.Margin, panel_height + i * dictionary.Label_height, dictionary.Feature_color, False)
							end
						end
						i := i + 1
					end
					panel_height := panel_height + dictionary.Label_height * creation_routines.count
				end				
			elseif an_eiffel_class.CreationRoutines.Count = 0 and not an_eiffel_class.IsDeferred and an_eiffel_class.CreateNone then
				create_label (eiffel_dictionary.Createkeyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				panel_height := panel_height + dictionary.Label_height + dictionary.Margin
			end
			
			if an_eiffel_class.InitializationFeatures.Count > 0 and not an_eiffel_class.IsDeferred and not is_special_class (an_eiffel_class) then
					-- Generate initialization feature clause.
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				new_label_width := dictionary.Margin + label_width
				create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Initialization_comment, new_label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				initialization_features := an_eiffel_class.InitializationFeatures
				from
					i := 0
				until
					i = initialization_features.count
				loop
					a_feature ?= initialization_features.Item (i)
					if a_feature /= Void then
						build_eiffel_feature (an_eiffel_class, a_feature)
					end
					i := i + 1
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
			i: INTEGER
		do
			from
			until
				i = special_classes.count or Result
			loop
				Result := an_eiffel_class.eiffelname.equals_string (special_classes.item (i))
				i := i + 1
			end
		end

	build_class_features (an_eiffel_class: like eiffel_class) is
		indexing
			description: "Build class features from `an_eiffel_class', except initialization ones."
			external_name: "BuildClassFeatures"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			access_features: SYSTEM_COLLECTIONS_ARRAYLIST
			element_change_features: SYSTEM_COLLECTIONS_ARRAYLIST
			basic_operations_features: SYSTEM_COLLECTIONS_ARRAYLIST
			unary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST
			binary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST
			specials_features: SYSTEM_COLLECTIONS_ARRAYLIST
			implementation_features: SYSTEM_COLLECTIONS_ARRAYLIST
		do	
			label_width := 0
			
				-- Generate access feature clause.
			access_features := an_eiffel_class.AccessFeatures
			if access_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Access_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, access_features)
			end	
				
				-- Generate element change feature clause.
			element_change_features := an_eiffel_class.ElementChangeFeatures
			if element_change_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Element_change_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height				
				intern_build_class_features (an_eiffel_class, element_change_features)
			end					

				-- Generate basic operations feature clause.
			basic_operations_features := an_eiffel_class.BasicOperations
			if basic_operations_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Basic_operations_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, basic_operations_features)
			end	

				-- Generate unary operators feature clause.
			unary_operators_features := an_eiffel_class.UnaryOperatorsFeatures
			if unary_operators_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Unary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, unary_operators_features)
			end	

				-- Generate binary operators feature clause.
			binary_operators_features := an_eiffel_class.BinaryOperatorsFeatures
			if binary_operators_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Binary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, binary_operators_features)
			end	

				-- Generate specials feature clause.
			specials_features := an_eiffel_class.SpecialFeatures
			if specials_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Specials_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, specials_features)
			end	

				-- Generate implementation feature clause.
			implementation_features := an_eiffel_class.ImplementationFeatures
			if implementation_features.Count > 0 then
				create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Implementation_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				intern_build_class_features (an_eiffel_class, implementation_features)
			end
		end

	intern_build_class_features (an_eiffel_class: like eiffel_class; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | Call in loop `build_eiffel_feature'.
		indexing
			description: "Build class features from `a_list'."
			external_name: "InternBuildClassFeatures"
		require
			non_void_list: a_list /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
			until
				i = a_list.Count
			loop
				a_feature ?= a_list.Item (i)
				if a_feature /= Void and then (a_feature.EiffelName /= Void and a_feature.EiffelName.Length > 0) then
					build_eiffel_feature (an_eiffel_class, a_feature)
					panel_height := panel_height + dictionary.Margin
				end
				i := i + 1
			end		
		end

	build_eiffel_feature (an_eiffel_class: like eiffel_class; a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		indexing
			description: "Generate Eiffel feature from `a_feature' and `an_eiffel_class'."
			external_name: "BuildEiffelFeature"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_name: a_feature.EiffelName /= Void
			not_empty_feature_name: a_feature.EiffelName.Length > 0
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			is_unary_operator: BOOLEAN
			feature_name: STRING
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			tmp_label: SYSTEM_WINDOWS_FORMS_LABEL
			feature_name_width: INTEGER
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
			argument_name: STRING
			argument_type: STRING
			argument_name_width: INTEGER
			argument_type_width: INTEGER
			new_label_width: INTEGER
			a_font: SYSTEM_DRAWING_FONT
			an_array: ARRAY [ANY]
			is_editable_feature: BOOLEAN
		do
			is_unary_operator := an_eiffel_class.UnaryOperatorsFeatures.Contains (a_feature)	
			label_width := 0
			create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
			is_editable_feature := True--not parents_handler.is_inherited_feature (a_feature.eiffelname)
			
				-- frozen
			if a_feature.IsFrozen then
				create_label (eiffel_dictionary.Frozenkeyword, 3 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
			end
				
				-- feature name
			create a_text_box.make_textbox
			create tmp_label.make_label
			new_label_width := 3 * dictionary.Margin + label_width
			if is_unary_operator and a_feature.IsPrefix then				
				create_label (eiffel_dictionary.Prefixkeyword, new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
				if a_feature.iscreationroutine then
					create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
					feature_name_width := label_width
				else					
					if is_editable_feature then
						feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)
						set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
					else
						create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)
						feature_name_width := label_width
					end
				end
			else
				if a_feature.IsInfix then
					create_label (eiffel_dictionary.Infixkeyword, new_label_width, panel_height, dictionary.Keyword_color, True)
					new_label_width := new_label_width + label_width
					if a_feature.iscreationroutine then
						create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						if is_editable_feature then
							feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)		
							set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
						else
							create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)
							feature_name_width := label_width
						end
					end
				else
					if a_feature.iscreationroutine then
						create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						if is_editable_feature then
							feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)			
							set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
						else
							create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)
							feature_name_width := label_width
						end
					end
				end
			end
			new_label_width := new_label_width +  feature_name_width
			feature_names_boxes.add (a_text_box, a_feature)
			
				-- feature arguments
			arguments := a_feature.Arguments
			if not is_unary_operator and arguments.Count > 0 then
				create_label (eiffel_dictionary.Openingroundbracket, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				from
					 i := 0
				until
					i = arguments.Count 
				loop
					an_argument ?= arguments.Item (i)
					if an_argument /= Void then						
						argument_name := an_argument.eiffelname
						argument_type := an_argument.typeeiffelname
					end
					if a_feature.iscreationroutine then
						create_label (argument_name, new_label_width, panel_height, dictionary.Feature_color, False)
						new_label_width := new_label_width + label_width 
					else
						create a_text_box.make_textbox
						if is_editable_feature then
							argument_name_width := text_box_width_from_text (argument_name, a_font)				
							set_editable_text_box_properties (a_text_box, argument_name, new_label_width, panel_height, argument_name_width, dictionary.Feature_color)
						else
							create_label (argument_name, new_label_width, panel_height, dictionary.Feature_color, False)
							argument_name_width := label_width
						end
						new_label_width := new_label_width + argument_name_width 
						create an_array.make (2)
						an_array.put (0, a_feature)
						an_array.put (1, an_argument)
						feature_arguments_boxes.add (a_text_box, an_array)
					end
					create_label (eiffel_dictionary.Colon, new_label_width, panel_height, dictionary.Text_color, False)
					new_label_width := new_label_width + label_width
					
					create_label (argument_type, new_label_width, panel_height, dictionary.Class_color, False)
					new_label_width := new_label_width + label_width
					
					if i < (arguments.Count - 1) then
						create_label (eiffel_dictionary.Semicolon, new_label_width, panel_height, dictionary.Text_color, False)
						new_label_width := new_label_width + label_width
					end
					i := i + 1
				end
				create_label (eiffel_dictionary.Closingroundbracket, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
			end
		
				-- feature return type
			if a_feature.IsMethod and then a_feature.ReturnType /= Void and then a_feature.returntype.typeeiffelname /= Void and then a_feature.returntype.typeeiffelname.length > 0 then
				create_label (eiffel_dictionary.Colon, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width 
				create_label (a_feature.returntype.typeeiffelname, new_label_width, panel_height, dictionary.Class_color, False)
			end
			if a_feature.IsField and not a_feature.EiffelName.StartsWith (eiffel_dictionary.Propertysetprefix) then
				create_label (eiffel_dictionary.Colon, new_label_width, panel_height, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (a_feature.returntype.typeeiffelname, new_label_width, panel_height, dictionary.Class_color, False)
			end
			panel_height := panel_height + dictionary.Label_height
		end	
	
	text_box_width_from_text (a_text: STRING; a_font: SYSTEM_DRAWING_FONT): INTEGER is
			-- | FIXME: Should disappear if we can find a feature giving the length of a string in pixels.
		indexing
			description: "Width of text box with text `a_text' and font `a_font'."
			external_name: "TextBoxWidthFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
			non_void_font: a_font /= Void
		local
			tmp_label: SYSTEM_WINDOWS_FORMS_LABEL
		do
			create tmp_label.make_label
			tmp_label.set_text (a_text)
			tmp_label.set_autosize (True)
			tmp_label.set_font (a_font)
			Result := tmp_label.width		
		end

	save_feature_modifications (text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX) is
		indexing
			description: "Save user modifications on the feature."
			external_name: "SaveFeatureModifications"
		require
			non_void_text_box: text_box /= Void
		local
			an_array: ARRAY [ANY]
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE	
		do
			if feature_names_boxes.containskey (text_box) and feature_modifications /= Void and modified_feature /= Void then
				if feature_modifications.old_feature_name /= Void and then not feature_modifications.old_feature_name.tolower.equals_string (text_box.text.tolower) then
					feature_modifications.set_new_feature_name (text_box.text)
					type_modifications.add_feature_modification (modified_feature, feature_modifications)
				end
			elseif feature_arguments_boxes.containskey (text_box) then
				an_array ?= feature_arguments_boxes.item (text_box)
				if an_array /= Void and then an_array.count = 2 then
					a_feature ?= an_array.item (0)
					an_argument ?= an_array.item (1)
					if (a_feature /= Void and then a_feature = modified_feature) and an_argument /= Void then
						if not an_argument.eiffelname.tolower.equals_string (text_box.text.tolower) then
							feature_modifications.add_argument_modification (an_argument, text_box.text)
							type_modifications.add_feature_modification (modified_feature, feature_modifications)
						end
					end									
				end							
			end
			feature_modifications := Void
			modified_feature := Void
		end
		
	errors_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW
		indexing
			description: "Errors list view"
			external_name: "ErrorsListView"
		end
	
	errors_table: SYSTEM_COLLECTIONS_HASHTABLE
		indexing
			description: "Key: Line number in list view; Value: Text box"
			external_name: "ErrorsTable"
		end
		
	display_errors (class_error_message: STRING; errors_in_features, errors_in_arguments: SYSTEM_COLLECTIONS_HASHTABLE) is
		indexing
			description: "Build errors list view from `class_error_message', errors_in_features' and `errors_in_arguments' and display it."
			external_name: "ErrorsListView"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
			an_array: ARRAY [ANY]
			an_error_message: STRING
			list_view_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			on_item_delegate: SYSTEM_EVENTHANDLER		
		do
			create errors_list_view.make_listview
			errors_list_view.set_borderstyle (dictionary.List_view_border_style)
			errors_list_view.set_checkboxes (False)
			errors_list_view.set_fullrowselect (True)
			errors_list_view.set_gridlines (True)
			errors_list_view.set_multiselect (False)
			errors_list_view.set_sorting (0)
			errors_list_view.set_view (dictionary.View)
			errors_list_view.set_activation (0)
			errors_list_view.set_alignment (dictionary.Alignment)
			errors_list_view.set_scrollable (True)
			errors_list_view.set_tabindex (0)			
			a_point.set_X (0)
			a_point.set_Y (height - 5 * dictionary.Margin - 3 * dictionary.Label_height - dictionary.Button_height)	
			errors_list_view.set_location (a_point)			
			a_size.set_width (width - dictionary.Margin // 2)
			a_size.set_height (4 * dictionary.Label_height)
			errors_list_view.set_size (a_size)	
			
			create errors_table.make
			if class_error_message /= Void and then class_error_message.length > 0 then
				create list_view_item.make_1 (message_from_class_error (class_error_message))
				list_view_item.set_forecolor (dictionary.Red_color)
				list_view_item := errors_list_view.items.add_listviewitem (list_view_item)
				errors_table.add (0, class_name_text_box)
			end
			
			if errors_in_features /= Void and then errors_in_features.count > 0 then
				enumerator := errors_in_features.keys.getenumerator
				from
				until
					not enumerator.movenext
				loop
					a_feature ?= enumerator.current_
					if a_feature /= Void then
						an_error_message ?= errors_in_features.item (a_feature)
						if an_error_message /= Void and then an_error_message.length > 0 then
							create list_view_item.make_1 (message_from_feature_error (a_feature, an_error_message))
							list_view_item.set_forecolor (dictionary.Red_color)
							list_view_item := errors_list_view.items.add_listviewitem (list_view_item)
							errors_table.add (errors_list_view.items.count - 1, feature_text_box (a_feature))
						end
					end
				end
			end
			
			if errors_in_arguments /= Void and then errors_in_arguments.count > 0 then
				enumerator := errors_in_arguments.keys.getenumerator
				from
				until
					not enumerator.movenext
				loop
					an_array ?= enumerator.current_
					if an_array /= Void then
						a_feature ?= an_array.item(0)
						an_argument ?= an_array.item (1)
						if a_feature /= Void and an_argument /= Void then
							an_error_message ?= errors_in_arguments.item (an_array)
							if an_error_message /= Void and then an_error_message.length > 0 then
								create list_view_item.make_1 (message_from_argument_error (a_feature, an_argument, an_error_message))
								list_view_item.set_forecolor (dictionary.Red_color)
								list_view_item := errors_list_view.items.add_listviewitem (list_view_item)
								errors_table.add (errors_list_view.items.count - 1, argument_text_box (an_argument, a_feature))
							end
						end
					end
				end
			end	
			create on_item_delegate.make_eventhandler (Current, $on_item)
			errors_list_view.add_Click (on_item_delegate)
			controls.add (errors_list_view)
		end

	message_from_class_error (an_error_message: STRING): STRING is
		indexing
			description: "Error message from`an_error_message'"
			external_name: "MessageFromClassError"
		require
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.length > 0		
		do
			Result := dictionary.Error
			Result := Result.concat_string_string_string_string (Result, dictionary.Space, dictionary.Opening_round_bracket, dictionary.Class_name)
			Result := Result.concat_string_string_string_string (Result, dictionary.Closing_round_bracket, dictionary.Colon, dictionary.Space)
			Result := Result.concat_string_string (Result, an_error_message)		
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.length > 0		
		end
		
	message_from_feature_error (a_feature: ISE_REFLECTION_EIFFELFEATURE; an_error_message: STRING): STRING is
		indexing
			description: "Error message from `a_feature' and `an_error_message'"
			external_name: "MessageFromFeatureError"
		require
			non_void_feature: a_feature /= Void
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.length > 0
		do
			Result := dictionary.Error
			Result := Result.concat_string_string_string_string (Result, dictionary.Space, dictionary.Opening_round_bracket, dictionary.Feature_string)
			Result := Result.concat_string_string_string_string (Result, dictionary.Colon, dictionary.Space, a_feature.eiffelname)
			Result := Result.concat_string_string_string_string (Result, dictionary.Closing_round_bracket, dictionary.Colon, dictionary.Space)
			Result := Result.concat_string_string (Result, an_error_message)
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.length > 0
		end

	message_from_argument_error (a_feature: ISE_REFLECTION_EIFFELFEATURE; an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE; an_error_message: STRING): STRING is
		indexing
			description: "Error message from `a_feature' and `an_error_message'"
			external_name: "MessageFromFeatureError"
		require
			non_void_feature: a_feature /= Void
			non_void_error_message: an_error_message /= Void
			not_empty_error_message: an_error_message.length > 0
			non_void_argument: an_argument /= Void
		do
			Result := dictionary.Error
			Result := Result.concat_string_string_string_string (Result, dictionary.Space, dictionary.Opening_round_bracket, dictionary.Feature_string)
			Result := Result.concat_string_string_string_string (Result, dictionary.Colon, dictionary.Space, a_feature.eiffelname)
			Result := Result.concat_string_string_string_string (Result, dictionary.Comma_separator, dictionary.Space, dictionary.Argument_string)
			Result := Result.concat_string_string_string_string (Result, Dictionary.Colon, dictionary.Space, an_argument.eiffelname)
			Result := Result.concat_string_string_string_string (Result, dictionary.Closing_round_bracket, dictionary.Colon, dictionary.Space)
			Result := Result.concat_string_string (Result, an_error_message)
		ensure
			non_void_error_message: Result /= Void
			not_empty_error_message: Result.length > 0
		end
	
	on_item (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		indexing
			description: "Action performed when user clicks on an item in the errors list view"
			external_name: "OnItem"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			selected_items: SELECTEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW		
			is_focused: BOOLEAN
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
		do
			selected_items := errors_list_view.selecteditems
			if selected_items /= Void then
				check
					only_one_item_selected: selected_items.count = 1
				end
				a_text_box ?= errors_table.item (selected_items.item (0).index)
				if a_text_box /= Void then
					is_focused := a_text_box.focus
					a_text_box.select_
				end
			end
		end

	feature_text_box (a_feature: ISE_REFLECTION_EIFFELFEATURE): SYSTEM_WINDOWS_FORMS_TEXTBOX is
		indexing
			description: "Text box corresponding to `a_feature'."
			external_name: "FeatureTextBox"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_names_text_boxes: feature_names_boxes /= Void
			is_in_feature_names_text_boxes: feature_names_boxes.containsvalue (a_feature)
		local
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			corresponding_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			enumerator := feature_names_boxes.keys.getenumerator
			from
			until
				not enumerator.movenext or Result /= Void 
			loop
				a_text_box ?= enumerator.current_
				if a_text_box /= Void then
					corresponding_feature ?= feature_names_boxes.item (a_text_box)
					if corresponding_feature /= Void and then corresponding_feature.eiffelname.tolower.equals_string (a_feature.eiffelname.tolower) then
						Result := a_text_box
					end
				end
			end
		ensure
			non_void_text_box: Result /= Void
		end

	argument_text_box (an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE; a_feature: ISE_REFLECTION_EIFFELFEATURE): SYSTEM_WINDOWS_FORMS_TEXTBOX is
		indexing
			description: "Text box corresponding to `an_argument' in feature `a_feature'."
			external_name: "ArgumentTextBox"
		require
			non_void_feature: a_feature /= Void
			non_void_arguments: an_argument /= Void
			non_void_feature_arguments_boxes: feature_arguments_boxes /= Void
		local
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			an_array: ARRAY [ANY]
			corresponding_feature: ISE_REFLECTION_EIFFELFEATURE
			corresponding_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
		do
			enumerator := feature_arguments_boxes.keys.getenumerator
			from
			until
				not enumerator.movenext or Result /= Void 
			loop
				a_text_box ?= enumerator.current_
				if a_text_box /= Void then
					an_array ?= feature_arguments_boxes.item (a_text_box)
					if an_array /= Void then
						corresponding_feature ?= an_array.item (0)
						corresponding_argument ?= an_array.item (1)				
						if (corresponding_feature /= Void and then corresponding_feature.eiffelname.tolower.equals_string (a_feature.eiffelname.tolower)) and (corresponding_argument /= Void and then corresponding_argument.eiffelname.tolower.equals_string (an_argument.eiffelname.tolower)) then
							Result := a_text_box
						end
					end
				end
			end
		ensure
			non_void_text_box: Result /= Void
		end
		
invariant
	non_void_type_modifications: type_modifications /= Void
	
end -- class TYPE_VIEW
