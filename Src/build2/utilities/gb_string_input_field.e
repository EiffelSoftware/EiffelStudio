indexing
	description: "Objects that allow user input of an string value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_STRING_INPUT_FIELD

inherit
	GB_INPUT_FIELD
		
create
	make
	
feature {NONE} -- Initialization
	
	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [STRING]]; a_validate_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]; multiple_line_text_entry: BOOLEAN; a_components: GB_INTERNAL_COMPONENTS) is
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
		do
			components := a_components
			call_default_create (any)
			add_label (label_text, tooltip)
			internal_type := a_type
			internal_gb_ev_any ?= any
			check
				internal_gb_ev_any /= Void
			end
			
			has_multiple_line_entry := multiple_line_text_entry

			object ?= internal_gb_ev_any.object
			check
				object_not_void: object /= Void
			end
			setup_text_field (a_parent, tooltip, an_execution_agent, a_validate_agent)
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end

feature -- Basic operations

	set_text (a_text: STRING) is
			-- Assign `a_text' to text of `text_field'. As the setting is external,
			-- we must block the change actions of `text_entry' so that we do not
			-- get infinite recursion.
		require
			a_text_not_void: a_text /= Void
		do		
			text_entry.change_actions.block
			text_entry.set_text (a_text)
			text_entry.change_actions.resume
		ensure
			text_set: text_entry.text.is_equal (a_text)
		end
		
	hide_label is
			-- Ensure that label is hidden.
		do
			label.hide
		end

feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := string_constant_type
		end

	text: STRING is
			-- `Result' is text of `text_field'.
		do
			Result := text_entry.text
		ensure
			Result_not_void: Result /= Void
		end
		
	has_multiple_line_entry: BOOLEAN	
		-- Does `Current' permit the entering of multiple lines of text?
		
feature {GB_EV_EDITOR_CONSTRUCTOR, GB_EV_ANY} -- Implementation

	update_constant_display (a_value: STRING) is
			-- Update constant display to reflect `a_value' or a constant if associated.
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
				text_entry.change_actions.block
				text_entry.set_text (a_value)
				text_entry.change_actions.resume
				if has_select_item then
					remove_select_item
				end
			end
		end

feature {NONE} -- Implementation

	execution_agent: PROCEDURE [ANY, TUPLE [STRING]]
		-- Agent to execute command associated with value entered into `Current'.

	text_entry: EV_TEXT_COMPONENT
		-- Text for user input when multiple lines are required.
		-- May be either an EV_TEXT or EV_TEXT_FIELD depending on whether multiple lines should be supported or not.

	value_on_entry: STRING
		-- Contents of `text_field' when focus in is received.

	validate_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.

	execute_agent (new_value: STRING) is
			-- call `execution_agent'.
		require
			new_value_not_void: new_value /= Void
		do
			execution_agent.call ([new_value])
		end

	set_initial is
			-- Assign text of text field to `value_on_entry'.
		require
			text_entry_not_void: text_entry /= Void
		do
			value_on_entry := text_entry.text
		end
		
	process is
			-- Validate information in `text_field' and execute `execute_agent'
			-- if valid. If not valid, then restore previous value to `text_field'.
		do
				-- After resetting an object, it appears that the focus in and out actions may be called
				-- sometimes. To prevent us from working on the old object, we check that `Current' is
				-- still valid.
			if object.object /= Void then
				validate_agent.call ([text_entry.text])
				if validate_agent.last_result then
					execute_agent (text_entry.text)
				else
					text_entry.set_text (value_on_entry)
				end
			end
		end
		
	setup_text_field (a_parent: EV_CONTAINER; tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [STRING]]; a_validate_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]) is
			-- Initialize text field for entry.
		require
			a_parent_not_void: a_parent /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			horizontal_box: EV_HORIZONTAL_BOX
			entry_widget: EV_PRIMITIVE
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
	
			if has_multiple_line_entry = multiple_line_entry then
					-- Create a text component that supports multiple lines of text if necessary.
				create {EV_TEXT} text_entry
			else
				create {EV_TEXT_FIELD} text_entry
			end
			entry_widget ?= text_entry
			check
				text_entry_was_widget: entry_widget /= Void
			end
			if has_multiple_line_entry then
				text_entry.set_minimum_height (50)
			end
			entry_widget.set_tooltip (tooltip)
			horizontal_box.extend (entry_widget)
			text_entry.change_actions.extend (agent process)
			entry_widget.focus_in_actions.extend (agent set_initial)
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
		end

	enable_constant_mode is
			-- Ensure constant entry fields are displayed.
		local
			entry_widget: EV_WIDGET
		do
			entry_widget ?= text_entry
			check
				text_entry_was_widget: entry_widget /= Void
			end
			entry_widget.hide
			constants_combo_box.show
			if object.constants.item (internal_gb_ev_any.type + internal_type) = Void then
				if not has_select_item then
					add_select_item
				end
				constants_combo_box.first.enable_select
			end
		end
		
	disable_constant_mode is
			-- Ensure constant entry fields are hidden.
		local
			entry_widget: EV_WIDGET
		do
			entry_widget ?= text_entry
			check
				text_entry_was_widget: entry_widget /= Void
			end
			constants_combo_box.hide
			entry_widget.show
			constants_combo_box.remove_selection
		end
		
		
	populate_constants is
			-- Populate `constants_combo_box' with string constants.
		local
			string_constants: ARRAYED_LIST [GB_CONSTANT]
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
			lookup_string := internal_gb_ev_any.type + internal_type
			string_constants := components.constants.string_constants
			from
				string_constants.start
			until
				string_constants.off
			loop
				create list_item.make_with_text (string_constants.item.name)
				list_item.set_data (string_constants.item)
				add_to_list_alphabetically (constants_combo_box, list_item)
				
				list_item.deselect_actions.block
				list_item.disable_select
				list_item.deselect_actions.resume
				
				
				if internal_type /= Void then
					lookup_string := internal_gb_ev_any.type + internal_type
					if internal_gb_ev_any.object.constants.has (lookup_string) and
						string_constants.item = internal_gb_ev_any.object.constants.item (lookup_string).constant then
						constants_button.enable_select
						list_item.enable_select
					end
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				list_item.deselect_actions.extend (agent list_item_deselected (list_item))
				string_constants.forth
			end
			if internal_gb_ev_any.object.constants.item (lookup_string) = Void then
				add_select_item
			end
		end
		
	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		local
			constant: GB_STRING_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
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
			constant: GB_STRING_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constant ?= constant_context.constant
				text_entry.set_text (constant.value_as_string)
				constant_context.destroy
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_STRING_INPUT_FIELD
