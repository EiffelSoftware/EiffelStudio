indexing
	description: "Entry point for EiffelBuild."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class EBUILD 

inherit

	CONSTANTS
	ARGUMENTS
	WINDOWS
	SHARED_LICENSE
	UNIX_SIGNALS
		rename
			meaning as sig_meaning,
			ignore as sig_ignore,
			catch as sig_catch
		end
	ERROR_POPUPER

creation
	make

feature 

	make is
		local
			init: INIT_CHECK
--			temp: STRING
			error: BOOLEAN
		do
--			no_message_on_failure
			if not retried then
				init_windowing
				!!init
				init.perform_initial_check
				if init.error then
					error := True
					exit
				elseif init_licence then
						-- Initialize the resources
					if resources = Void then end
					init_project
					read_command_line
					iterate
					discard_license
				end
			else
				error := True
			end
			if error then
--				temp := original_tag_name
--				if temp = Void then
--					!! temp.make (0)
--				end
				error_box.popup (Current, Messages.crash_error, Void)
				error_box.error_d.set_x_y (eb_screen.width // 2 -
					error_box.error_d.width // 2,
					eb_screen.height // 2 - error_box.error_d.height // 2)
				iterate
			end
		rescue
--			discard_license
			if not Resources.fail_on_rescue
			and then (not is_signal or else signal /= Sigint)
			then
				retried := True
				rescue_project
				retry
			end
		end

	popuper_parent: COMPOSITE is	
		do
			Result := main_panel.base
		end

feature {NONE} -- Initialize toolkit

	init_windowing is
			-- Initialize toolkit
		do
			if (init_toolkit = Void) then end
			presentation_window.realize
			if (toolkit = Void) then end
		end

feature {NONE}

	Application_name: STRING is "eiffelbuild"

	init_licence: BOOLEAN is
		do
			license.get_license
			license.set_version (3)
			license.set_application_name (Application_name)
			Result := license.licensed
		end

	read_command_line is
		local
			cmd: OPEN_PROJECT
		do
			if argument_count > 1 then
				!! cmd
				cmd.execute (argument (1))
			end
		end

	retried: BOOLEAN

	rescue_project is
		local
			storer: STORER
		do
			if main_panel.project_initialized then
				history_window.wipe_out
				!! storer.make
				storer.store (Environment.restore_directory)
			end
		end

end
