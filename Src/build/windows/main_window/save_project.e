indexing
	description: "Command call to save a project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SAVE_PROJECT

inherit
	LICENCE_COMMAND
		export
			{NONE} all
			{ANY} execute
		end

	CONSTANTS

	ERROR_POPUPER

feature {NONE} -- Command

	completed: BOOLEAN
		-- Was the Current save command succesfully completed?
		-- (i.e. has no error occured during the execution
		-- of the Current command)

	rescued: BOOLEAN
	
	work (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Save Current project to project_directory
		local
--			storer: STORER
--			mp: MOUSE_PTR
--			generate: GENERATE
		do
			if not rescued then
				if main_window.project_initialized then
--					!! mp
--					mp.set_watch_shape
--					!! generate
--					generate.execute (Void)
--					!! storer.make
--					storer.store (Environment.storage_directory)
--					storer := Void
--					mp.restore
					history_window.set_saved_application
					completed := True
				end
			else
				rescued := False
			end
		rescue
			if original_exception = Operating_system_exception then
				error_dialog.popup (Current, Messages.cannot_save_os_er,
									original_tag_name)
			else
				error_dialog.popup (Current, Messages.cannot_save_er,
									Environment.storage_directory)
			end
			rescued := True
--			mp.restore
			retry
		end

end -- class SAVE_PROJECT

