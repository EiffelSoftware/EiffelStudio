indexing
	description: "Command to retrieve a stored project."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_CASE_CMD

inherit
--	SHARED_EIFFEL_PROJECT

--	SHARED_APPLICATION_EXECUTION

--	PROJECT_CONTEXT

	EV_COMMAND

	CASE_COMMAND_EXECUTOR
		rename
			execute as launch_ecase
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
		local
--			file_name: STRING
			ecase_name: STRING
		do
			ecase_name := case_command_name
--			ecase_name.append (" ")
--			ecase_name.append (file_name)
			launch_ecase (ecase_name)
		end


end -- class EB_OPEN_CASE_CMD
