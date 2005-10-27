indexing
	description: "Graphical builder application."
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
			launch as environment_launch
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_SHARED_PREFERENCES
		undefine
			copy, default_create
		end

	GB_EIFFEL_ENV
		export
			{NONE} all
		undefine
			copy, default_create
		end

	GB_SHARED_INTERNAL_COMPONENTS
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
			environment_dialog: INVALID_ENVIRONMENT_DIALOG
		do
			default_create
			initialize_eiffelbuild
			components := new_build_components
			components.tools.set_main_window (create {GB_MAIN_WINDOW}.make_with_components (components))
				-- Ensure that the preferences are initialized correctly.
			if environment_variables_warning = Void then
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
			else
					-- The necessary environment variables are not present, so
					-- display a warning dialog instead of launching EiffelBuild.
				create environment_dialog
				environment_dialog.warning_label.set_text ("EiffelBuild was unable to launch for the following reasons: %N%N" + environment_variables_warning + "%N%NPlease check your installation.")
				environment_dialog.show
				launch
			end
		end

	environment_variables_warning: STRING is
			-- `Result' is warning message indicating missing environment
			-- variables, or `Void' if none are missing.
		local
			temp: STRING
		once
			Result := ""
			temp := eiffel_installation_dir_name
			if temp = Void or else temp.is_empty then
				Result.append ("The Environment variable $ISE_EIFFEL is not set.")
			end
			temp := eiffel_platform
			if temp = Void or else temp.is_empty then
				if not result.is_empty then
					Result.append ("%N")
				end
				Result.append ("The Environment variable $ISE_PLATFORM is not set.")
			end
			if Result.is_empty then
				Result := Void
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

end
