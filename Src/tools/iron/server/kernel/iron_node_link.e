note
	description: "Summary description for {IRON_NODE_LINK}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_LINK

create
	make

feature {NONE} -- Initialization

	make (a_url: like url; a_title: like title)
			-- Create Current link with url `a_url' and title `a_title'.
		require
			a_url_not_empty: not a_url.is_empty
		do
			set_url (a_url)
			set_title (a_title)
		end

feature -- Access

	url: READABLE_STRING_8
			-- Associated URL.

	title: detachable READABLE_STRING_32
			-- Encoded title.

feature -- Change

	set_url (a_url: like url)
		require
			a_url_not_empty: not a_url.is_empty
		do
			url := a_url
		end

	set_title (a_title: like title)
		do
			if a_title = Void or else a_title.is_empty then
				title := Void
			else
				title := a_title
			end
		end


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
