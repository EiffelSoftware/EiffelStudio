indexing
	description: "Invoke finalization of the eiffel system."
	date: "$Date$"
	revision: "$Revision$"

class EWB_F_COMPILE

inherit

	EWB_C_CODE
		rename
			name as f_compile_cmd_name,
			help_message as f_compile_help,
			abbreviation as f_compile_abb
		redefine
			workbench_mode
		end;

feature {NONE} -- Properties

	workbench_mode: BOOLEAN is False
			-- Not in workbench mode

end -- class EWB_F_COMPILE
