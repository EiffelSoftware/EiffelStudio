indexing
	description	: "Command to launch EiffelCase."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_LAUNCH_CASE_COMMAND

inherit
	EB_COMMAND

	CASE_COMMAND_EXECUTOR
		rename
			execute as launch_ecase
		end

feature -- License managment
	
	license_checked: BOOLEAN is True
			-- Is the license checked.

feature {NONE} -- Implementation

	execute (argument: EV_FILE_OPEN_DIALOG) is
		local
--			file_name: STRING
			ecase_name: STRING
		do
			ecase_name := case_command_name
--			ecase_name.append (" ")
--			ecase_name.append (file_name)
			launch_ecase (ecase_name)
		end


end -- class EB_LAUNCH_CASE_COMMAND
