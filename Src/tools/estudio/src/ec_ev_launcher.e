indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_EV_LAUNCHER

inherit
	EC_LAUNCHER
		undefine
			default_create, copy
		redefine
			make, new_splasher, exit_launcher
		end

	EV_APPLICATION
		rename
			implementation as ev_implementation,
			launch as ev_launch
		end

create
	make

feature {NONE} -- Creation

	make is
		do
			default_create
			Precursor
			ev_launch
		end

	exit_launcher is
		local
			timeout: EV_TIMEOUT
		do
			if is_launched then
				Precursor
			else
				create timeout.make_with_interval (3 * 1000) -- 3 seconds seems ok 
				timeout.actions.extend (agent exit_launcher)
			end
		end

	new_splasher (t: STRING_GENERAL): EV_SPLASH_DISPLAYER is
		do
			create Result.make_with_text (t)
		end

end
