note
	description: "[
		An ESF standard file dialog for choosing a location to save a file.
		Functionalities include existing file checking and sticky paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STANDARD_SAVE_DIALOG

inherit
	ES_STANDARD_FILE_DIALOG [EV_FILE_SAVE_DIALOG]
		redefine
			on_confirm
		end

create
	make,
	make_with_sticky_path

feature {NONE} -- User interface initialization

	build_dialog_interface (a_dialog: like dialog)
			-- <Precursor>
		do

		end

feature -- Access

	buttons: attached DS_SET [INTEGER]
			-- <Precursor>
		once
			Result := dialog_buttons.save_cancel_buttons
		end

feature {NONE} -- Query

	button_from_dialog_selected_button (a_dialog: attached EV_FILE_SAVE_DIALOG): INTEGER
			-- <Precursor>
		do
			if a_dialog.full_file_path.entry = Void then
				Result := dialog_buttons.cancel_button
			else
				Result := dialog_buttons.save_button
			end
		end

feature {NONE} -- Action handlers

	on_confirm: BOOLEAN
			-- <Precursor>
		local
			l_file_path: like file_path
			l_file: RAW_FILE
			l_question: ES_QUESTION_PROMPT
			l_error: ES_ERROR_PROMPT
		do
			Result := Precursor
			l_file_path := file_path
			if Result then
				create l_file.make_with_path (l_file_path)
				Result := not l_file.exists
				if not Result then
					if l_file.is_access_writable then
						create l_question.make_standard (locale_formatter.formatted_translation (q_file_already_exists, [l_file_path]))
						l_question.show_on_active_window
						Result := l_question.dialog_result = l_question.dialog_buttons.yes_button
					else
						create l_error.make_standard (locale_formatter.formatted_translation (e_file_not_writable, [l_file_path]))
						l_error.show_on_active_window
					end
				end
			end
		end

feature {NONE} -- Factory

	new_dialog: attached EV_FILE_SAVE_DIALOG
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	e_file_not_writable: STRING = "You do not have the permissions to overwrite the file '$1'."
	q_file_already_exists: STRING = "The selected file '$1' already exists.%NDo you want to contiue and overwrite this file?"

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
