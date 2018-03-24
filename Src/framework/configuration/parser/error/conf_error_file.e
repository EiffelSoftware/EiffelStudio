note
	description: "File open error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_FILE

inherit
	CONF_ERROR

create
	make,
	make_with_config

feature {NONE} -- Initialization

	make (a_file: like file)
			-- Create.
		require
			a_file_not_void: a_file /= Void
		do
			file := a_file
		end

	make_with_config (a_file, a_orig_file, a_config: READABLE_STRING_GENERAL)
			-- Create.
		require
			a_file_not_void: a_file /= Void
			a_orig_file_not_void: a_orig_file /= Void
			a_config_not_void: a_config /= Void
		do
			file := a_file.to_string_32
			set_original_file (a_orig_file)
			set_config (a_config)
		end

feature -- Access

	file: STRING_32
			-- File that could not be opened.

	orig_file: detachable STRING_32
			-- File that could not be opened.

	config: detachable STRING_32
			-- Config where the file was referenced.

	text: STRING_32
			-- The error message.
		local
			i: INTEGER
		do
			check
				file_not_void: file /= Void
			end
			if
				attached orig_file as l_orig_file and then
				l_orig_file.starts_with_general ("iron:")
			then
				Result := {STRING_32} "Could find location related to: " + l_orig_file
				Result.append ({STRING_32} "%N")
				i := l_orig_file.index_of (':', 6)
				if i > 0 then
					Result.append ({STRING_32} "Missing iron package %"" + l_orig_file.substring (6, i - 1) + {STRING_32} "%".%N")
					Result.append ({STRING_32} "To fix, install from command line: iron install " + l_orig_file.substring (6, i - 1))
					Result.append ({STRING_32} "%N")
				else
					Result.append ({STRING_32} "Fix iron location, install missing package, or fix the configuration file.")
					Result.append ({STRING_32} "%N")
				end
			else
				Result := {STRING_32} "Could not open file: " + file
				if attached orig_file as l_orig_file then
					Result.append ({STRING_32} "%N" + l_orig_file)
				end
			end

			if attached config as l_config then
				Result.append ({STRING_32} "%NConfiguration: " + l_config)
			end
		end

feature -- Update

	set_config (a_config: detachable READABLE_STRING_GENERAL)
			-- Set `config' to `a_config'.
		do
			if a_config = Void then
				config := Void
			else
				config := a_config.to_string_32
			end
		end

	set_original_file (a_file: READABLE_STRING_GENERAL)
			-- Set `orig_file' to `a_file'.
		require
			a_file_not_void: a_file /= Void
		do
			orig_file := a_file.to_string_32
		ensure
			orig_file_set: orig_file = a_file
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
