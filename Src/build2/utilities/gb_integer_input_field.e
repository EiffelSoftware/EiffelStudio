indexing
	description: "Objects that allow user input of an integer value."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTEGER_INPUT_FIELD

inherit
	EV_VERTICAL_BOX
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_SHARED_PIXMAPS
		rename
			visual_studio_information as old_visual_studio_information,
			implementation as pixmaps_implementation
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
create
	make,
	make_without_label
	
feature {NONE} -- Initialization
	
	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			editor_constructor: GB_EV_EDITOR_CONSTRUCTOR
		do
			call_default_create (any)
			add_label (label_text, tooltip)
			internal_type := a_type
			editor_constructor ?= any
			check
				object_was_editor_constructor: editor_constructor /= Void
			end
			internal_gb_ev_any ?= any
			check
				internal_gb_ev_any /= Void
			end

			object ?= editor_constructor.object
			setup_text_field (a_parent, tooltip, an_execution_agent, a_validate_agent)
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end
		
	make_without_label (any: ANY; a_parent: EV_CONTAINER; a_type, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]];
	a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			editor_constructor: GB_EV_EDITOR_CONSTRUCTOR
		do
			call_default_create (any)
			internal_type := a_type
			editor_constructor ?= any
			check
				object_was_editor_constructor: editor_constructor /= Void
			end
			internal_gb_ev_any ?= any
			check
				internal_gb_ev_any /= Void
			end
			object ?= editor_constructor.object
			setup_text_field (a_parent, tooltip, an_execution_agent, a_validate_agent)
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end

feature -- Basic operations

	set_text (a_text: STRING) is
			-- Assign `a_text' to text of `text_field'.
		do
			text_field.set_text (a_text)
		end
		
feature -- Access

	text: STRING is
			-- `Result' is text of `text_field'.
		do
			Result := text_field.text
		end

