note
	description: "Summary description for {ES_ACCOUNT_PLAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_PLAN

create
	make

feature {NONE} -- Creation

	make (a_name: READABLE_STRING_8)
		do
			create name.make_from_string (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_8

	plan_id: INTEGER_64

	creation_date: detachable DATE_TIME

	expiration_date: detachable DATE_TIME

	days_remaining: INTEGER

	is_active: BOOLEAN
		do
			if attached expiration_date as l_exp then
				Result := l_exp >= create {DATE_TIME}.make_now_utc
			elseif days_remaining < 0 then
				Result := False
			else
				Result := True
			end
		end

feature -- Element change

	set_plan_id (a_plan_id: INTEGER_64)
		do
			plan_id := a_plan_id
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

	set_expiration_date (dt: like expiration_date)
		do
			expiration_date := dt
		end

	set_days_remaining (nb: INTEGER)
		do
			days_remaining := nb
		end

;note
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
