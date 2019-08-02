note
	description: "[
		File utilities, for retrieving files and folders and formatting paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	GOBO_FILE_UTILITIES

inherit

	FILE_UTILITIES

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
			{FILE_UTILITIES} deep_twin, is_deep_equal, standard_is_equal
		end

feature -- File name operations

	adapt_unix_to_windows (n: READABLE_STRING_32): STRING_32
			-- Adapt file name `n' in Unix file system to windows file system.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32
				(windows_file_system.pathname_from_file_system
					(u.string_32_to_utf_8_string_8 (n), unix_file_system))
		end

	adapt_windows_to_current (n: READABLE_STRING_32): STRING_32
			-- Adapt file name `n' in windows file system to the current file system.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32
				(file_system.pathname_from_file_system
					(u.string_32_to_utf_8_string_8 (n), windows_file_system))
		end

feature -- File operations

	make_binary_input_file (n: READABLE_STRING_GENERAL): KL_BINARY_INPUT_FILE
			-- New {KL_BINARY_INPUT_FILE} for file name `n'.
		do
			create {KL_BINARY_INPUT_FILE_32} Result.make (n)
		end

	make_text_output_file (n: READABLE_STRING_GENERAL): KL_TEXT_OUTPUT_FILE
			-- New {KL_TEXT_OUTPUT_FILE} for file `n'.
		do
			create {KL_TEXT_OUTPUT_FILE_32} Result.make (n)
		end

	make_text_output_file_in (n, d: READABLE_STRING_GENERAL): KL_TEXT_OUTPUT_FILE
			-- New {KL_TEXT_OUTPUT_FILE} for file name `n' in directory `d'.
		do
			Result := make_text_output_file (make_file_name_in (n, d))
		end

	file_directory_path (n: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Directory path of file name `n'.
		local
			u: UTF_CONVERTER
		do
			if attached {READABLE_STRING_32} n as n32 then
					-- Convert to UTF-8, calculate path and convert back.
				Result := u.utf_8_string_8_to_string_32 (file_system.dirname (u.string_32_to_utf_8_string_8 (n32)))
			else
				check
					n.is_valid_as_string_8
				end
				Result := file_system.dirname (n.to_string_8)
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
