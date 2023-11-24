note
	description: "Display application information such as compiler version, various folder location, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_APP_INFO_CMD

inherit
	EWB_CMD
		rename
			name as app_info_cmd_name,
			help_message as app_info_help,
			abbreviation as app_info_abb
		end

	SHARED_ERROR_HANDLER

	EIFFEL_LAYOUT

	SYSTEM_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_info_name: READABLE_STRING_GENERAL)
			-- Initialization
		do
			info_name := a_info_name
		end

feature -- Access

	info_name: IMMUTABLE_STRING_32

feature {NONE} -- Execution

	execute
			-- Execute Current batch command.
		require else
			True -- We don't need a compiled workbench!
		local
			retried: BOOLEAN
		do
			if not retried then
				print_app_info (info_name)
			end
		rescue
			retried := True
			retry
		end

	available_informations: ARRAY [READABLE_STRING_32]
		once
			Result := <<
				"version", "short_version", "version_type",
				"layout", "layout.install_path", "layout.user_files_path", "layout.hidden_files_path",
				"environment"
			>>
		end

	is_valid_information_name (n: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := n.is_case_insensitive_equal ("?")
				or else across available_informations as c some n.is_case_insensitive_equal (c.item) end
		end

	print_app_info (a_info_name: READABLE_STRING_GENERAL)
		require
			is_valid_information_name (a_info_name)
		local
			v: STRING_32
			i: INTEGER
		do
			if a_info_name.is_case_insensitive_equal ("version") then
				io.put_string_32 (compiler_version_number.version)
			elseif a_info_name.is_case_insensitive_equal ("short_version") then
				v := compiler_version_number.version
				i := v.index_of ('.', 1)
				if i > 0 then
					i := v.index_of ('.', i + 1)
					if i > 0 then
						v := v.head ( i - 1)
					end
				end
				io.put_string_32 (v)
			elseif a_info_name.is_case_insensitive_equal ("version_type") then
				io.put_string_32 (version_type_name)
			elseif a_info_name.is_case_insensitive_equal ("layout") then
				io.put_string_32 ("Installation: ")
				io.put_string_32 (eiffel_layout.install_path.name)
				io.put_new_line

				io.put_string_32 ("Users files: ")
				io.put_string_32 (eiffel_layout.user_files_path.name)
				io.put_new_line

				io.put_string_32 ("Hidden files: ")
				io.put_string_32 (eiffel_layout.hidden_files_path.name)
				io.put_new_line
			elseif a_info_name.is_case_insensitive_equal ("layout.install_path") then
				io.put_string_32 (eiffel_layout.install_path.name)
			elseif a_info_name.is_case_insensitive_equal ("layout.user_files_path") then
				io.put_string_32 (eiffel_layout.user_files_path.name)
			elseif a_info_name.is_case_insensitive_equal ("layout.hidden_files_path") then
				io.put_string_32 (eiffel_layout.hidden_files_path.name)

			elseif a_info_name.is_case_insensitive_equal ("environment") then
				io.put_string_32 (eiffel_layout.environment_info)

			elseif a_info_name.is_case_insensitive_equal ("?") then
				io.put_string_32 ({STRING_32} "Available information: ")
				across
					available_informations as c
				loop
					io.put_string_32 (c.item)
					if not c.is_last then
						io.put_string (", ")
					end
				end
				io.put_string (" .%N")
			else
				io.error.put_string ("Unsupported information name, use %"?%" to get a list of available information names.%N")
			end
		end


note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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

end -- class EWB_PRETTY
