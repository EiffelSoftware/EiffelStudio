indexing
	description: "List the features of currently selected type."
	external_name: "ISE.AssemblyManager.TypeView"

class
	TYPE_VIEW

inherit
	SYSTEM_WINDOWS_FORMS_FORM

create
	make

feature {NONE} -- Initialization

	make (an_assembly_descriptor: like assembly_descriptor; an_eiffel_class: like eiffel_class; children_list: like children; an_assembly_view: like assembly_view) is
			-- Set `assembly_descriptor' with `an_assembly_descriptor'.
			-- Set `eiffel_class' with `an_eiffel_class'.
			-- Set `assembly_view' with `an_assembly_view'.
		indexing
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
			create dictionary
			assembly_descriptor := an_assembly_descriptor
			eiffel_class := an_eiffel_class
			children := children_list
			assembly_view := an_assembly_view
			create eiffel_dictionary.make_eiffelcodegeneratordictionary
			create type_view_handler.make (eiffel_class, Current)
			initialize_gui
			return_value := showdialog
		ensure
			assembly_descriptor_set: assembly_descriptor = an_assembly_descriptor
			eiffel_class_set: eiffel_class = an_eiffel_class
			children_set: children = children_list
			assembly_view_set: assembly_view = an_assembly_view
			non_void_type_view_handler: type_view_handler /= Void
		end

