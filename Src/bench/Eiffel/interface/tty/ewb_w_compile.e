indexing
	description: "Command to invoke freezing of an eiffel system."
	date: "$Date$"
	revision: "$Revision$"

class EWB_W_COMPILE

inherit
	EWB_C_CODE
		rename
			name as w_compile_cmd_name,
			help_message as w_compile_help,
			abbreviation as w_compile_abb
		end

end
