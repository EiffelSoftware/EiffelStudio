note
	description: "Summary description for {XTAG_ARGUMENT_PARSER}."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		end
create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_option_parser (False)
			set_is_showing_argument_usage_inline (False)
		end

feature -- Status report

	output_path: FILE_NAME
			-- The input_path
		require
			is_successful: is_successful
		do
			create Result.make
			if attached option_of_name (output_path_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Translator"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			Result := "Pre-release"
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (output_path_switch, "Specifies the path to the output directory", False, False, "output_path", "The output directory path", False))
		end

feature {NONE} -- Switches

	output_path_switch: STRING = "o|output_path"

end
