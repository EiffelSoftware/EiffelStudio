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
			make, new_splasher,
			exit_launcher, do_exit_launcher,
			do_ec_launching
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

	do_ec_launching is
		do
			post_launch_actions.extend_kamikaze (agent launch_ec)
		end

	do_exit_launcher is
		local
			timeout: EV_TIMEOUT
		do
			create timeout.make_with_interval (splash_delay)
			timeout.actions.extend (agent exit_launcher)
		end

	exit_launcher is
		do
			Precursor
			destroy
		end

	new_splasher (t: STRING_GENERAL): EV_SPLASH_DISPLAYER is
		do
			create Result.make_with_text (t)
		end

	splash_delay: INTEGER_32 is 2000 -- 2 seconds seems o

end