feature -- Access

	dictionary: TYPE_VIEW_DICTIONARY
			-- Dictionary
		indexing
			external_name: "Dictionary"
		end
		
	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end
		
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
			-- Eiffel class
		indexing
			external_name: "EiffelClass"
		end
		
	children: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- Children of `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "Children"
		end
	
	assembly_view: ASSEMBLY_VIEW
			-- Assembly view
		indexing
			external_name: "AssemblyView"
		end
		
	assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Assembly types
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "AssemblyTypes"
		require
			non_void_assembly_view: assembly_view /= Void
		once
			Result := assembly_view.type_list
		ensure
			assembly_types_created: Result /= Void
		end
	
	eiffel_dictionary: ISE_REFLECTION_EIFFELCODEGENERATORDICTIONARY
			-- Dictionary
		indexing
			external_name: "EiffelDictionary"
		end
	
	type_modifications: TYPE_MODIFICATIONS is
			-- Type modifications
		indexing
			external_name: "TypeModifications"
		once
			create Result.make
			--Result.set_full_external_name (eiffel_class.fullexternalname)
		ensure
			type_modifications_created: Result /= Void
			--full_external_name_set: Result.full_external_name.equals_string (eiffel_class.fullexternalname)
		end
		
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- OK button
		indexing
			external_name: "OkButton"
		end

	cancel_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- cancel button
		indexing
			external_name: "CancelButton"
		end

	panel: SYSTEM_WINDOWS_FORMS_PANEL
			-- Panel with class contract form
		indexing
			external_name: "Panel"
		end

	class_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Class name text box
		indexing
			external_name: "ClassNameTextBox"
		end

	end_class_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Class name label
		indexing
			external_name: "EndClassNameLabel"
		end
	
	label_width: INTEGER 
			-- Width of label created by `create_label'.
		indexing
			external_name: "LabelWidth"
		end

	created_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Label created by `create_label'.
		indexing
			external_name: "CreatedLabel"
		end

	error_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Error text box
		indexing
			external_name: "ErrorTextBox"
		end
		
feature -- Constants
	
	Border_style: INTEGER is 3
			-- Window border style: a fixed, single line border
		indexing
			external_name: "BorderStyle"
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
		
	Label_font_size: REAL is 10.0
			-- Label font size
		indexing
			external_name: "LabelFontSize"
		end
	
	Font_size: REAL is 8.0
			-- Font size
		indexing
			external_name: "FontSize"
		end
		
	Bold_style: INTEGER is 1
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end

	Regular_style: INTEGER is 0
			-- Regular style
		indexing
			external_name: "RegularStyle"
		end

	Italic_style: INTEGER is 2
			-- Italic style
		indexing
			external_name: "ItalicStyle"
		end
		
	Button_height: INTEGER is 23
			-- Button height
		indexing
			external_name: "ButtonHeight"
		end
	
	Button_width: INTEGER is 75
			-- Button height
		indexing
			external_name: "ButtonWidth"
		end
	
	Initialization: INTEGER is 1
			-- Constant corresponding to initialization feature clause
		indexing
			external_name: "Initialization"
		end

	Access: INTEGER is 2
			-- Constant corresponding to access feature clause
		indexing
			external_name: "Access"
		end	

	Element_change: INTEGER is 3
			-- Constant corresponding to element change feature clause
		indexing
			external_name: "ElementChange"
		end

	Basic_operations: INTEGER is 4
			-- Constant corresponding to basic operations feature clause
		indexing
			external_name: "BasicOperations"
		end		

	Unary_operators: INTEGER is 5
			-- Constant corresponding to unary operators feature clause
		indexing
			external_name: "UnaryOperators"
		end

	Binary_operators: INTEGER is 6
			-- Constant corresponding to binary operators feature clause
		indexing
			external_name: "BinaryOperators"
		end	

	Specials: INTEGER is 7
			-- Constant corresponding to specials feature clause
		indexing
			external_name: "Specials"
		end	

	Implementation: INTEGER is 8
			-- Constant corresponding to implementation feature clause
		indexing
			external_name: "Implementation"
		end	

	Align_left: INTEGER is 32
			-- Left alignment
		indexing
			external_name: "AlignLeft"
		end
		
feature -- Basic Operations

	initialize_gui is
			-- Initialize GUI.
		indexing
			external_name: "InitializeGUI"
		local
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
			label_font: SYSTEM_DRAWING_FONT
			type: SYSTEM_TYPE
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

				-- `Selected assembly: '
			--create_form_label (assembly_descriptor.name, dictionary.Margin, dictionary.Margin)
			create_form_label (assembly_descriptor.name, Margin, Margin)
			--create_form_label (dictionary.Assembly_description (assembly_descriptor), dictionary.Margin, dictionary.Margin + dictionary.Label_height)
			create_form_label (dictionary.Assembly_description (assembly_descriptor), Margin, Margin + Label_height)
				
				-- Build editable class
			build_class_contract_form (eiffel_class)
			
				-- OK button
			create ok_button.make_button
			--a_point.set_X ((dictionary.Window_width // 2) - (dictionary.Margin //2) - dictionary.Button_width) 
			--a_point.set_Y (dictionary.Window_height - 4 * dictionary.Margin - dictionary.Button_height)
			a_point.set_X ((Window_width // 2) - (Margin //2) - Button_width) 
			a_point.set_Y (Window_height - 4 * Margin - Button_height)
			ok_button.set_location (a_point)
			ok_button.set_text (dictionary.Ok_button_label)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
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
			controls.add (ok_button)		
			controls.add (cancel_button)
		end

feature -- Event handling

	on_class_name_leave_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Action launched when a text box is entered
		indexing
			external_name: "OnClassNameLeaveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			is_focused: BOOLEAN
		do
			if type_view_handler.is_valid then
				text_box ?= sender
				if text_box /= Void and then text_box.text /= Void and then text_box.text.length > 0 then
					if type_view_handler.old_name /= Void and then not type_view_handler.old_name.tolower.equals_string (text_box.text.tolower) then	
						type_view_handler.update_class (text_box.text)
						if not type_view_handler.is_valid then
							display_error_message (type_view_handler.error_message)
							to_be_modified_text_box := text_box
							is_focused := text_box.focus
							refresh
						else
							children := type_view_handler.children
							if error_text_box /= Void then
								controls.remove (error_text_box)
							end
							end_class_name_label.set_text (text_box.text)
							refresh
						end
					end
				end
			end
		end
		
	on_enter_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Action launched when a text box is entered
		indexing
			external_name: "OnEnterEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			is_focused: BOOLEAN
		do
			if type_view_handler.is_valid then
				text_box ?= sender
				if text_box /= Void and then text_box.text /= Void and then text_box.text.length > 0 then
					type_view_handler.set_old_name (text_box.text)
				end
			else
				to_be_modified_text_box.set_text (type_view_handler.old_name)
				type_view_handler.set_valid 
				is_focused := to_be_modified_text_box.focus
			end
		end
		
	on_leave_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Action launched when a text box is leaved
		indexing
			external_name: "OnLeaveEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			an_eiffel_class: ISE_REFLECTION_EIFFELCLASS
			an_array: ARRAY [INTEGER]
			is_focused: BOOLEAN
		do
			text_box ?= sender
			if text_box /= Void and then text_box.text /= Void and then text_box.text.length > 0 then
				if type_view_handler.is_valid and then type_view_handler.old_name /= Void and then not type_view_handler.old_name.tolower.equals_string (text_box.text.tolower) then
					if feature_names_boxes.containskey (text_box) then
						an_array ?= feature_names_boxes.item (text_box)
						if an_array /= Void and then an_array.count = 2 then							
							type_view_handler.update_features (text_box.text, an_array.item (0), an_array.item (1))
							if not type_view_handler.is_valid then
								display_error_message (type_view_handler.error_message)
								to_be_modified_text_box := text_box
								is_focused := text_box.focus
								refresh
							else
								children := type_view_handler.children
								an_eiffel_class := type_view_handler.eiffel_class
								controls.remove (panel)
								build_class_contract_form (an_eiffel_class)
								if error_text_box /= Void then
									controls.remove (error_text_box)
								end
								refresh
							end
						end
					elseif feature_arguments_boxes.containskey (text_box) then
						an_array ?= feature_arguments_boxes.item (text_box) 
						if an_array /= Void and then an_array.count = 3 then
							type_view_handler.update_arguments (text_box.text, an_array.item (0), an_array.item (1), an_array.item (2))
							if not type_view_handler.is_valid then
								display_error_message (type_view_handler.error_message)
								is_focused := text_box.focus
								to_be_modified_text_box := text_box						
								refresh
							else
								children := type_view_handler.children
								if error_text_box /= Void then
									controls.remove (error_text_box)
									refresh
								end
							end
						end
					end		
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
			non_void_assembly_descriptor: assembly_descriptor /= Void
			non_void_eiffel_class: eiffel_class /= Void
		local
			xml_generator: ISE_REFLECTION_XMLCODEGENERATOR
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
		do
			assembly_view.set_children (eiffel_class, children)
			assembly_view.set_assembly_types (assembly_types)
			create xml_generator.make_xmlcodegenerator
			xml_generator.makexmlcodegenerator
			--xml_generator.replacetype (assembly_descriptor, eiffel_class)
			--from
			--until
			--	i = children.count
			--loop
			--	a_child ?= children.item (i)
			--	if a_child /= Void then
			--		xml_generator.replacetype (assembly_descriptor, a_child)
			--	end
			--	i := i + 1
			--end
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

	on_parent_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process click on a parent.
		indexing
			external_name: "OnParentEventHandler"
		require
			non_void_sender: sender /= Void
			non_void_arguments: arguments /= Void
		local
			rename_clauses_viewer: RENAME_CLAUSES_VIEWER
			label: SYSTEM_WINDOWS_FORMS_LABEL
		do
			label ?= sender
			if label /= Void then
				create rename_clauses_viewer.make (eiffel_class, label.text, Current)
			end
		end

feature {RENAME_CLAUSES_VIEWER} -- Status Setting
	
	set_eiffel_class (an_eiffel_class: like eiffel_class) is
			-- Set `eiffel_class' with `an_eiffel_class'.
		indexing
			external_name: "SetEiffelClass"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			eiffel_class := an_eiffel_class
			controls.remove (panel)
			build_class_contract_form (eiffel_class)
			refresh
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
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

	parents: SYSTEM_COLLECTIONS_HASHTABLE
			-- Class parents
			-- | Key: parent name
			-- | Value: inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [STRING]])
		indexing
			external_name: "Parents"
		end

	parents_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for parents
			-- | Key: text box
			-- | Value: Parent number (in `eiffel_class.parents')
		indexing
			external_name: "ParentsBoxes"
		end

	rename_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for rename clauses
			-- | Key: text box
			-- | Value: [parent number, rename clause number]
		indexing
			external_name: "RenameBoxes"
		end

	undefine_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for undefine clauses
			-- | Key: text box
			-- | Value: [parent number, undefine clause number]
		indexing
			external_name: "UndefineBoxes"
		end

	redefine_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for redefine clauses
			-- | Key: text box
			-- | Value: [parent number, redefine clause number]
		indexing
			external_name: "RedefineBoxes"
		end

	select_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for select clauses
			-- | Key: text box
			-- | Value: [parent number, select clause number]
		indexing
			external_name: "SelectBoxes"
		end
		
	to_be_modified_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Text box that has to be corrected by the user otherwise class is not correct
		indexing
			external_name: "ToBeModifiedTextBox"
		end
		
	panel_height: INTEGER
			-- Height of panel inside before calling `build_inherit_clause'.
		indexing
			external_name: "PanelHeight"
		end

	special_classes: ARRAY [STRING]
			-- Special classes 
			-- | ["ANY", "INTEGER", "INTEGER_64", "INTEGER_16", "INTEGER_8", "CHARACTER",  "DOUBLE", "REAL", "BOOLEAN"]
		indexing
			external_name: "SpecialClasses"
		end

	creation_routines_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for creation routines
			-- | Key: text box
			-- | Value: creation routine number
		indexing
			external_name: "CreationRoutinesBoxes"
		end

	feature_names_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for feature names
			-- | Key: text box
			-- | Value: [feature clause number, feature number]
		indexing
			external_name: "FeatureNamesBoxes"
		end

	feature_arguments_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for feature arguments
			-- | Key: text box
			-- | Value: [feature clause number, feature number, argument number]
		indexing
			external_name: "FeatureArgumentsBoxes"
		end

	feature_return_types_boxes: SYSTEM_COLLECTIONS_HASHTABLE
			-- Text boxes for feature return types
			-- | Key: text box
			-- | Value: [feature clause number, feature number]
		indexing
			external_name: "FeatureReturnTypesBoxes"
		end
		
	build_class_contract_form (an_eiffel_class: like eiffel_class) is
			-- Build editable contract form of `an_eiffel_class'.
		indexing
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
			on_class_name_enter_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_class_name_leave_event_handler_delegate: SYSTEM_EVENTHANDLER
			type: SYSTEM_TYPE
		do
			create panel.make_panel
			--a_position.set_x (dictionary.Margin)
			--a_position.set_y (2 * dictionary.Margin + 2 * dictionary.Label_height)
			a_position.set_x (Margin)
			a_position.set_y (2 * Margin + 2 * Label_height)
			panel.set_location (a_position)
			--a_size.set_width (dictionary.Window_width - 2 * dictionary.Margin)
			--a_size.set_height (dictionary.Window_height - 6 * dictionary.Margin - 4 * dictionary.Label_height - dictionary.Button_height)
			a_size.set_width (Window_width - 2 *  Margin)
			a_size.set_height (Window_height - 6 * Margin - 4 * Label_height - Button_height)
			panel.set_size (a_size)
			panel.set_borderstyle (0)
			panel.set_backcolor (dictionary.White_color)
			panel.set_autoscroll (True)
			controls.add (panel)
			
				-- Indexing clause
			--create_label (eiffel_dictionary.Indexingkeyword, dictionary.Margin, dictionary.Margin, dictionary.Keyword_color, True)	
			create_label (eiffel_dictionary.Indexingkeyword, Margin, Margin, dictionary.Keyword_color, True)	
			
				-- External name
			an_external_clause := eiffel_dictionary.Externalnamekeyword
			an_external_clause := an_external_clause.concat_string_string (an_external_clause, eiffel_dictionary.Colon)
			--create_label (an_external_clause, 3 * dictionary.Margin, dictionary.Margin + dictionary.Label_height, dictionary.Keyword_color, True)
			create_label (an_external_clause, 3 * Margin, Margin + Label_height, dictionary.Keyword_color, True)	
			
			create formatter.make_formatter
			an_external_name := eiffel_dictionary.Invertedcomma
			an_external_name := an_external_name.concat_string_string_string (an_external_name, formatter.formatstrongname (an_eiffel_class.fullexternalname), eiffel_dictionary.Invertedcomma)
			--create_label (an_external_name, 3 * dictionary.Margin + label_width, dictionary.Margin + dictionary.Label_height, dictionary.Comment_color, False)
			create_label (an_external_name, 3 * Margin + label_width, Margin + Label_height, dictionary.Comment_color, False)
			
				-- frozen
			if an_eiffel_class.IsFrozen then
				--create_label (eiffel_dictionary.Frozenkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Frozenkeyword, Margin, 2 * Margin + 2 * Label_height, dictionary.Keyword_color, True)
			end				
				-- expanded
			if an_eiffel_class.IsExpanded then
				--create_label (eiffel_dictionary.Expandedkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Expandedkeyword, Margin, 2 * Margin + 2 * Label_height, dictionary.Keyword_color, True)
			end
				-- deferred
			if an_eiffel_class.IsDeferred then
				--create_label (eiffel_dictionary.Deferredkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Deferredkeyword, Margin, 2 * Margin + 2 * Label_height, dictionary.Keyword_color, True)
			end
			
				-- external class
				-- 	CLASS_NAME
			if an_eiffel_class.isfrozen or an_eiffel_class.isdeferred or an_eiffel_class.isexpanded then
				external_class :=	eiffel_dictionary.Externalkeyword
				external_class := external_class.concat_string_string_string (external_class, eiffel_dictionary.Space, eiffel_dictionary.Classkeyword)
				--create_label (external_class, dictionary.Margin + dictionary.label_width, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
				create_label (external_class, Margin + label_width, 2 * Margin + 2 * Label_height, dictionary.Keyword_color, True)
			else
				--create_label (eiffel_dictionary.Classkeyword, dictionary.Margin, 2 * dictionary.Margin + 2 * dictionary.Label_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Classkeyword, Margin, 2 * Margin + 2 * Label_height, dictionary.Keyword_color, True)
			end
			create class_name_text_box.make_textbox
			--set_text_box_properties (class_name_text_box, an_eiffel_class.eiffelname.toupper, 3 * dictionary.Margin, 2 * dictionary.Margin + 3 * dictionary.Label_height, dictionary.Window_width - 5 * dictionary.Margin, dictionary.Class_color)
			set_text_box_properties (class_name_text_box, an_eiffel_class.eiffelname.toupper, 3 * Margin, 2 * Margin + 3 * Label_height, Window_width - 5 * Margin, dictionary.Class_color)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_class_name_enter_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnEnterEventHandler")
			class_name_text_box.add_gotfocus (on_class_name_enter_event_handler_delegate)
			on_class_name_leave_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnClassNameLeaveEventHandler")
			class_name_text_box.add_lostfocus (on_class_name_leave_event_handler_delegate)
			
			--panel_height := 2 * Margin + 4 * dictionary.Label_height
			panel_height := 2 * Margin + 4 * Label_height
			
				-- inherit
				-- 	PARENT_NAME
				-- 		rename ... undefine ... redefine ... end
			build_inherit_clause (an_eiffel_class)

			create feature_names_boxes.make
			create feature_arguments_boxes.make
			create feature_return_types_boxes.make
			
				-- `create {NONE}' or `create make ...'
			build_create_clause (an_eiffel_class)
			
				-- Generate class features (except initialization ones).
			build_class_features (an_eiffel_class)

				-- `end -- class CLASS_NAME'
			end_class := eiffel_dictionary.Endkeyword
			end_class := end_class.concat_string_string_string_string (end_class, eiffel_dictionary.Space, eiffel_dictionary.Dashes, eiffel_dictionary.Space)
			end_class := end_class.concat_string_string (end_class, eiffel_dictionary.Classkeyword)
			--create_label (end_class, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
			create_label (end_class, Margin, panel_height + Margin, dictionary.Keyword_color, True)
			--create_label (an_eiffel_class.eiffelname.toupper, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
			create_label (an_eiffel_class.eiffelname.toupper, Margin + label_width, panel_height + Margin, dictionary.Class_color, False)
			end_class_name_label := created_label
		end
	
	create_label (a_text: STRING; x_position, y_position: INTEGER; a_color: SYSTEM_DRAWING_COLOR; is_bold_font: BOOLEAN) is
			-- Create a text box with text `a_text' at position (x_position, y_position).
			-- Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).
		indexing
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
				--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Bold_style)
				create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Bold_style)
			else
				--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Regular_style)
				create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Regular_style)
			end
			a_label.set_font (a_font)
			panel.controls.add (a_label)
			label_width := a_label.width
			created_label := a_label
		end
	
	create_form_label (a_text: STRING; x_position, y_position: INTEGER) is
			-- Create a text box with text `a_text' at position (x_position, y_position).
			-- Set text box forecolor with `a_color' and bold font if `is_bold_font' is True (regular font otherwise).
		indexing
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
--			a_label.set_textalign (dictionary.Align_left)
			a_label.set_textalign (Align_left)
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Label_font_size, dictionary.Bold_style)				
			create a_font.make_font_10 (dictionary.Font_family_name, Label_font_size, Bold_style)
			a_label.set_font (a_font)
			--label_width := a_label.width
			--created_label := a_label
			controls.add (a_label)
	end	
		
	set_editable_text_box_properties (a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: SYSTEM_DRAWING_COLOR) is
			-- Set `a_text_box' position: (x_position, y_position).
			-- Set `a_text_box' size (a_width, Label_height).
			-- Set font color with `a_color'.
		indexing
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
			type: SYSTEM_TYPE
			on_enter_event_handler_delegate: SYSTEM_EVENTHANDLER
			on_leave_event_handler_delegate: SYSTEM_EVENTHANDLER
		do		
			set_text_box_properties (a_text_box, a_text, x_position, y_position, a_width, a_color)
			type := type_factory.GetType_String (dictionary.System_event_handler_type)
			on_enter_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnEnterEventHandler")
			a_text_box.add_gotfocus (on_enter_event_handler_delegate)
			on_leave_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnLeaveEventHandler")
			a_text_box.add_lostfocus (on_leave_event_handler_delegate)
		end

	set_text_box_properties (a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX; a_text: STRING; x_position, y_position, a_width: INTEGER; a_color: SYSTEM_DRAWING_COLOR) is
			-- Set `a_text_box' position: (x_position, y_position).
			-- Set `a_text_box' size (a_width, Label_height).
			-- Set font color with `a_color'.
		indexing
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
			a_size.set_height (Label_height)
			a_size.set_width (a_width)
			a_text_box.set_size (a_size)
			a_text_box.set_borderstyle (0)
			a_text_box.set_textalign (0)
			a_text_box.set_forecolor (a_color)
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Italic_style)
			a_text_box.set_font (a_font)
			panel.controls.add (a_text_box)
		end
		
	build_inherit_clause (an_eiffel_class: like eiffel_class) is
			-- Build inherit clause
		indexing
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
			--parent_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			on_parent_event_handler_delegate: SYSTEM_EVENTHANDLER
			type: SYSTEM_TYPE
		do
			label_width := 0
			parents := an_eiffel_class.Parents
			
			if parents.Count > 1 or has_any_in_clause or (parents.Count = 1 and (not parents.Contains (eiffel_dictionary.Anyclass))) then
				--create_label (eiffel_dictionary.Inheritkeyword, dictionary.Margin, dictionary.Margin + panel_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Inheritkeyword, Margin, Margin + panel_height, dictionary.Keyword_color, True)
				--panel_height := panel_height + dictionary.Label_height + Margin
				panel_height := panel_height + Label_height + Margin
				
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
					create parents_boxes.make
					create rename_boxes.make
					create undefine_boxes.make
					create redefine_boxes.make
					create select_boxes.make
				until
					i = -1
				loop
					a_parent := formatted_parents.item (i)
					if a_parent /= Void then
						if (not a_parent.equals_string (eiffel_dictionary.Anyclass)) or has_any_in_clause then
							--create_label (a_parent, 3 * dictionary.Margin, panel_height, dictionary.Class_color, False)
							create_label (a_parent, 3 * Margin, panel_height, dictionary.Class_color, False)

							type := type_factory.GetType_String (dictionary.System_event_handler_type)
							on_parent_event_handler_delegate ?= delegate_factory.CreateDelegate_Type_Object (type, Current, "OnParentEventHandler")
							created_label.add_Click (on_parent_event_handler_delegate)
							--parent_text_box.add_Click (on_parent_event_handler_delegate)
						end
					end
					--panel_height := panel_height + dictionary.Label_height
					panel_height := panel_height + Label_height
					
					inheritance_clauses ?= parents.Item (a_parent)
					if inheritance_clauses /= Void then
							-- rename clauses
						if inheritance_clauses.Item (0).Count > 0 then
							--create_label (eiffel_dictionary.Renamekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							create_label (eiffel_dictionary.Renamekeyword, 6 * Margin, panel_height, dictionary.Keyword_color, True)
							rename_clauses := inheritance_clauses.Item (0)
							if rename_clauses /= Void and then rename_clauses.Count > 0 then
								--panel_height := panel_height + dictionary.Label_height
								panel_height := panel_height + Label_height
								build_inheritance_clauses (rename_clauses, rename_boxes, i)
								--panel_height := rename_clauses.count * dictionaryLabel_height + panel_height
								panel_height := rename_clauses.count * Label_height + panel_height
							end
						end

							-- undefine clauses
						if inheritance_clauses.Item (1).Count > 0 then
							--create_label (eiffel_dictionary.Undefinekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							create_label (eiffel_dictionary.Undefinekeyword, 6 * Margin, panel_height, dictionary.Keyword_color, True)
							undefine_clauses := inheritance_clauses.Item (1)
							if undefine_clauses /= Void and then undefine_clauses.Count > 0 then
								--panel_height := panel_height + dictionary.Label_height
								panel_height := panel_height + Label_height
								build_inheritance_clauses (undefine_clauses, undefine_boxes, i)
								--panel_height := undefine_clauses.count * dictionary.Label_height + panel_height
								panel_height := undefine_clauses.count * Label_height + panel_height
							end
						end

							-- redefine clauses
						if inheritance_clauses.Item (2).Count > 0 then
							--create_label (eiffel_dictionary.Redefinekeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							create_label (eiffel_dictionary.Redefinekeyword, 6 * Margin, panel_height, dictionary.Keyword_color, True)
							redefine_clauses := inheritance_clauses.Item (2)
							if redefine_clauses /= Void and then redefine_clauses.Count > 0 then
								--panel_height := panel_height + dictionary.Label_height
								panel_height := panel_height + Label_height
								build_inheritance_clauses (redefine_clauses, redefine_boxes, i)
								--panel_height := redefine_clauses.count * dictionary.Label_height + panel_height
								panel_height := redefine_clauses.count * Label_height + panel_height
							end
						end

							-- select clauses
						if inheritance_clauses.Item (3).Count > 0 then
							--create_label (eiffel_dictionary.Selectkeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							create_label (eiffel_dictionary.Selectkeyword, 6 * Margin, panel_height, dictionary.Keyword_color, True)
							select_clauses := inheritance_clauses.Item (3)
							if select_clauses /= Void and then select_clauses.Count > 0 then
								--panel_height := panel_height + dictionary.Label_height
								panel_height := panel_height + Label_height
								build_inheritance_clauses (select_clauses, select_boxes, i)
								--panel_height := redefine_clauses.count * dictionary.Label_height + panel_height
								panel_height := select_clauses.count * Label_height + panel_height
							end
						end
						
							-- Add `end' keyword at the end of inheritance clauses
						if inheritance_clauses.Item (0).Count > 0 or inheritance_clauses.Item (1).Count > 0 or inheritance_clauses.Item (2).Count > 0 or inheritance_clauses.item (3).count > 0 then
							--create_label (eiffel_dictionary.Endkeyword, 6 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
							--panel_height := panel_height + dictionary.Label_height
							create_label (eiffel_dictionary.Endkeyword, 6 * Margin, panel_height, dictionary.Keyword_color, True)
							panel_height := panel_height + Label_height
						end						
					end
					i := i - 1
				end
			end		
		end

	has_any_in_clause: BOOLEAN is
			-- Does class have inheritance clauses for parent `ANY'?
		indexing
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
		
	build_inheritance_clauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST; a_table: SYSTEM_COLLECTIONS_HASHTABLE; parent_number: INTEGER) is
			-- Build inheritance clauses from `clauses'.
			-- | Add text box to `a_table' for `parent_number'-th parent. 
		indexing
			external_name: "BuildInheritanceClauses"
		require
			non_void_clauses: clauses /= Void
			not_empty_clauses: clauses.Count > 0
			non_void_table: a_table /= Void
			valid_parent_number: parent_number >= 0
		local
			i: INTEGER
			a_clause: STRING
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			array: ARRAY [INTEGER]
		do
			from
			until
				i = clauses.Count
			loop
				a_clause ?= clauses.Item (i)
				if a_clause /= Void and then a_clause.Length > 0 then
					create a_text_box.make_textbox
					if i < (clauses.Count - 1) then
						--create_label (a_clause.concat_string_string (a_clause, eiffel_dictionary.Comma), 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
						create_label (a_clause.concat_string_string (a_clause, eiffel_dictionary.Comma), 9 * Margin, panel_height + i* Label_height, dictionary.Text_color, False)
					else
						--create_label (a_clause, 9 * dictionary.Margin, panel_height + i* dictionary.Label_height, dictionary.Text_color, False)
						create_label (a_clause, 9 * Margin, panel_height + i* Label_height, dictionary.Text_color, False)
					end
					create array.make (2)
					array.put (0, parent_number)
					array.put (1, i)
					a_table.add (a_text_box, array)
				end
				i := i + 1
			end
		end

	build_create_clause (an_eiffel_class: like eiffel_class) is 
			-- Build create clause.
		indexing 
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
					--create_label (eiffel_dictionary.Createkeyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
					--panel_height := panel_height + dictionary.Label_height + dictionary.Margin
					create_label (eiffel_dictionary.Createkeyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
					panel_height := panel_height + Label_height + Margin
					from
						i := 0
						create creation_routines_boxes.make
					until
						i = creation_routines.Count
					loop
						a_routine ?= creation_routines.Item (i)
						if a_routine /= Void and then a_routine.Length > 0 then
							create a_text_box.make_textbox
							if i < (creation_routines.Count - 1) then
								create_label (a_routine.concat_string_string (a_routine, eiffel_dictionary.Comma), 3 * Margin, panel_height + i * Label_height, dictionary.Feature_color, False)
							else
								create_label (a_routine, 3 * Margin, panel_height + i * Label_height, dictionary.Feature_color, False)
							end
							creation_routines_boxes.add (a_text_box, i)
						end
						i := i + 1
					end
					--panel_height := panel_height + dictionary.Label_height * creation_routines.count
					panel_height := panel_height + Label_height * creation_routines.count
				end				
			elseif an_eiffel_class.CreationRoutines.Count = 0 and not an_eiffel_class.IsDeferred and an_eiffel_class.CreateNone then
				--create_label (eiffel_dictionary.Createkeyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--new_label_width := dictionary.Margin + label_width
				--create_label (Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				create_label (eiffel_dictionary.Createkeyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				new_label_width := Margin + label_width
				--create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				--create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
				create_label (dictionary.None_class, new_label_width, panel_height + Margin, dictionary.Class_color, False)
				new_label_width := new_label_width + label_width
				--create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + Margin, dictionary.Text_color, False)
				--panel_height := panel_height + dictionary.Label_height + dictionary.Margin
				panel_height := panel_height + Label_height + Margin
			end
			
			if an_eiffel_class.InitializationFeatures.Count > 0 and not an_eiffel_class.IsDeferred and not is_special_class (an_eiffel_class) then
					-- Generate initialization feature clause.
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--new_label_width := dictionary.Margin + label_width
				--create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				--new_label_width := new_label_width + label_width
				--create_label (dictionary.None_class, new_label_width, panel_height + dictionary.Margin, dictionary.Class_color, False)
				--new_label_width := new_label_width + label_width
				--create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + dictionary.Margin, dictionary.Text_color, False)
				--new_label_width := new_label_width + label_width
				--create_label (dictionary.Initialization_comment, new_label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				new_label_width := Margin + label_width
				create_label (dictionary.Opening_curl_bracket, new_label_width, panel_height + Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.None_class, new_label_width, panel_height + Margin, dictionary.Class_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Closing_curl_bracket, new_label_width, panel_height + Margin, dictionary.Text_color, False)
				new_label_width := new_label_width + label_width
				create_label (dictionary.Initialization_comment, new_label_width, panel_height + Margin, dictionary.Comment_color, False)

				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				panel_height := panel_height + 2 * Margin + Label_height
				initialization_features := an_eiffel_class.InitializationFeatures
				from
					i := 0
				until
					i = initialization_features.count
				loop
					a_feature ?= initialization_features.Item (i)
					if a_feature /= Void then
						--build_eiffel_feature (an_eiffel_class, a_feature, dictionary.Initialization, i)
						build_eiffel_feature (an_eiffel_class, a_feature, Initialization, i)
					end
					i := i + 1
				end			
			end
		end

	is_special_class (an_eiffel_class:like eiffel_class): BOOLEAN is
			-- Is `an_eiffel_class' a special class?
		indexing
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
			-- Build class features from `an_eiffel_class', except initialization ones.
		indexing
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
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Access_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Access_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, access_features, dictionary.Access)
				intern_build_class_features (an_eiffel_class, access_features, Access)
			end	
				
				-- Generate element change feature clause.
			element_change_features := an_eiffel_class.ElementChangeFeatures
			if element_change_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Element_change_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Element_change_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height				
				--intern_build_class_features (an_eiffel_class, element_change_features, dictionary.Element_change)
				intern_build_class_features (an_eiffel_class, element_change_features, Element_change)
			end					

				-- Generate basic operations feature clause.
			basic_operations_features := an_eiffel_class.BasicOperations
			if basic_operations_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Basic_operations_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Basic_operations_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, basic_operations_features, dictionary.Basic_operations)
				intern_build_class_features (an_eiffel_class, basic_operations_features, Basic_operations)
			end	

				-- Generate unary operators feature clause.
			unary_operators_features := an_eiffel_class.UnaryOperatorsFeatures
			if unary_operators_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Unary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Unary_operators_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, unary_operators_features, dictionary.Unary_operators)
				intern_build_class_features (an_eiffel_class, unary_operators_features, Unary_operators)
			end	

				-- Generate binary operators feature clause.
			binary_operators_features := an_eiffel_class.BinaryOperatorsFeatures
			if binary_operators_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Binary_operators_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Binary_operators_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, binary_operators_features, dictionary.Binary_operators)
				intern_build_class_features (an_eiffel_class, binary_operators_features, Binary_operators)
			end	

				-- Generate specials feature clause.
			specials_features := an_eiffel_class.SpecialFeatures
			if specials_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Specials_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Specials_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, specials_features, dictionary.Specials)
				intern_build_class_features (an_eiffel_class, specials_features, Specials)
			end	

				-- Generate implementation feature clause.
			implementation_features := an_eiffel_class.ImplementationFeatures
			if implementation_features.Count > 0 then
				--create_label (dictionary.Feature_keyword, dictionary.Margin, panel_height + dictionary.Margin, dictionary.Keyword_color, True)
				--create_label (dictionary.Implementation_comment, dictionary.Margin + label_width, panel_height + dictionary.Margin, dictionary.Comment_color, False)
				--panel_height := panel_height + 2 * dictionary.Margin + dictionary.Label_height
				create_label (dictionary.Feature_keyword, Margin, panel_height + Margin, dictionary.Keyword_color, True)
				create_label (dictionary.Implementation_comment, Margin + label_width, panel_height + Margin, dictionary.Comment_color, False)
				panel_height := panel_height + 2 * Margin + Label_height
				--intern_build_class_features (an_eiffel_class, implementation_features, dictionary.Implementation)
				intern_build_class_features (an_eiffel_class, implementation_features, Implementation)
			end
		end

	intern_build_class_features (an_eiffel_class: like eiffel_class; a_list: SYSTEM_COLLECTIONS_ARRAYLIST; feature_clause: INTEGER) is
			-- Build class features from `a_list'.
			-- | Call in loop `build_eiffel_feature'.
		indexing
			external_name: "InternBuildClassFeatures"
		require
			non_void_list: a_list /= Void
			non_void_eiffel_class: an_eiffel_class /= Void
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
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
					build_eiffel_feature (an_eiffel_class, a_feature, feature_clause, i)
					--panel_height := panel_height + dictionary.Margin
					panel_height := panel_height + Margin
				end
				i := i + 1
			end		
		end

	build_eiffel_feature (an_eiffel_class: like eiffel_class; a_feature: ISE_REFLECTION_EIFFELFEATURE; feature_clause: INTEGER; feature_number: INTEGER) is
			-- Generate Eiffel feature from `a_feature' and `an_eiffel_class'.
		indexing
			external_name: "BuildEiffelFeature"
		require
			non_void_feature: a_feature /= Void
			non_void_feature_name: a_feature.EiffelName /= Void
			not_empty_feature_name: a_feature.EiffelName.Length > 0
			--valid_feature_clause: feature_clause >= dictionary.Initialization and feature_clause <= dictionary.Implementation
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			is_unary_operator: BOOLEAN
			feature_name: STRING
			a_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			tmp_label: SYSTEM_WINDOWS_FORMS_LABEL
			feature_name_width: INTEGER
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			an_argument: ARRAY [STRING]
			argument_name: STRING
			argument_type: STRING
			argument_name_width: INTEGER
			argument_type_width: INTEGER
			return_type_width: INTEGER
			new_label_width: INTEGER
			a_font: SYSTEM_DRAWING_FONT
			an_array: ARRAY [INTEGER]
		do
			is_unary_operator := an_eiffel_class.UnaryOperatorsFeatures.Contains (a_feature)	
			label_width := 0
			--create a_font.make_font_10 (dictionary.Font_family_name, dictionary.Font_size, dictionary.Italic_style)
			create a_font.make_font_10 (dictionary.Font_family_name, Font_size, Italic_style)
			
				-- frozen
			if a_feature.IsFrozen then
				--create_label (eiffel_dictionary.Frozenkeyword, 3 * dictionary.Margin, panel_height, dictionary.Keyword_color, True)
				create_label (eiffel_dictionary.Frozenkeyword, 3 * Margin, panel_height, dictionary.Keyword_color, True)
			end
				
				-- feature name
			create a_text_box.make_textbox
			create tmp_label.make_label
			--new_label_width := 3 * dictionary.Margin + label_width
			new_label_width := 3 * Margin + label_width
			if is_unary_operator and a_feature.IsPrefix then				
				create_label (eiffel_dictionary.Prefixkeyword, new_label_width, panel_height, dictionary.Keyword_color, True)
				new_label_width := new_label_width + label_width
				if a_feature.iscreationroutine then
					create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
					feature_name_width := label_width
				else
					feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)
					set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
				end
			else
				if a_feature.IsInfix then
					create_label (eiffel_dictionary.Infixkeyword, new_label_width, panel_height, dictionary.Keyword_color, True)
					new_label_width := new_label_width + label_width
					if a_feature.iscreationroutine then
						create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)		
						set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
					end
				else
					if a_feature.iscreationroutine then
						create_label (a_feature.eiffelname, new_label_width, panel_height, dictionary.Feature_color, False)	
						feature_name_width := label_width
					else
						feature_name_width := text_box_width_from_text (a_feature.eiffelname, a_font)			
						set_editable_text_box_properties (a_text_box, a_feature.eiffelname, new_label_width, panel_height, feature_name_width, dictionary.Feature_color)
					end
				end
			end
			new_label_width := new_label_width +  feature_name_width
			create an_array.make (2)
			an_array.put (0, feature_clause)
			an_array.put (1, feature_number)
			feature_names_boxes.add (a_text_box, an_array)
			
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
						if an_argument.Count = 4 then
							argument_name := an_argument.Item (0)
							argument_type := an_argument.Item (2)
						end
					end
					create a_text_box.make_textbox		
					argument_name_width := text_box_width_from_text (argument_name, a_font)				
					set_editable_text_box_properties (a_text_box, argument_name, new_label_width, panel_height, argument_name_width, dictionary.Feature_color)
					new_label_width := new_label_width + argument_name_width 
					
					create_label (eiffel_dictionary.Colon, new_label_width, panel_height, dictionary.Text_color, False)
					new_label_width := new_label_width + label_width
					
					create_label (argument_type, new_label_width, panel_height, dictionary.Class_color, False)
					new_label_width := new_label_width + label_width
					
					if i < (arguments.Count - 1) then
						create_label (eiffel_dictionary.Semicolon, new_label_width, panel_height, dictionary.Text_color, False)
						new_label_width := new_label_width + label_width
					end
					create an_array.make (3)
					an_array.put (0, feature_clause)
					an_array.put (1, feature_number)
					an_array.put (2, i)
					feature_arguments_boxes.add (a_text_box, an_array)
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
				create a_text_box.make_textbox
				return_type_width := text_box_width_from_text (a_feature.returntype.typeeiffelname, a_font)
				set_editable_text_box_properties (a_text_box, a_feature.returntype.typeeiffelname, new_label_width, panel_height, return_type_width, dictionary.Class_color)
			end
			panel_height := panel_height + Label_height
		end	
	
	type_view_handler: TYPE_VIEW_HANDLER
			-- Type view handler
		indexing
			external_name: "TypeViewHandler"
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
			--a_point.set_y (Window_height - 5 * dictionary.Margin - dictionary.Label_height - dictionary.Button_height)
			a_point.set_x (Margin)
			a_point.set_y (Window_height - 5 * Margin - Label_height - Button_height)
			
			error_text_box.set_location (a_point)
			controls.add (error_text_box)
		end
	
	text_box_width_from_text (a_text: STRING; a_font: SYSTEM_DRAWING_FONT): INTEGER is
			-- Width of text box with text `a_text' and font `a_font'.
			-- | Should disappear if we can find a feature giving the length of a string in pixels.
		indexing
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
		
end -- class TYPE_VIEW
