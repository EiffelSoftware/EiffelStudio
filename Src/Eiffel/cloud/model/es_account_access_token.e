note
	description: "Summary description for {ACCOUNT_ACCESS_TOKEN}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_ACCESS_TOKEN

create
	make

feature {NONE} -- Creation

	make (tok: READABLE_STRING_8)
		do
			create token.make_from_string (tok)
			initialize
		end

	initialize
		local
			l_loader: JWT_LOADER
			ctx: detachable JWT_CONTEXT
		do
			create l_loader
			create ctx
				-- FIXME: here we would need RSA or share a unique secret key from the server...
			ctx.ignore_validation (True)
			if attached l_loader.token (token, Void, "", ctx) as jwt then
				expiration_date := jwt.claimset.expiration_time
			end
		end

feature -- Access

	token: IMMUTABLE_STRING_8

	refresh_key: detachable READABLE_STRING_8

	expiration_date: detachable DATE_TIME

	expiration_delay_in_seconds: INTEGER_64
		do
			if attached expiration_date as dt then
				Result := dt.relative_duration (create {DATE_TIME}.make_now_utc).seconds_count
			else
				Result := -1
			end
		end

feature -- Status report

	is_expired: BOOLEAN
		local
			dt: DATE_TIME
		do
			if attached expiration_date as l_expiration then
				create dt.make_now_utc
				Result := l_expiration < dt
			end
		end

	has_refresh_key: BOOLEAN
		do
			Result := refresh_key /= Void
		end

feature -- Element change

	set_expiration_date (dt: DATE_TIME)
		do
			expiration_date := dt
		end

	set_refresh_key (k: detachable READABLE_STRING_8)
		do
			refresh_key := k
		end

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
