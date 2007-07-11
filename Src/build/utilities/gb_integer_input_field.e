indexing
	description: "Objects that allow user input of an integer value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTEGER_INPUT_FIELD

inherit
	GB_INPUT_FIELD

	GB_SHARED_PREFERENCES
		undefine
			copy, is_equal, default_create
		end

create
	make

feature {NONE} -- Initialization

	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]; a_components: GB_INTERNAL_COMPONENTS) is
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
			components := a_components
			call_default_create (any)
			if not label_text.is_empty then
				add_label (label_text, tooltip)
			end
			internal_type := a_type
			internal_gb_ev_any ?= any
			check
				internal_gb_ev_any /= Void
			end
			object ?= internal_gb_ev_any.object
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

	type: STRING is
			-- Type represented by `Current'
		once
			Result := integer_constant_type
		end

	text: STRING is
			-- `Result' is text of `text_field'.
		do
			Result := text_field.text
		end

feature {GB_EV_EDITOR_CONSTRUCTOR, GB_EV_ANY} -- Implementation

	update_constant_display (a_value: STRING) is
			--
		local
			constant_context: GB_CONSTANT_CONTEXT
			list_item: EV_LIST_ITEM
			blocked_list_item: EV_LIST_ITEM
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constants_button.select_actions.block
				constants_button.enable_select
				constants_button.select_actions.resume
				list_item := constants_combo_box.selected_item
				if list_item /= Void then
					list_item.deselect_actions.block
					blocked_list_item := list_item
				end
				enable_constant_mode

				list_item := list_item_with_matching_text (constants_combo_box, constant_context.constant.name)
				check
					list_item_not_void: list_item /= Void
				end
				list_item.select_actions.block
				list_item.enable_select
				list_item.select_actions.resume
				if blocked_list_item /= Void then
					blocked_list_item.deselect_actions.resume
				end
			else
				constants_button.select_actions.block
				constants_button.disable_select
				constants_button.select_actions.resume
				disable_constant_mode
				text_field.change_actions.block
				text_field.set_text (a_value)
				text_field.change_actions.resume
				if has_select_item then
					remove_select_item
				end
			end
		end

feature {NONE} -- Implementation

	execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]
		-- Agent to execute command associated with value entered into `Current'.

	text_field: EV_TEXT_FIELD
		-- Text field usd for user input.

	value_on_entry: STRING
		-- Contents of `text_field' when focus in is received.

	validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.

	execute_agent (new_value: INTEGER) is
			-- call `execution_agent'.
		do
			execution_agent.call ([new_value])
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
				-- After resetting an object, it appears that the focus in and out actions may be called
				-- sometimes. To prevent us from working on the old object, we check that `Current' is
				-- still valid.
			if object.object /= Void then
				stripped_text := remove_leading_and_trailing_spaces (text_field.text)
				if not stripped_text.is_equal (value_on_entry) then
					if not stripped_text.is_empty and stripped_text.is_integer then
						validate_agent.call ([stripped_text.to_integer])
						if validate_agent.last_result then
							text_field.set_text (stripped_text)
							execute_agent (stripped_text.to_integer)
							if has_select_item then
								remove_select_item
							end
						else
							text_field.set_text (value_on_entry)
							if not has_select_item then
								add_select_item
							end
						end
					else
						text_field.set_text (value_on_entry)
						if not has_select_item then
							add_select_item
						end
					end
				end
			end
		end

	setup_text_field (a_parent: EV_CONTAINER; tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Initialize text field for entry.
		require
			a_parent_not_void: a_parent /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			horizontal_box: EV_HORIZONTAL_BOX
			tool_bar: EV_TOOL_BAR
		do
				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent
				-- Store `a_validate_agent'.
			validate_agent := a_validate_agent

			a_parent.extend (Current)
			create horizontal_box
			horizontal_box.set_padding_width (object_editor_padding_width)
			extend (horizontal_box)
			create text_field
			text_field.set_tooltip (tooltip)
			horizontal_box.extend (text_field)
			create constants_combo_box
			constants_combo_box.disable_edit
			constants_combo_box.hide
			horizontal_box.extend (constants_combo_box)
			create_constants_button
			create tool_bar
			tool_bar.extend (constants_button)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			populate_constants
			text_field.return_actions.extend (agent process)
			text_field.focus_in_actions.extend (agent set_initial)
			text_field.focus_out_actions.extend (agent process)
		end

	disable_constant_mode is
			-- Ensure constant entry fields are hidden.
		do
			constants_combo_box.hide
			text_field.show
			constants_combo_box.remove_selection
		end

	enable_constant_mode is
			-- Ensure constant entry fields are displayed.
		do
			text_field.hide
			constants_combo_box.show
			if object.constants.item (internal_gb_ev_any.type + internal_type) = Void then
				if not has_select_item then
					add_select_item
				end
				constants_combo_box.first.enable_select
			end
		end

	populate_constants  is
			-- Populate all
		local
			integer_constants: ARRAYED_LIST [GB_CONSTANT]
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
			lookup_string := internal_gb_ev_any.type + internal_type
			integer_constants := components.constants.integer_constants
			from
				integer_constants.start
			until
				integer_constants.off
			loop
				create list_item.make_with_text (integer_constants.item.name)
				list_item.set_data (integer_constants.item)
				add_to_list_alphabetically (constants_combo_box, list_item)

				list_item.deselect_actions.block
				list_item.disable_select
				list_item.deselect_actions.resume

				if internal_type /= Void then
					if internal_gb_ev_any.object.constants.has (lookup_string) and
						integer_constants.item = internal_gb_ev_any.object.constants.item (lookup_string).constant then
						constants_button.enable_select
						list_item.enable_select
					end
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				list_item.deselect_actions.extend (agent list_item_deselected (list_item))
				integer_constants.forth
			end
			if internal_gb_ev_any.object.constants.item (lookup_string) = Void then
				add_select_item
			end
		end

	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		local
			constant: GB_INTEGER_CONSTANT
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
					create constant_context.make_with_context (constant, object, internal_gb_ev_any.type, internal_type)
					constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					execute_agent (constant.value)
					if has_select_item then
						remove_select_item
					end
				else
					create warning_dialog.make_initialized (1, preferences.dialog_data.show_invalid_constant_selection_warning, constant_rejected_warning, Constants_do_not_show_again, preferences.preferences)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.set_ok_action (agent do_nothing)
					warning_dialog.set_title ("Invalid Constant Selected")
					warning_dialog.show_modal_to_window (parent_window (Current))
					preferences.preferences.save_preferences
					if not has_select_item then
						add_select_item
					end
					constants_combo_box.first.enable_select
				end
			end
		end

	list_item_deselected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been deselected from `constants_combo_box'.
		local
			constant_context: GB_CONSTANT_CONTEXT
			constant: GB_CONSTANT
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constant ?= constant_context.constant
				text_field.set_text (constant.value_as_string)
				constant_context.destroy
			end
		end

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


end -- class GB_INTEGER_INPUT_FIELD
