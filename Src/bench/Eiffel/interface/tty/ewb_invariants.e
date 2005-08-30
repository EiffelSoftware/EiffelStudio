indexing
	description: "Displays invariants in output_window."
	date: "$Date$"
	revision: "$Revision$"

class EWB_INVARIANTS 

inherit
	EWB_COMPILED_CLASS
		rename
			name as invariants_cmd_name,
			help_message as invariants_help,
			abbreviation as invariants_abb
		end

create
	make, default_create

feature {NONE} -- Properties

	associated_cmd: E_SHOW_INVARIANTS is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			create Result
		end

end
