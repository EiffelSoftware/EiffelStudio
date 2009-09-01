note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_DATE

inherit
	C_DATE

create
	default_create,
	make_utc

feature -- Access

	unix_time_stamp: NATURAL
			-- Compute the seconds since EPOC (January 1st 1970)
		do
			Result := (year_now.to_natural_32 - 1970)* 12 * 30 * 24 * 60 * 60
			Result := Result + month_now.to_natural_32 * 30 * 24 * 60 * 60
			Result := Result + day_now.to_natural_32 * 24 * 60 * 60
			Result := Result + hour_now.to_natural_32 * 60 * 60
			Result := Result + minute_now.to_natural_32 * 60
			Result := Result + second_now.to_natural_32
		end

	time_stamp_milliseconds: NATURAL
			-- Compute the milliseconds since EPOC (January 1st 1970)
		do
			Result := unix_time_stamp * 1000
			Result := Result + millisecond_now.to_natural_32
		end

feature -- Basic Operations

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
