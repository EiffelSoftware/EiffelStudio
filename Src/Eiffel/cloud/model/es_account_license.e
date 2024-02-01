note
	description: "Summary description for {ES_ACCOUNT_LICENSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_LICENSE

create
	make

feature {NONE} -- Creation

	make (a_key: READABLE_STRING_8)
		do
			create key.make_from_string (a_key)
		end

feature -- Access

	key: IMMUTABLE_STRING_8

	plan_name: detachable IMMUTABLE_STRING_8

	plan_id: INTEGER_64

	creation_date: detachable DATE_TIME

	expiration_date: detachable DATE_TIME

	days_remaining: INTEGER

	is_fallback: BOOLEAN

	is_suspended: BOOLEAN

	is_active: BOOLEAN
		do
			Result := (not is_expired or is_fallback) and then not is_suspended
		ensure
			Result implies (not is_expired or is_fallback)
			Result implies not is_suspended
		end

	is_expired: BOOLEAN
		do
			if attached expiration_date as l_exp then
				Result := l_exp < create {DATE_TIME}.make_now_utc
			elseif days_remaining < 0 then
				Result := True
			else
				Result := False
			end
		end

	plan_limitations_string: detachable READABLE_STRING_8
			-- Usage limitations from associated plan.

feature -- Access

	associated_plan: detachable ES_ACCOUNT_PLAN
		do
			if attached plan_name as l_name then
				create Result.make (l_name)
				Result.set_plan_id (plan_id)
				Result.set_creation_date (creation_date)
				Result.set_expiration_date (expiration_date)
				Result.set_days_remaining (days_remaining)
			end
		end

feature -- Element change

	set_is_fallback (b: Like is_fallback)
		do
			is_fallback := b
		end

	set_is_suspended (b: like is_suspended)
		do
			is_suspended := b
		end

	set_plan_name (a_plan_name: READABLE_STRING_8)
		do
			plan_name := a_plan_name
		end

	set_plan_limitations_string (a_plan_lim: detachable READABLE_STRING_8)
		do
			plan_limitations_string := a_plan_lim
		end

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
