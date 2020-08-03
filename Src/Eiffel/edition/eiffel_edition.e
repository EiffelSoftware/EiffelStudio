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

	edition_title: detachable IMMUTABLE_STRING_32
		do
			Result := additional_edition_text_value ("title")
		end

	edition_terms: detachable IMMUTABLE_STRING_32
		do
			Result := additional_edition_text_value ("terms")
		end

	edition_license_key: detachable IMMUTABLE_STRING_32
		do
			Result := additional_edition_text_value ("license_key")
		end

	edition_expiration: detachable DATE_TIME
			-- Expiration date time (UTC).
		do
			Result := additional_edition_date_time_value ("expiration_date")
		end

	number_of_remaining_days: INTEGER
		require
			edition_expiration /= Void
		local
			l_dur: DATE_TIME_DURATION
		do
			if attached edition_expiration as dt then
				l_dur := dt.relative_duration (create {DATE_TIME}.make_now_utc)
				l_dur.day_add (1)
				Result := l_dur.seconds_count // 60 // 60 // 24 -- 60 seconds, 60 minutes, 24 hours.
			end
		end

feature -- Element change

	set_edition_license_key (k: detachable READABLE_STRING_GENERAL)
			-- Set optional `edition_license_key` to `k`.
		do
			set_additional_edition_value ("license_key", k)
		end

	set_edition_terms (s: detachable READABLE_STRING_GENERAL)
			-- Set optional `edition_terms` to `s`.
		do
			set_additional_edition_value ("terms", s)
		end

	set_edition_expiration (dt: DATE_TIME)
			-- Set optional `edition_expiration` to UTC time `dt`.
		do
			set_additional_edition_value ("expiration_date", dt)
		end

	set_edition_title (a_title: detachable READABLE_STRING_GENERAL)
		do
			set_additional_edition_value ("title", a_title)
		end

feature {NONE} -- Implementation

	additional_edition_text_value (a_name: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_32
		do
			if attached {READABLE_STRING_GENERAL} additional_edition_value (a_name) as v then
				create Result.make_from_string_general (v)
			end
		end

	additional_edition_date_time_value (a_name: READABLE_STRING_GENERAL): detachable DATE_TIME
		do
			if attached {DATE_TIME} additional_edition_value (a_name) as v then
				Result := v
			end
		end

	additional_edition_value (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			if attached additional_edition_values as tb then
				Result := tb [a_name]
			end
		end

	set_additional_edition_value (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		local
			tb: like additional_edition_values
		do
			tb := additional_edition_values
			if tb = Void and a_value /= Void then
				create tb.make (3)
				additional_edition_values := tb
			end
			if a_value = Void then
				if tb /= Void then
					tb.remove (a_name)
				end
			elseif tb /= Void then
				tb [a_name] := a_value
			end
		end

	additional_edition_values: detachable STRING_TABLE [ANY]

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
