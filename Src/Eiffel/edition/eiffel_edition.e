note
	description: "Summary description for {ES_EDITION_INFORMATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_EDITION

feature -- Access

	edition_name: STRING
		deferred
		end

	is_standard_edition: BOOLEAN
			-- Is Standard edition?
		deferred
		end

	is_enterprise_edition: BOOLEAN
			-- Is Enterprise edition?
		deferred
		end

	is_branded_edition: BOOLEAN
		deferred
		end

feature -- Additional information

	branded_edition_title: detachable IMMUTABLE_STRING_32
	
	edition_license_key: detachable IMMUTABLE_STRING_32

	edition_expiration: detachable DATE_TIME
			-- Expiration date time (UTC).

	number_of_remaining_days: INTEGER
		require
			edition_expiration /= Void
		local
			l_dur: DATE_TIME_DURATION
		do
			if attached edition_expiration as dt then
				l_dur := dt.relative_duration (create {DATE_TIME}.make_now_utc)
				l_dur.day_add (1)
				Result := l_dur.day
			end
		end

feature -- Element change

	set_edition_license_key (k: detachable READABLE_STRING_GENERAL)
			-- Set optional `edition_expiration` to UTC time `dt`.
		do
			if k = Void then
				edition_license_key := Void
			else
				edition_license_key := k
			end
		end

	set_edition_expiration (dt: DATE_TIME)
			-- Set optional `edition_expiration` to UTC time `dt`.
		do
			edition_expiration := dt
		end

	set_branded_edition_title (a_title: detachable READABLE_STRING_GENERAL)
		do
			if a_title = Void then
				branded_edition_title := Void
			else
				branded_edition_title := a_title
			end
		end


invariant
	is_standard_edition xor is_enterprise_edition xor is_branded_edition

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
