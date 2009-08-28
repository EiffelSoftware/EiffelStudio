note
	description: "[
			Represents a message that is sent from and to the http server plugin.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			length := 0
			flag := False
			string := ""
		ensure
			string_attached: string /= Void
		end

feature -- Access


	length: NATURAL assign set_length
		-- The retrieved length of the message

	flag: BOOLEAN assign set_flag
		-- Determines if there is another fragment coming

	string: STRING
		-- The message

feature -- Constants

	Message_upper_bound: NATURAL = 65536
			-- Upper bound for a message fragment

	Message_default_bound: NATURAL = 32768
			-- Default bound for a message fragment

feature -- Status report

	is_length_valid: BOOLEAN
			-- Checks if the length is between 0 and Message_upper_bound
		do
			Result := (length > 0) and (length <= Message_upper_bound)
		end
feature -- Status setting

	append_string (a_string: READABLE_STRING_8)
			-- Appends a string
		do
			string.append (a_string)
		ensure
			new_length_ok: string.count = old string.count + a_string.count
		end

	set_length (a_length: NATURAL)
			-- Sets length.
		do
			length := a_length
		ensure
			length_set: length ~ a_length
		end

	set_flag (a_flag: BOOLEAN)
			-- Sets flag.
		do
			flag := a_flag
		ensure
			flag_set: flag ~ a_flag
		end

invariant
	string_attached: string /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
end
