note
	description: "Summary description for {GIT_REMOTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GIT_REMOTE

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	location: detachable IMMUTABLE_STRING_8
		local
			s: like fetch_location
		do
			Result := push_location
			s := fetch_location
			if Result /= Void then
				if s /= Void and then not Result.same_string (s) then
					Result := Void
				end
			else
				Result := s
			end
		end

	push_location: detachable IMMUTABLE_STRING_8

	fetch_location: detachable IMMUTABLE_STRING_8

feature -- Element change

	set_push_location (a_location: detachable READABLE_STRING_8)
		do
			if a_location = Void then
				push_location := Void
			else
				push_location := a_location
			end
		end

	set_fetch_location (a_location: detachable READABLE_STRING_8)
		do
			if a_location = Void then
				fetch_location := Void
			else
				fetch_location := a_location
			end
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
