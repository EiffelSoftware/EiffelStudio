note
	description: "[
		An ESF standard directory dialog for locating and chosing directories.
		Functionalities include non-existent directory path creation and sticky paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_STANDARD_DIRECTORY_DIALOG

inherit
	ES_STANDARD_PATH_DIALOG [EV_DIRECTORY_DIALOG]
		redefine
			reset,
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

	path: !STRING_32
			-- <Precursor>
		local
			l_result: ?STRING_32
			l_separator: CHARACTER_8
		do
			l_result := dialog.directory
			if l_result /= Void then
				Result := l_result
				l_separator := operating_environment.directory_separator
				if not Result.is_empty and then Result.item (Result.count) = l_separator then
					Result.keep_head (Result.count - 1)
				end
			else
				create Result.make_empty
			end
		end

	buttons: !DS_SET [INTEGER]
			-- <Precursor>
		once
			Result := dialog_buttons.ok_cancel_buttons.as_attached
		end

feature {NONE} -- Element change

	set_start_path_on_dialog (a_path: like start_path; a_dialog: like dialog)
			-- <Precursor>
		do
			dialog.set_start_directory (a_path)
		ensure then
			dialog_start_directory_set: dialog.start_directory ~ a_path
		end

feature -- Status report

	is_path_created_on_confirm: BOOLEAN assign set_is_path_created_on_confirm
			-- Indicates if a directory should be created if the directory chosen doesn't exist

feature -- Status setting

	set_is_path_created_on_confirm (a_created: BOOLEAN)
			-- Sets dialog's ability to request a directory be created.
			--
			-- `a_created': True to create non-existing directories; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			is_path_created_on_confirm := a_created
		ensure
			is_path_created_on_confirm_set: is_path_created_on_confirm = a_created
		end

feature {NONE} -- Query

	button_from_dialog_selected_button (a_dialog: !EV_DIRECTORY_DIALOG): INTEGER
			-- <Precursor>
		local
			l_directory: ?STRING_32
		do
			l_directory := a_dialog.directory
			if l_directory = Void or else l_directory.is_empty then
				Result := dialog_buttons.cancel_button
			else
				Result := dialog_buttons.ok_button
			end
		end

feature -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor
			is_path_created_on_confirm := False
		ensure then
			not_is_path_created_on_confirm: not is_path_created_on_confirm
		end

feature {NONE} -- Action handlers

	on_confirm: BOOLEAN
			-- <Precursor>
		local
			l_path: like path
			l_directory: DIRECTORY
			l_question: ES_QUESTION_PROMPT
			l_error: ES_ERROR_PROMPT
			retried: BOOLEAN
		do
			if not retried then
				l_path := path
				Result := Precursor
				if Result then
					create l_directory.make (l_path)
					Result := l_directory.exists
					if not Result then
						if is_path_created_on_confirm then
							create l_question.make_standard (locale_formatter.formatted_translation (e_create_directory_1, [l_path]))
							l_question.show_on_active_window
							if l_question.dialog_result = l_question.dialog_buttons.yes_button then
								file_utilities.create_directory (l_path)
								Result := True
							end
						else
							Result := True
						end
					end
				end
			else
				create l_error.make_standard (locale_formatter.formatted_translation (e_unable_to_create_directory_1, [l_path]))
				l_error.show_on_active_window
				Result := False
			end
		ensure then
			path_exists: (is_path_created_on_confirm and Result) implies (create {DIRECTORY}.make (path)).exists
		end

feature {NONE} -- Factory

	new_dialog: !EV_DIRECTORY_DIALOG
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internationalization

	e_unable_to_create_directory_1: STRING = "Unable to create the directory '$1'."
	e_create_directory_1: STRING = "The directory '$1' does not exist.%NDo you want to create it now?"

;note
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
