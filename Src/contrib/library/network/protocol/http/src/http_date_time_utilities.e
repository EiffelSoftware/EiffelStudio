note
	description: "[
			Utilities routines to manipulate date
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_DATE_TIME_UTILITIES

feature -- Access

	now_utc: DATE_TIME
		do
			create Result.make_now_utc
		end

	epoch: DATE_TIME
		once ("THREAD")
			create Result.make_from_epoch (0)
		end

feature -- Unix time stamp

	unix_time_stamp (dt: detachable DATE_TIME): INTEGER_64
			-- Unix time stamp from `dt' if attached or from epoch is detached
		local
			l_date_time: DATE_TIME
		do
			if dt /= Void then
				l_date_time := dt
			else
				l_date_time := now_utc
			end
			Result := l_date_time.definite_duration (epoch).seconds_count
		end

	fine_unix_time_stamp (dt: detachable DATE_TIME): DOUBLE
			-- Fine unix time stamp from `dt' if attached or from epoch is detached
		local
			l_date_time: DATE_TIME
		do
			if dt /= Void then
				l_date_time := dt
			else
				l_date_time := now_utc
			end
			Result := l_date_time.definite_duration (epoch).fine_seconds_count
		end

feature -- Unix time stamp conversion

	unix_time_stamp_to_date_time (i64: INTEGER_64): DATE_TIME
			-- Date time related to `i64'
		do
			create Result.make_from_epoch (i64.as_integer_32)
		ensure
			same_unix_time_stamp: unix_time_stamp (Result) = i64
		end

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