feature {NONE} -- Implementation

	execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]
		-- Agent to execute command associated with value entered into `Current'.

	text_field: EV_TEXT_FIELD
		-- Text field usd for user input.
	
	value_on_entry: STRING
		-- Contents of `text_field' when focus in is received.
	
	internal_gb_ev_any: GB_EV_ANY
		-- instance of GB_EV_ANY that is client of `Current'.
		
	internal_type: STRING
		--| FIXME &**^*678LK6;78LK6;78K
		

	validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.
		
	constants_button: EV_TOGGLE_BUTTON
		-- Button to switch between constants or values.
		
	constants_combo_box: EV_COMBO_BOX
		-- Combo box which will contain all INTEGER constants.
		
	object: GB_OBJECT
		-- Object referenced by `Current'.
		
	last_selected_constant: GB_CONSTANT
		-- Last constant that was selected in `Current'.
		-- Must be stored so that when a user switches from using a constant,
		-- to an actual value, we can remove the constant from the object.
		-- Note that this will be set, if `Current' is built with a constant.

	execute_agent (new_value: INTEGER) is
			-- call `execution_agent'.
		do
			execution_agent.call ([new_value])
		end
		
	update_editors is
			-- Short version for calling everywhere.
		do
			update_editors_for_property_change (internal_gb_ev_any.objects.first, internal_gb_ev_any.type, internal_gb_ev_any.parent_editor)			
		end
		
	set_initial is
			-- Assign text of text field to `value_on_entry'.
		require
			text_field_not_void: text_field /= Void
		do
			value_on_entry := text_field.text
		end
		
	process is
			-- Validate information in `text_field' and execute `execute_agent'
			-- if valid. If not valid, then restore previous value to `text_field'.
		local
			stripped_text: STRING
		do
			stripped_text := remove_leading_and_trailing_spaces (text_field.text)
			if not stripped_text.is_equal (value_on_entry) then
				if not stripped_text.is_empty and stripped_text.is_integer then
					validate_agent.call ([stripped_text.to_integer])
					if validate_agent.last_result then
						text_field.set_text (stripped_text)
						execute_agent (stripped_text.to_integer)
						update_editors
					else
						text_field.set_text (value_on_entry)
					end
				else
					text_field.set_text (value_on_entry)
				end
			end
		end
		
	call_default_create (any: ANY) is
			-- Call `default_create' and assign `any' to `internal_gb_ev_any'.
		require
			gb_ev_any_not_void: any /= Void
		local
			gb_ev_any: GB_EV_ANY
		do
			gb_ev_any ?= any
			check
				gb_ev_any_not_void: gb_ev_any /= Void
			end
			internal_gb_ev_any := gb_ev_any
			default_create
		end
		
	add_label (label_text, tooltip: STRING) is
			-- Add a label to `Current' with `text' `label_text' and
			-- tooltip `tooltip'.
		require
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
		local
			label: EV_LABEL
		do
			create label.make_with_text (label_text)
			label.set_tooltip (tooltip)
			extend (label)
			disable_item_expand (label)
			label.align_text_left
		end
		
	setup_text_field (a_parent: EV_CONTAINER; tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Initialize text field for entry.
		require
			a_parent_not_void: a_parent /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			horizontal_box: EV_HORIZONTAL_BOX
		do
				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent
				-- Store `a_validate_agent'.
				
			validate_agent := a_validate_agent
			a_parent.extend (Current)
			create horizontal_box
			extend (horizontal_box)
			create text_field
			text_field.set_tooltip (tooltip)
			horizontal_box.extend (text_field)
			create constants_combo_box
			constants_combo_box.disable_edit
			constants_combo_box.hide
			horizontal_box.extend (constants_combo_box)
			create constants_button
			constants_button.select_actions.extend (agent constants_button_selected)
			constants_button.set_pixmap (Icon_format_onces @ 1)
			horizontal_box.extend (constants_button)
			horizontal_box.disable_item_expand (constants_button)
			populate_constants
			text_field.return_actions.extend (agent process)
			text_field.focus_in_actions.extend (agent set_initial)
			text_field.focus_out_actions.extend (agent process)
		end
		
	constants_button_selected is
			-- Respond to a user press of `constants_button' and
			-- update the displayed input fields accordingly.
		do
			if constants_button.is_selected then
				text_field.hide
				constants_combo_box.show
				constants_combo_box.first.enable_select
			else
				constants_combo_box.hide
				text_field.show
				remove_selected_constant
			end
		end
		
	populate_constants  is
			-- Populate all
		local
			integer_constants: ARRAYED_LIST [GB_CONSTANT]
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			if internal_type.is_equal ("Value") then
				do_nothing
			end
			constants_combo_box.wipe_out
			create list_item.make_with_text ("Select constant")
			constants_combo_box.extend (list_item)
			integer_constants := Constants.integer_constants
			from
				integer_constants.start
			until
				integer_constants.off
			loop
				create list_item.make_with_text (integer_constants.item.name)
				list_item.set_data (integer_constants.item)
				
				constants_combo_box.extend (list_item)
				if internal_type /= Void then
					lookup_string := internal_gb_ev_any.type + internal_type
					if internal_gb_ev_any.object.constants.has (lookup_string) and
						integer_constants.item = internal_gb_ev_any.object.constants.item (lookup_string).constant then
						constants_button.enable_select
						list_item.enable_select
						last_selected_constant ?= list_item.data
					end
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				integer_constants.forth
			end
		end
		
	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		require
			list_item_not_void: list_item /= Void
			list_item_has_data: list_item.data /= Void
		local
			constant: GB_INTEGER_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
				validate_agent.call ([constant.value])
			
				if validate_agent.last_result then
					execute_agent (constant.value)
					create constant_context.make_with_context (constant, object, internal_gb_ev_any.type, internal_type)
					constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					remove_selected_constant
					last_selected_constant := constant
				else
					constants_combo_box.first.enable_select
				end
			end
		end

	remove_selected_constant is
			-- Update `object' and `last_selected_constant' to reflect the
			-- fact that a user is no longer referencing `last_selected_constant'.
		local
			constant: GB_INTEGER_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if last_selected_constant /= Void then
				constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
				constant ?= constant_context.constant
				if not constants_combo_box.is_displayed then
						-- Now assign the value of `last_selected_item' to the control, but only
						-- if `constants_combo_box' is not displayed, meaning that a user has just
						-- changed from constants to non constants.
					validate_agent.call ([constant.value])			
					if validate_agent.last_result then
						execute_agent (constant.value)
						text_field.set_text (constant.value.out)
					end
				end
				last_selected_constant.remove_referer (constant_context)
				object.constants.remove (internal_gb_ev_any.type + internal_type)
				last_selected_constant := Void
			end
		end
		

end -- class GB_INTEGER_INPUT_FIELD
