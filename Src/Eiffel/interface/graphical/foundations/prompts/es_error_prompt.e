note
	description: "[
		A simple error dialog prompt.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_ERROR_PROMPT

inherit
	ES_PROMPT
		redefine
			build_prompt_interface
		end

create
	make,
	make_standard,
	make_abort_retry_ignore

feature {NONE} -- Initialization

	make_abort_retry_ignore (a_text: like text)
			-- Initialize an error prompt, with Abort|Retry|Ignore buttons, using required information.
			--
			-- `a_text': The text to display on the prompt.
		require
			a_text_attached: a_text /= Void
		do
			make (a_text, dialog_buttons.abort_retry_ignore_buttons, dialog_buttons.abort_button, dialog_buttons.abort_button, dialog_buttons.ignore_button)
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = dialog_buttons.abort_button
			default_confirm_button_set: default_confirm_button = dialog_buttons.abort_button
			default_cancel_button_set: default_cancel_button = dialog_buttons.ignore_button
			buttons_set: buttons = dialog_buttons.abort_retry_ignore_buttons
		end

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor {ES_PROMPT} (a_container)
			set_title (interface_names.t_eiffelstudio_error)
		end

feature {NONE} -- Access

	large_icon: EV_PIXEL_BUFFER
			-- The dialog's large icon, shown on the left
		do
			Result := os_stock_pixmaps.error_pixel_buffer
		end

	standard_buttons: DS_HASH_SET [INTEGER]
			-- Standard set of buttons for a current prompt
		once
			Result := dialog_buttons.ok_buttons
		end

	standard_default_button: INTEGER
			-- Standard buttons `standard_buttons' default button
		once
			Result := dialog_buttons.ok_button
		end

	standard_default_confirm_button: INTEGER
			-- Standard buttons `standard_buttons' default confirm button
		do
			Result := dialog_buttons.ok_button
		end

	standard_default_cancel_button: INTEGER
			-- Standard buttons `standard_buttons' default cancel button
		do
			Result := dialog_buttons.ok_button
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
