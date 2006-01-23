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
	EV_VERTICAL_BOX


	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	INTERNAL
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

create
	make

feature {NONE} -- Initialization

	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [STRING]]; a_validate_agent: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]; multiple_line_text_entry: BOOLEAN; components: GB_INTERNAL_COMPONENTS) is
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
			editor_constructor ?= any
			check
				object_was_editor_constructor: editor_constructor /= Void
			end

			has_multiple_line_entry := multiple_line_text_entry
			setup_text_field (a_parent, tooltip, an_execution_agent, a_validate_agent)
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
		--	internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
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

	has_multiple_line_entry: BOOLEAN
		-- Does `Current' permit the entering of multiple lines of text?

	hide_label is
			-- Ensure that label is hidden.
		do
			label.parent.prune_all (label)
		end

feature -- Access

	text: STRING is
			-- `Result' is text of `text_field'.
		do
			Result := text_entry.text
		ensure
			Result_not_void: Result /= Void
		end

feature {GB_EV_EDITOR_CONSTRUCTOR}

	update_constant_display (a_value: STRING) is
			-- Update displayed constant to `a_value'.
		do
			text_entry.change_actions.block
			text_entry.set_text (a_value)
			text_entry.change_actions.resume
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

	label: EV_LABEL
		-- Label used to display text associated with `Current'.

	object: GB_OBJECT
		-- Object referenced by `Current'.

	execute_agent (new_value: STRING) is
			-- call `execution_agent'.
		require
			new_value_not_void: new_value /= Void
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
			text_entry_not_void: text_entry /= Void
		do
			value_on_entry := text_entry.text
		end

	process is
			-- Validate information in `text_field' and execute `execute_agent'
			-- if valid. If not valid, then restore previous value to `text_field'.
		do
			validate_agent.call ([text_entry.text])
			if validate_agent.last_result then
				execute_agent (text_entry.text)
			else
				text_entry.set_text (value_on_entry)
			end
		end

	call_default_create (any: ANY) is
			-- Call `default_create' and assign `any' to `internal_gb_ev_any'.
		require
			gb_ev_any_not_void: any /= Void
		do
			default_create
		end

	add_label (label_text, tooltip: STRING) is
			-- Add a label to `Current' with `text' `label_text' and
			-- tooltip `tooltip'.
		require
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
		do
			create label.make_with_text (label_text)
			label.set_tooltip (tooltip)
			extend (label)
			disable_item_expand (label)
			label.align_text_left
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
		do
				-- Store `an_exection_agent' internally.
			execution_agent := an_execution_agent
				-- Store `a_validate_agent'.

			validate_agent := a_validate_agent
			a_parent.extend (Current)
			create horizontal_box
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
			entry_widget.focus_out_actions.extend (agent process)
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


end -- class GB_STRING_INPUT_FIELD
