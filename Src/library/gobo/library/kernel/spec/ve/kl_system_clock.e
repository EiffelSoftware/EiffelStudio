indexing

	description:

		"System clocks (precision to the millisecond)"

	remark:

		"With SmartEiffel under Windows the millisecond part may be stuck to zero."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_SYSTEM_CLOCK

inherit

	KI_SYSTEM_CLOCK











	TIMESTAMP
		rename
			set_local_time as old_set_local_time
		export
			{NONE} all
		undefine
			out, is_equal
		end


create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new system clock.
		do

			set (1970, 1, 1, 0, 0, 0.0)

		end




























feature -- Setting

	set_local_time is
			-- Set clock to current local time.




		do
















			old_set_local_time











		end

	set_utc_time is
			-- Set clock to current UTC time.




		do
















			set_to_now











		end








end
