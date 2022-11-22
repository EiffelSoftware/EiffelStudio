note
	description: "Error for a failure during metadata consumer execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_METADATA_CONSUMER_FAILURE

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Creation

	make (m: like cause)
			-- Initialize an error with the cause `m`.
		do
			cause := m
		ensure
			cause = m
		end

feature {NONE} -- Access

	cause: READABLE_STRING_32
			-- The cause of the error.

feature -- Access

	text: READABLE_STRING_32
			-- <Precursor>
		do
			Result := {SHARED_LOCALE}.locale.formatted_string ({SHARED_LOCALE}.locale.translation_in_context
						({STRING_32} "Failed to consume .NET metadata: $1",
						"configuration.compiler"), cause)
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
