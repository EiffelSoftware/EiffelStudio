note
	description: "[
			Objects that represent an IRON_NODE_LOG entry
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_LOG

create
	make,
	make_now

feature {NONE} -- Initialization

	make (dt: DATE_TIME; a_title: like title; a_content: like content)
			-- Initialize `Current'.
		do
			time := dt
			title := a_title
			content := a_content
		end

	make_now (a_title: like title; a_content: like content)
			-- Initialize `Current'.
		do
			make (create {DATE_TIME}.make_now_utc, a_title, a_content)
		end

feature -- Access

	type: detachable READABLE_STRING_8

	time: DATE_TIME

	title: READABLE_STRING_32

	content: detachable READABLE_STRING_32

feature -- Change

	set_type (a_type: like type)
		require
			is_valid_type: is_valid_type (a_type)
		do
			type := a_type
		end

feature -- Status report

	is_valid_type (a_type: like type): BOOLEAN
			-- Is `a_type' a valid log type?
		local
			i,n: INTEGER
		do
			Result := True
			if a_type /= Void then
				n := a_type.count
				if n > 0 then
					from
						i := 1
					until
						i > n or Result = False
					loop
						Result := a_type[i].is_alpha_numeric
						i := i + 1
					end
				end
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
