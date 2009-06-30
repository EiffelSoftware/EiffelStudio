note
	description: "[
		A general purpose exception for all XML-RPC exception cases
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			message
		end

feature {NONE} -- Initialization

	make (a_message: READABLE_STRING_8)
			-- Initialized the exception using a predefined error message.
			--
			-- `a_message': The error message to set on the exception.
		require
			a_message_attached: attached a_message
			not_a_message_is_empty: not a_message.is_empty
		do
			default_create
			set_message (a_message)
		ensure
			message_set: message ~ a_message
		end

feature -- Access

	message: STRING
			-- <Precursor>
		do
			if attached Precursor as l_result then
				Result := l_result
			else
				Result := "Unknown error occurred!"
			end
		ensure then
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

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
