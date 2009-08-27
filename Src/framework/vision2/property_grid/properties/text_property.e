note
	description: "Simple text properties."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PROPERTY [G]

inherit
	TYPED_PROPERTY [G]
		redefine
			activate_action,
			initialize,
			value,
			set_value
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize
		do
			deactivate_actions.extend (agent update_text_on_deactivation)
			Precursor
			set_left_border (3)
			set_right_border (3)
		end

feature -- Access

	value: G
			-- Data

	displayed_value: STRING_32
			-- Displayed format of the data.
		do
			Result := to_displayed_value (value)
		ensure
			Result_not_void: Result /= Void
		end

feature -- Update

	set_value (a_value: like value)
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

	set_display_agent (an_agent: like display_agent)
			-- Set `display_agent' to `an_agent'.
		do
			display_agent := an_agent
				-- Ensure interface update using `display_agent'.
			set_value (value)
		ensure
			display_agent_set: display_agent = an_agent
		end

	set_convert_to_data_agent (an_agent: like convert_to_data_agent)
			-- Set `convert_to_data_agent' to `an_agent'.
		do
			convert_to_data_agent := an_agent
		ensure
			convert_to_data_agent_set: convert_to_data_agent = an_agent
		end

feature {NONE} -- Agents

	update_text_on_deactivation
			-- Update text on deactivation.
		local
			l_data: like value
		do
				-- We cannot read from `text_field', which already been destroyed and disconnected.
				-- Instead, the implementation in `deactivate' already set `text' with correct value.
			check text_set: text /= Void end
			l_data := convert_to_data (text)
			if is_valid_value (l_data) then
				set_value (l_data)
			else
				set_text (displayed_value)
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW)
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

	save_set_text (a_text: G)
			-- Save `set_text'.
		do
			set_text (displayed_value)
			if text_field /= Void then
				text_field.set_text (displayed_value)
			end
		end

feature {NONE} -- Implementation

	display_agent: FUNCTION [ANY, TUPLE [G], STRING_32]

	to_displayed_value (a_value: like value): like displayed_value
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

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
