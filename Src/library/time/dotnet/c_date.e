indexing
	description: "Representation of a date on .NET"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	C_DATE

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_utc

feature {NONE} -- Initialization

	default_create is
			-- Create an instance of C_DATA using current local time.
		do
			is_utc := False
			update
		end

	make_utc is
			-- Create an instance of C_DATE holding UTC values.
		do
			is_utc := True
			update
		ensure
			is_utc: is_utc
		end

feature -- Access

	is_utc: BOOLEAN
			-- Is Current holding value in UTC format?

feature -- Update

	update is
			-- Pointer to `struct tm' area.
		local
			l_now: SYSTEM_DATE_TIME
		do
			if is_utc then
				l_now := {SYSTEM_DATE_TIME}.utc_now
			else
				l_now := {SYSTEM_DATE_TIME}.now
			end
			year_now := l_now.year
			month_now := l_now.month
			day_now := l_now.day
			hour_now := l_now.hour
			minute_now := l_now.minute
			second_now := l_now.second
			millisecond_now := l_now.millisecond
		end

feature -- Status

	year_now: INTEGER
			-- Current year at creation time or after last call to `update'.

	month_now: INTEGER
			-- Current month at creation time or after last call to `update'.

	day_now: INTEGER
			-- Current day at creation time or after last call to `update'.

	hour_now: INTEGER
			-- Current hour at creation time or after last call to `update'.

	minute_now: INTEGER
			-- Current minute at creation time or after last call to `update'.

	second_now: INTEGER
			-- Current second at creation time or after last call to `update'.

	millisecond_now: INTEGER;
			-- Current millisecond at creation time or after last call to `update'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class C_DATE
