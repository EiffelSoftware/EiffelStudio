note
	description: "Summary description for {ES_ACCOUNT_LICENSE_ISSUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_LICENSE_ISSUE

create
	make

feature {NONE} -- Initialization

	make (a_acc: ES_ACCOUNT)
		do
			account := a_acc
		end

feature -- Access

	license: detachable ES_ACCOUNT_LICENSE

	account: ES_ACCOUNT

	reason: detachable IMMUTABLE_STRING_32

feature -- Element

	set_license (a_lic: like license)
		do
			license := a_lic
		end

	set_reason (s: READABLE_STRING_GENERAL)
		do
			create reason.make_from_string_general (s)
		end

	set_license_expired
		do
			set_reason ("license expired")
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
