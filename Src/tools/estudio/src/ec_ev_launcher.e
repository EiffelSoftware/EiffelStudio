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
			do_ec_launching,
			close_splasher
		end

	EV_APPLICATION
		rename
			implementation as ev_implementation,
			launch as ev_launch
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Creation

	make is
		local
			l_layout: EC_EIFFEL_LAYOUT
		do
			create l_layout
				-- the user can define some variables on the command line so we do the check after we have handled this
			set_eiffel_layout (l_layout)
			default_create
			Precursor
			if not is_destroyed then
				ev_launch
			end
		end

	do_ec_launching is
		do
			post_launch_actions.extend_kamikaze (agent launch_ec)
		end

	do_exit_launcher is
		local
			timeout: EV_TIMEOUT
		do
			is_waiting := False
			create timeout.make_with_interval (splash_delay)
			timeout.actions.extend (agent exit_launcher)
			timeout.actions.extend_kamikaze (agent timeout.destroy)
		end

	exit_launcher is
		do
			Precursor
			destroy
		end

	close_splasher (delay: INTEGER_32) is
		local
			timeout: EV_TIMEOUT
		do
			if delay = 0 then
				Precursor {EC_LAUNCHER} (0)
			else
				create timeout.make_with_interval (splash_delay)
				timeout.actions.extend (agent close_splasher (0))
				timeout.actions.extend_kamikaze (agent timeout.destroy)
			end
		end

	new_splasher (t: STRING_GENERAL): EV_SPLASH_DISPLAYER is
		do
			create Result.make_with_text (t)
		end

end
