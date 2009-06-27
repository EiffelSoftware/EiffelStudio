note
	description: "Grid item used to input criterion name in metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_GRID_EDITABLE_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			text_field,
			activate_action,
			initialize_actions
		end

	EB_SHARED_PREFERENCES
		undefine
			is_equal,
			copy,
			default_create
		end

feature -- Access

	text_field: COMPLETABLE_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.
		-- Void when `Current' isn't being activated.

	completion_possibilities_provider: EB_METRIC_CRITERION_PROVIDER

feature -- Element change

	set_completion_possibilities_provider (a_provider: like completion_possibilities_provider)
			-- Set `completion_possibilities_provider'.
		require
			a_provider_not_void: a_provider /= Void
		do
			completion_possibilities_provider := a_provider
		ensure
			completion_possibilities_provider_not_void: completion_possibilities_provider /= Void
		end

feature {NONE} -- Implementation

	on_save_auto_complete_window_position (a_x, a_y, a_width, a_height: INTEGER)
			-- Action to be performed to save position of auto-complete window
		do
			preferences.metric_tool_data.criterion_completion_list_width_preference.set_value (a_width)
			preferences.metric_tool_data.criterion_completion_list_height_preference.set_value (a_height)
		end

	initialize_actions
			-- Setup actions sequences of `Current'.
		do
			Precursor
				-- Caret position needs to be set at the end for editing, this also removes
				-- any text selection due to focusing of the text field.
			text_field.set_caret_position (text_field.text_length + 1)
		end

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		do
			create text_field
			text_field.set_completion_possibilities_provider (completion_possibilities_provider)
			text_field.set_save_list_position_action (agent on_save_auto_complete_window_position)
			if completion_possibilities_provider /= Void then
				completion_possibilities_provider.set_code_completable (text_field)
			end
			text_field.implementation.hide_border
			if font /= Void then
				text_field.set_font (font)
			end

			text_field.set_text (text)

			text_field.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			text_field.set_foreground_color (implementation.displayed_foreground_color)

			popup_window.extend (text_field)
				-- Change `popup_window' to suit `Current'.
			update_popup_dimensions (popup_window)

			popup_window.show_actions.extend (agent initialize_actions)
			text_field.set_can_complete_agent (agent can_complete)
		end

	can_complete (a_char: CHARACTER_32; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN
			-- `a_key' can activate text completion?
		local
			l_char: CHARACTER_8
		do
			l_char := a_char.to_character_8
			Result := not (
							(l_char = '%/1/') or  -- ^A
							(l_char = '%/3/') or  -- ^C
							(l_char = '%/22/') or -- ^V
							(l_char = '%/24/')    -- ^X
						)
		end

invariant
	invariant_clause: True -- Your invariant here

note
        copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

