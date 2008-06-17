indexing
	description: "Graphical builder application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date : "$Date$"
	id : "$Id$"
	revision : "$Revision$"

class
	GB

inherit

	EV_APPLICATION
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as environment_launch,
			sleep as nano_sleep
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_SHARED_PREFERENCES
		undefine
			copy, default_create
		end

	GB_SHARED_INTERNAL_COMPONENTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	execute

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	execute is
			-- Execute `Current'.
			-- There are sections of commented code in here which interpret the command
			-- line for different launches. Each starts with a check to ensure that the
			-- system never gets compiled with more than one command option available.
		local
			l_env: GB_EIFFEL_LAYOUT
		do
				-- Initialize the environment
			create l_env
			l_env.check_environment_variable
			set_eiffel_layout (l_env)

			default_create
			initialize_eiffelbuild
			components := new_build_components
			components.tools.set_main_window (create {GB_MAIN_WINDOW}.make_with_components (components))
				-- Ensure that the preferences are initialized correctly.
			if eiffel_layout.is_valid_environment then
					-- Only launch EiffelBuild if the required environment variables are
					-- available, otherwise we must display a fatal error message.

				if command_line.argument_array.count = 1 then
						-- If `argument_array' has one element,
						-- then no argument was specified, only the
						-- name of the executable.
					components.xml_handler.load_components
					components.tools.main_window.show
					post_launch_actions.extend (agent display_tip_of_the_day)
					launch
				elseif command_line.argument_array.count = 2 then
					components.xml_handler.load_components
					components.tools.main_window.show
					post_launch_actions.extend (agent open_with_name (command_line.argument_array @ 1))
					post_launch_actions.extend (agent display_tip_of_the_day)
					launch
				end
			end
		end

--	pick_and_drop_motion (an_x, a_y: INTEGER; target: EV_ABSTRACT_PICK_AND_DROPABLE) is
--			-- Respond to a global pick and drop motion.
--		do
--			components.status_bar.clear_status_during_transport (an_x, a_y, target)
--		end
--
--	pick_and_drop_started (pebble: ANY) is
--			-- Respond to a pick and drop starting.
--		require
--			pebble_not_void: pebble /= Void
--		do
--			components.system_status.set_pick_and_drop_pebble (pebble)
--			components.commands.update
--		end
--
--	pick_and_drop_cancelled (pebble: ANY) is
--			-- Respond to the cancelling of a pick and drop.
--		require
--			pebble_not_void: pebble /= Void
--		do
--			components.system_status.remove_pick_and_drop_pebble
--			components.status_bar.clear_status_after_transport (pebble)
--			components.commands.update
--		end
--		
--	pick_and_drop_completed (pebble: ANY) is
--			-- Respond to the successful completion of a pick and drop.
--		require
--			pebble_not_void: pebble /= Void
--		do
--			end_digit_processing (pebble)
--			components.system_status.remove_pick_and_drop_pebble
--			components.commands.update
--		end

feature {NONE} -- Implementation

	display_tip_of_the_day is
			-- Display a tip of the day dialog if not disabled from preferences.
		do
			if preferences.global_data.show_tip_of_the_day then
				components.tools.tip_of_the_day_dialog.show_modal_and_centered_to_window (components.tools.main_window)
			end
		end

	open_with_name (f: STRING) is
			-- Use the open project command to open
			-- file `f'.
		require
			f_not_void: f /= Void
		do
			components.commands.Open_project_command.execute_with_name (f)
		end

--	end_digit_processing (pebble: ANY) is
--			-- End processing on `digit_checker'. `pebble' is not
--			-- used.
--		do
--			digit_checker.end_processing	
--		end

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
