note
	description: "Time used by event library."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_TIME

inherit
	EVENT_ANY

create
	make,
	make_infinite

feature {NONE} -- Initialize

	make_infinite
			-- Make infinite
		do
			default_create
		end

	make (sec, usec: INTEGER)
			-- Init
		require
			sec_valid: sec >= 0
			usec_valid: usec >= 0
		do
			default_create
			second := sec
			minisecond := usec
			item := c_create_timeval
			c_set_timeval (item, sec, usec)
		end

feature -- Access

	second: INTEGER

	minisecond: INTEGER

feature {NONE} -- Removal

	destroy_item
			-- <precursor>
		do
			c_free (item)
		end

feature {NONE} -- Externals

	c_create_timeval: POINTER
			-- Create timeval structure
		external
			"C inline"
		alias
			"return malloc (sizeof (struct timeval));"
		end

	c_set_timeval (a_time: POINTER; sec, usec: INTEGER)
			-- Create timeval structure
		external
			"C inline"
		alias
			"[
				struct timeval *p = (struct timeval *)$a_time;
				p -> tv_sec = $sec;
				p -> tv_usec = $usec;
			]"
		end

end
