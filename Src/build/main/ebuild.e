indexing
	description: "Entry point for EiffelBuild."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class EBUILD

inherit
	EV_APPLICATION
		redefine
			make
		end

	WINDOWS

	CONSTANTS

	ARGUMENTS

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

feature {NONE} -- Initialization

	make is
		local
			init: INIT_CHECK
			error: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				create init
				init.perform_initial_check
				if init.error then
					error := True
				elseif init_license then
						-- Initialize the resources
					presentation_window.show
					if resources = Void then end
					if argument_count > 0 then
						project_directory := argument (1)
					end
					{EV_APPLICATION} Precursor
					discard_license
				end
			else
				error := True
			end
			if error then
			   if popuper_parent /= Void then
					error_dialog.popup (Current, Messages.crash_error, Void)
					error := False
				else
					io.error.putstring (Messages.crash_error)
					io.error.new_line
				end				
			end
		rescue
			if not Resources.fail_on_rescue
			and then (not is_signal or else signal /= Sigint)
			then
				no_message_on_failure
				retried := True
				rescue_project
				retry
			end
		end

feature {NONE} -- Implementation

	Application_name: STRING is "eiffelbuild"

	init_license: BOOLEAN is
		do
			license.get_license
			license.set_version (3)
			license.set_application_name (Application_name)
			Result := license.licensed
		end

	rescue_project is
		local
--			storer: STORER
		do
			if main_window.project_initialized then
				history_window.wipe_out
--				create storer.make
--				storer.store (Environment.restore_directory)
			end
		end

end -- class EBUILD

