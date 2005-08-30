indexing
	description: "Displays class's creation procedures in output_window."
	date: "$Date$"
	revision: "$Revision $"

class EWB_CREATORS

inherit
	EWB_COMPILED_CLASS
		rename
			name as creators_cmd_name,
			help_message as creators_help,
			abbreviation as creators_abb
		end

create
	make, default_create

feature {NONE} -- Properties

    associated_cmd: E_SHOW_CREATORS is
            -- Associated class command to be executed
            -- after successfully retrieving the compiled
            -- class
        do
			create Result
        end

end
