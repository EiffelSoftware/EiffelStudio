note
	description: "Summary description for {ES_ACCOUNT_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_SESSION

inherit
	EIFFEL_LAYOUT

create
	make,
	make_new

feature {NONE} -- Initialization

	make (acc: ES_ACCOUNT; a_session_id: READABLE_STRING_32)
		do
			account := acc
			set_id (a_session_id)
		end

	make_new (acc: ES_ACCOUNT)
		local
			inst: ES_INSTALLATION_ENVIRONMENT
			s: STRING_32
		do
			create s.make_from_string_general ((create {UUID_GENERATOR}).generate_uuid.out)
			create inst.make (eiffel_layout)
			if attached inst.username as u then
				s.append_character ('-')
				s.append (u)
			end
			make (acc, s)
		end

feature -- Access

	account: ES_ACCOUNT

	is_paused: BOOLEAN

	id: IMMUTABLE_STRING_32

	title: detachable READABLE_STRING_32

feature -- Element change

	set_is_paused (b: like is_paused)
		do
			is_paused := b
		end

	set_id (a_sid: READABLE_STRING_GENERAL)
		do
			if attached {IMMUTABLE_STRING_32} a_sid as s then
				id := s
			else
				create id.make_from_string_general (a_sid)
			end
		end

	set_title (a_title: detachable READABLE_STRING_32)
		do
			title := a_title
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
