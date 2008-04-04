indexing
	description: "Lanucher that start ec executable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			close_splasher,
			launch_ec_with_action
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
			-- Creation method
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
			-- Do ec launching
		do
			post_launch_actions.extend_kamikaze (agent launch_ec)
		end

	do_exit_launcher is
			-- Do exit launcher
		local
			timeout: EV_TIMEOUT
		do
			is_waiting := False
			create timeout.make_with_interval (splash_delay)
			timeout.actions.extend (agent exit_launcher)
			timeout.actions.extend_kamikaze (agent timeout.destroy)
		end

	launch_ec_with_action is
			-- <Precursor>
		do
			Precursor
			post_launch_actions.extend_kamikaze (agent send_command_to_launched_ec_and_exit)
		end

	exit_launcher is
			-- Exit launcher
		do
			Precursor
			destroy
		end

	close_splasher (delay: INTEGER_32) is
			-- Close splasher
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

	new_splasher (t: STRING_GENERAL): SPLASH_DISPLAYER_I is
			-- New splasher
		local
			l_advanced: EV_ADVANCED_SPLASH_DISPLAYER_I
		do
			create {EV_ADVANCED_SPLASH_DISPLAYER} l_advanced.make
			if l_advanced.is_executable then
				Result := l_advanced
			else
				create {EV_SPLASH_DISPLAYER} Result.make_with_text (t)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

