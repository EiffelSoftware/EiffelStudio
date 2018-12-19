note
	description: "A EiffelStudio discardable confirmation/question prompt.]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DISCARDABLE_QUESTION_PROMPT

inherit
	ES_DISCARDABLE_PROMPT
		redefine
			build_prompt_interface,
			on_close_requested
		end

	ES_PROMPT
		rename
			build_prompt_interface as build_discardable_check_interface,
			make as make_prompt,
			make_standard as make_standard_prompt
		undefine
			build_discardable_check_interface,
			make_prompt,
			make_standard_prompt,
			show,
			show_on_active_window
		redefine
			on_close_requested
		end

create
	make,
	make_standard,
	make_standard_persistent,
	make_standard_with_cancel

feature {NONE} -- Initialization

	make_standard_with_cancel (a_text: like text; a_discard_message: like discard_message; a_setting: like setting)
			-- Initialize a discardable confirmation prompt, with a cancel button, using required information.
			--
			-- `a_text': The text to display on the prompt.
			-- `a_discard_message': A message to inform the user what the discard option will do as a default.
			-- `a_setting': Setting used to dictate the discard state of the prompt.
		require
			a_text_attached: a_text /= Void
			a_discard_message_attached: a_discard_message /= Void
			a_setting_attached: attached a_setting
			a_setting_is_interface_usable: a_setting.is_interface_usable
		do
			is_standard_prompt_with_cancel := True
			make_standard (a_text, a_discard_message, a_setting)
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = standard_default_button
			default_confirm_button_set: default_confirm_button = standard_default_confirm_button
			default_cancel_button_set: default_cancel_button = standard_default_cancel_button
			buttons_set: buttons = standard_buttons
			discard_message_set: a_discard_message.is_equal (discard_message)
			setting_set: setting = a_setting
		end

	make_standard_persistent (t: like text; m: like discard_message; d: like setting; c: like choice)
			-- Initialize a discardable confirmation prompt, with a cancel button, and associated persistent setting.
			--
			-- `t`: The text to display on the prompt.
			-- `m`: A message to inform the user what the discard option will do as a default.
			-- `d`: Setting used to dictate the discard state of the prompt.
			-- `c`: Setting with a previous choice on entry, and a selected choice on exit.
			--
			-- `c` is unaffected, if the dialog is discarded, or if "Cancel" button is pressed.
		require
			text_attached: t /= Void
			discard_message_attached: m /= Void
			discard_setting_attached: attached d
			discard_setting_is_interface_usable: d.is_interface_usable
			choice_setting_attached: attached c
			choice_setting_is_interface_usable: c.is_interface_usable
		do
			is_standard_prompt_with_cancel := True
			choice := c
			make_standard (t, m, d)
			set_discard_button (if c.value then {ES_DIALOG_BUTTONS}.yes_button else {ES_DIALOG_BUTTONS}.no_button end)
		ensure
			text_set: format_text (t).is_equal (text)
			default_button_set: default_button = standard_default_button
			default_confirm_button_set: default_confirm_button = standard_default_confirm_button
			default_cancel_button_set: default_cancel_button = standard_default_cancel_button
			buttons_set: buttons = standard_buttons
			discard_message_set: m.is_equal (discard_message)
			setting_set: setting = d
			choice_set: choice = c
		end

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor {ES_DISCARDABLE_PROMPT} (a_container)
			set_title (interface_names.t_eiffelstudio_question)
		end

feature {NONE} -- Access

	large_icon: EV_PIXEL_BUFFER
			-- The dialog's large icon, shown on the left
		do
			Result := os_stock_pixmaps.question_pixel_buffer
		end

	standard_buttons: DS_HASH_SET [INTEGER]
			-- Standard set of buttons for a current prompt
		do
			if is_standard_prompt_with_cancel then
				Result := dialog_buttons.yes_no_cancel_buttons
			else
				Result := dialog_buttons.yes_no_buttons
			end
		end

	standard_default_button: INTEGER
			-- Standard buttons `standard_buttons' default button
		do
			if is_standard_prompt_with_cancel then
				Result := dialog_buttons.cancel_button
			else
				Result := dialog_buttons.no_button
			end
		end

	standard_default_confirm_button: INTEGER
			-- Standard buttons `standard_buttons' default confirm button
		do
			Result := dialog_buttons.yes_button
		end

	standard_default_cancel_button: INTEGER
			-- Standard buttons `standard_buttons' default cancel button
		do
			if is_standard_prompt_with_cancel then
				Result := dialog_buttons.cancel_button
			else
				Result := dialog_buttons.no_button
			end
		end

feature {NONE} -- Status report

	is_standard_prompt_with_cancel: BOOLEAN
			-- Indicates if a cancel button should be present

feature {NONE} -- Storage

	choice: detachable ES_BOOLEAN_SETTING
			-- User selection.
			-- "True" for "Yes", "False" for "No".

feature {NONE} -- Event handling

	on_close_requested (b: INTEGER)
			-- <Precursor>
		do
			if attached choice as c then
				if b /= {ES_DIALOG_BUTTONS}.cancel_button then
					c.set_value (b = {ES_DIALOG_BUTTONS}.yes_button)
					c.commit
				end
				Precursor {ES_PROMPT} (b)
				if
					not is_shown and
					is_discard_requested and
					b /= {ES_DIALOG_BUTTONS}.cancel_button
				then
					discard_future_dialogs
				else
					undiscard_future_dialogs
				end
			else
				Precursor {ES_DISCARDABLE_PROMPT} (b)
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
