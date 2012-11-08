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

	orig_file, file: STRING_32
			-- File that could not be opened.

	config: STRING_32
			-- Config where the file was referenced.

	text: STRING_32
			-- The error message.
		do
			check
				file_not_void: file /= Void
			end
			Result := {STRING_32} "Could not open file: " + file
			if attached orig_file as l_orig_file then
				Result.append ({STRING_32} "%N" + l_orig_file)
			end
			if attached config as l_config then
				Result.append ({STRING_32} "%NConfiguration: " + l_config)
			end
		end

feature -- Update

	set_config (a_config: READABLE_STRING_GENERAL)
			-- Set `config' to `a_config'.
		require
			a_config_not_void: a_config /= Void
		do
			config := a_config.to_string_32
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
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
