note
	description: "Summary description for {ES_ACCOUNT_INSTALLATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_INSTALLATION

create
	make_with_id

feature {NONE} -- Creation

	make_with_id (a_id: READABLE_STRING_8)
		do
			create id.make_from_string (a_id)
			is_active := True
		end

feature -- Access

	id: IMMUTABLE_STRING_8

	creation_date: detachable DATE_TIME

	info: detachable READABLE_STRING_8

	associated_license: detachable ES_ACCOUNT_LICENSE

	associated_plan: detachable ES_ACCOUNT_PLAN

	adapted_licenses: detachable LIST [ES_ACCOUNT_LICENSE]

feature -- Status report

	is_active: BOOLEAN

feature -- Optional properties

	platform: detachable IMMUTABLE_STRING_8

feature -- Element change

	set_associated_license (lic: like associated_license)
		do
			associated_license := lic
			if lic /= Void then
				associated_plan := lic.associated_plan
			else
				associated_plan := Void
			end
		end

	set_adapted_licenses (lics: like adapted_licenses)
		do
			adapted_licenses := lics
		end

	set_associated_plan (a_plan: like associated_plan)
		do
			associated_plan := a_plan
		end

	set_platform (pf: detachable READABLE_STRING_8)
		do
			if pf = Void then
				platform := Void
			else
				create platform.make_from_string (pf)
			end
		end

	set_info (inf: detachable READABLE_STRING_8)
		do
			info := inf
		end

	mark_active
		do
			is_active := True
		end

	mark_inactive
		do
			is_active := False
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end


;note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
