indexing
	description: "Simple text properties."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PROPERTY [G]

inherit
	TYPED_PROPERTY [G]
		undefine
			deactivate,
			create_implementation
		redefine
			activate_action,
			initialize,
			implementation,
			value,
			set_value
		end

	EV_GRID_EDITABLE_ITEM
		undefine
			is_in_default_state,
			activate,
			set_data
		redefine
			initialize,
			activate_action,
			implementation
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize
		do
			pointer_button_press_actions.force_extend (agent activate)
			deactivate_actions.extend (agent update_text_on_deactivation)
			Precursor {EV_GRID_EDITABLE_ITEM}
			set_left_border (3)
			set_right_border (3)
		end

feature -- Access

	value: G
			-- Data

	displayed_value: STRING_32 is
			-- Displayed format of the data.
		do
			Result := to_displayed_value (value)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Update

	set_value (a_value: like value) is
			-- Set `value' to `a_value'.
		local
			l_val: like displayed_value
		do
			Precursor {TYPED_PROPERTY} (a_value)
			l_val := displayed_value
			set_text (l_val)
			if text_field /= Void then
				text_field.set_text (l_val)
			end
			if l_val.is_empty then
				set_tooltip (description)
			else
				set_tooltip (l_val)
			end
		end

	set_display_agent (an_agent: like display_agent) is
			-- Set `display_agent' to `an_agent'.
		do
			display_agent := an_agent
				-- Ensure interface update using `display_agent'.
			set_value (value)
		ensure
			display_agent_set: display_agent = an_agent
		end

	set_convert_to_data_agent (an_agent: like convert_to_data_agent) is
			-- Set `convert_to_data_agent' to `an_agent'.
		do
			convert_to_data_agent := an_agent
		ensure
			convert_to_data_agent_set: convert_to_data_agent = an_agent
		end

feature {NONE} -- Agents

	update_text_on_deactivation is
			-- Update text on deactivation.
		local
			l_data: like value
		do
			l_data := convert_to_data (text_field.text)
			if is_valid_value (l_data) then
				set_value (l_data)
			else
				set_text (displayed_value)
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- Activate action.
		local
		do
			create text_field
			text_field.implementation.hide_border
			text_field.set_text (text)
			text_field.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (text_field)

			popup_window.show_actions.extend (agent initialize_actions)
			popup_window.set_x_position (popup_window.x_position + (left_border - 1))
			popup_window.set_size (popup_window.width - (left_border - 1) - (right_border - 1), popup_window.height - 1)
		end

	save_set_text (a_text: G) is
			-- Save `set_text'.
		do
			set_text (displayed_value)
			if text_field /= Void then
				text_field.set_text (displayed_value)
			end
		end

feature {NONE} -- Implementation

	display_agent: FUNCTION [ANY, TUPLE [G], STRING_32]

	to_displayed_value (a_value: like value): like displayed_value is
		do
			if a_value /= Void then
				if display_agent /= Void then
					Result := display_agent.item ([a_value])
				else
					Result := a_value.out.twin.as_string_32
					Result.replace_substring_all ("%N", "%%N")
				end
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	convert_to_data_agent: FUNCTION [ANY, TUPLE [STRING_32], G]

	convert_to_data (a_string: like displayed_value): like value is
			-- Convert displayed data into data.
		deferred
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

end
