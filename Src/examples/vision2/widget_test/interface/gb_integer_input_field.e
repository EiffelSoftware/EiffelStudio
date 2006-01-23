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
	EV_VERTICAL_BOX

	GB_GENERAL_UTILITIES
		undefine
			copy, is_equal, default_create
		end

create
	make,
	make_without_label

feature {NONE} -- Initialization

	make (any: ANY; a_parent: EV_CONTAINER;  a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]; components: GB_INTERNAL_COMPONENTS) is
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
			label: EV_LABEL
		do
			default_create
			create label.make_with_text (label_text)
			label.set_tooltip (tooltip)
			extend (label)
			label.align_text_left
			create text_field
			text_field.set_tooltip (tooltip)
			extend (text_field)
			disable_item_expand (label)
			a_parent.extend (Current)
			text_field.return_actions.extend (agent process)
			text_field.focus_in_actions.extend (agent set_initial)
			text_field.focus_out_actions.extend (agent process)

				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent

				-- Store `a_validate_agent'.
			validate_agent := a_validate_agent
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
		end

	make_without_label (any: ANY; a_parent: EV_CONTAINER;  a_type, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [INTEGER]]; a_validate_agent: FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			label: EV_LABEL
		do
			default_create
			create text_field
			text_field.set_tooltip (tooltip)
			extend (text_field)
			disable_item_expand (label)
			a_parent.extend (Current)
			text_field.return_actions.extend (agent process)
			text_field.focus_in_actions.extend (agent set_initial)
			text_field.focus_out_actions.extend (agent process)

				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent

				-- Store `a_validate_agent'.
			validate_agent := a_validate_agent
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
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

feature {GB_EV_EDITOR_CONSTRUCTOR}

	update_constant_display (a_value: STRING) is
			--
		do
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

	update_editors is
			-- Short version for calling everywhere.
		do
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_INTEGER_INPUT_FIELD
