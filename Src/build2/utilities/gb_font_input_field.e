indexing
	description: "Objects that allow user input of a font value."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FONT_INPUT_FIELD

inherit
	GB_INPUT_FIELD
	
	GB_SHARED_PREFERENCES
		undefine
			copy, is_equal, default_create
		end
	
create
	make
	
feature {NONE} -- Initialization
	
	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [EV_FONT]]; a_validate_agent: FUNCTION [ANY, TUPLE [EV_FONT], BOOLEAN]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- If `label_text' `is_empty', do not display a label.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			label_text_not_void_or_empty: label_text /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		do
			call_default_create (any)
			if not label_text.is_empty then
				add_label (label_text, tooltip)
			end
			internal_property := a_type
			internal_gb_ev_any ?= any
			check
				internal_gb_ev_any /= Void
			end
			object ?= internal_gb_ev_any.object
				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent
				-- Store `a_validate_agent'.
			validate_agent := a_validate_agent
			
			create horizontal_box
			create select_button.make_with_text ("Select...")
			select_button.select_actions.extend (agent select_font)
			horizontal_box.extend (select_button)
			horizontal_box.disable_item_expand (select_button)
			create constants_combo_box
			constants_combo_box.disable_edit
			constants_combo_box.hide
			horizontal_box.extend (constants_combo_box)
			create spacing_cell
			horizontal_box.extend (spacing_cell)
			create_constants_button
			horizontal_box.extend (constants_button)
			horizontal_box.disable_item_expand (constants_button)
			extend (horizontal_box)
			
			a_parent.extend (Current)
			populate_constants
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end
		
feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := font_constant_type
		end

feature {GB_EV_EDITOR_CONSTRUCTOR, GB_EV_ANY, GB_EV_EDITOR_CONSTRUCTOR} -- Implementation

	update_constant_display (a_value: EV_FONT) is
			--
		local
			constant_context: GB_CONSTANT_CONTEXT
			list_item: EV_LIST_ITEM
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_property)
			if constant_context /= Void then
				constants_button.select_actions.block
				constants_button.enable_select
				constants_button.select_actions.resume
				list_item := constants_combo_box.selected_item
				if list_item /= Void then
					list_item.deselect_actions.block
				end
				switch_constants_mode
				if list_item /= Void then
					list_item.deselect_actions.resume
				end
				list_item := list_item_with_matching_text (constants_combo_box, constant_context.constant.name)
				check
					list_item_not_void: list_item /= Void
				end
				list_item.select_actions.block
				list_item.enable_select
				list_item.select_actions.resume
			else
				constants_button.select_actions.block
				constants_button.disable_select
				constants_button.select_actions.resume
				switch_constants_mode
				constants_combo_box.first.enable_select
			end
		end

	execution_agent: PROCEDURE [ANY, TUPLE [EV_FONT]]
		-- Agent to execute command associated with value entered into `Current'.

	internal_property: STRING
		-- Property referenced by `Current'. This is required, so that the constants can
		-- be correctly handled. For example "Padding" or "Minimum_width".
		
	horizontal_box: EV_HORIZONTAL_BOX
		-- Main box used in creation of `Current'.
		
	select_button: EV_BUTTON
		-- Button used to select a font.
		
	spacing_cell: EV_CELL
		-- Cell used to space buttons.

	validate_agent: FUNCTION [ANY, TUPLE [EV_FONT], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.

	execute_agent (new_value: EV_FONT) is
			-- call `execution_agent'.
		do
			execution_agent.call ([new_value])
		end

	switch_constants_mode is
			-- Respond to a user press of `constants_button' and
			-- update the displayed input fields accordingly.
		do
			if constants_button.is_selected then
				select_button.hide
				constants_combo_box.show
				constants_combo_box.first.enable_select
				spacing_cell.hide
			else
				constants_combo_box.hide
				select_button.show
				constants_combo_box.remove_selection
				spacing_cell.show
			end
		end
		
	populate_constants  is
			-- Populate all
		local
			font_constants: ARRAYED_LIST [GB_CONSTANT]
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
			create list_item.make_with_text (select_constant_string)
			constants_combo_box.extend (list_item)
			font_constants := Constants.font_constants
			from
				font_constants.start
			until
				font_constants.off
			loop
				create list_item.make_with_text (font_constants.item.name)
				list_item.set_data (font_constants.item)
				
				constants_combo_box.extend (list_item)
				if internal_property /= Void then
					lookup_string := internal_gb_ev_any.type + internal_property
					if internal_gb_ev_any.object.constants.has (lookup_string) and
						font_constants.item = internal_gb_ev_any.object.constants.item (lookup_string).constant then
						constants_button.enable_select
						list_item.enable_select
					end
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				list_item.deselect_actions.extend (agent list_item_deselected (list_item))
				font_constants.forth
			end
		end
	
	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		local
			constant: GB_FONT_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
				validate_agent.call ([constant.value])
			
				if validate_agent.last_result then
					create constant_context.make_with_context (constant, object, internal_gb_ev_any.type, internal_property)
					constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					execute_agent (constant.value)
				else
					create warning_dialog.make_initialized (1, show_invalid_constant_selection_warning, constant_rejected_warning, Constants_do_not_show_again)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.set_ok_action (agent do_nothing)
					warning_dialog.set_title ("Invalid Constant Selected")
					warning_dialog.show_modal_to_window (parent_window (Current))
					preferences.save_resources
					constants_combo_box.first.enable_select
				end
			end
		end

	list_item_deselected (list_item: EV_LIST_ITEM) is
		local
			constant: GB_INTEGER_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_property)
			if constant_context /= Void then
				constant ?= constant_context.constant
				constant_context.destroy
			end
		end

	select_font is
			-- Display a font dialog and let a user select the desired font directly.
		local
			font_dialog: EV_FONT_DIALOG
		do
			create font_dialog
			font_dialog.show_modal_to_window (parent_window (Current))
			if font_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				execute_agent (font_dialog.font)
			end
		end

end -- class GB_INTEGER_INPUT_FIELD

