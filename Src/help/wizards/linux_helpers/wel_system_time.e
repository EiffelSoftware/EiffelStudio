indexing
	description: "Objects that retrieve the system time"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_TIME

inherit
	C_DATE
		rename
			default_create as make_by_current_time,
			year_now as year,
			month_now as month,
			day_now as day,
			hour_now as hour,
			minute_now as minute,
			second_now as second
		end

create
	make_by_current_time

end -- class WEL_SYSTEM_TIME
