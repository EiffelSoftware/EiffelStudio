note
	description: "[
		Represents a special version of request with only few attributes.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_MINI_REQUEST

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			webapp := ""
			post_too_big := False
		end

feature -- Access

	webapp: STRING
		-- The name of the webapp (extracted from uri)

	post_too_big: BOOLEAN
		-- True if the module added the post_too_big flag to the request

feature -- Status setting

	set_webapp (a_webapp: like webapp)
			-- Sets webapp.
		require
			a_webapp_attached: a_webapp /= Void
		do
			webapp := a_webapp
		ensure
			webapp_set: webapp ~ a_webapp
		end

	set_post_too_big (a_post_too_big: like post_too_big)
			-- Sets post_too_big.
		do
			post_too_big := a_post_too_big
		ensure
			post_too_big_set: post_too_big ~ a_post_too_big
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

