note
	description: "[
		Contains all information of a rfc2109 cookie that was read from the request header
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_COOKIE

create
	make

feature {NONE} -- Initialization	

	make (a_name: STRING; a_value: STRING)
			-- Creates current.
		require
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
			not_a_value_is_detached_or_empty: a_value /= Void and then not a_value.is_empty
		do
			name := a_name
			value := a_value
		ensure
			a_name_set: name = a_name
			a_value_set: value = a_value
		end

feature -- Access

	name: STRING
		--  Required.  The name of the state information ("cookie") is NAME,
		--  and its value is VALUE.  NAMEs that begin with $ are reserved for
		--  other uses and must not be used by applications.

	value: STRING
		-- The VALUE is opaque to the user agent and may be anything the
		-- origin server chooses to send, possibly in a server-selected
		-- printable ASCII encoding.  "Opaque" implies that the content is of
		-- interest and relevance only to the origin server.  The content
		-- may, in fact, be readable by anyone that examines the Set-Cookie
		-- header.


invariant
	name_attached: name /= Void
	value_attached: value /= Void
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
