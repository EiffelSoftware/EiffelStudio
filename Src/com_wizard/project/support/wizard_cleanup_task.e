indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CLEANUP_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is "Cleaning up destination folder"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			Result := 1
		end

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		local
			l_folder: DIRECTORY
			l_retried: BOOLEAN
			l_folder_name: STRING
		do
			if not l_retried then
				l_folder_name := environment.destination_folder.twin
				if l_folder_name.item (l_folder_name.count) = '\' then
					l_folder_name.keep_head (l_folder_name.count - 1)
				end
				create l_folder.make (l_folder_name)
				if l_folder.exists then
					l_folder.delete_content
				else
					environment.set_abort (Destination_folder_cleanup_error)
					environment.set_error_data (environment.destination_folder)
				end
				progress_report.step
			else
				environment.set_abort (Destination_folder_cleanup_error)
				environment.set_error_data (environment.destination_folder)
			end
		rescue
			l_retried := True
			retry
		end

end -- class WIZARD_CLEANUP_TASK
