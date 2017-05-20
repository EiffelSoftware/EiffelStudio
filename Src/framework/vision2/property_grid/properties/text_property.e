note
	description: "Simple text properties."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PROPERTY [G -> detachable ANY]

inherit
	TYPED_PROPERTY [G]
		redefine
			activate_action,
			initialize,
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
			if attached text_field as l_text_field then
				l_text_field.set_text (l_val)
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
		do
				-- We cannot read from `text_field', which already been destroyed and disconnected.
				-- Instead, the implementation in `deactivate' already set `text' with correct value.
			check text_set: text /= Void end
			if attached convert_to_data (text) as l_data and then is_valid_value (l_data) then
				set_value (l_data)
			else
				set_text (displayed_value)
			end
		end

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			l_text_field: like text_field
		do
			create l_text_field
			text_field := l_text_field
			l_text_field.implementation.hide_border
			l_text_field.set_text (text)
			l_text_field.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			l_text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (l_text_field)

			popup_window.show_actions.extend (agent initialize_actions)
			popup_window.set_x_position (popup_window.x_position + (left_border - 1))
			popup_window.set_size (popup_window.width - (left_border - 1) - (right_border - 1), popup_window.height - 1)
		end

	save_set_text (a_text: G)
			-- Save `set_text'.
		do
			set_text (displayed_value)
			if attached text_field as l_text_field then
				l_text_field.set_text (displayed_value)
			end
		end

feature {NONE} -- Implementation

	display_agent: detachable FUNCTION [G, STRING_32]

	to_displayed_value (a_value: like value): like displayed_value
		local
			r: detachable like displayed_value
		do
			if attached a_value then
					-- The data is used to compute displayed value.
				if attached display_agent as l_agent then
						-- There is an agent to get displayed value.
					r := l_agent.item ([a_value])
				elseif attached {READABLE_STRING_GENERAL} a_value as s then
						-- Avoid conversion to {STRING_8} by the feature `{READABLE_STRING_GENERAL}.out'.
					r := s.twin.as_string_32
				else
						-- Use standard printable representation of a value.
					r := a_value.out.as_string_32
				end
			end
			if attached r then
				Result := r
					-- Make sure there are no new lines in the result.
				Result.replace_substring_all ("%N", "%%N")
			else
					-- There is no value, return an empty string.
				create Result.make_empty
			end
		ensure
			result_attached: attached Result
		end

	convert_to_data_agent: detachable FUNCTION [STRING_32, G]

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
