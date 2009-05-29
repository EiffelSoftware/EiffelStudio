note
	description: "[
		Parses arguments to launch a webapp.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_single_parser
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_single_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access

	config_filename: STRING
			-- The path of the config file
		require
			is_successful: is_successful
		do
			Result := value
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	debug_level: INTEGER
			-- The debug_level
		require
			is_successful: is_successful
		do
			Result := 0
			if has_option (debug_level_switch) and then attached option_of_name (debug_level_switch) as l_option then
				if l_option.value.is_integer then
					Result := l_option.value.to_integer
				end
			end
		end


feature -- Status report

--	is_interactive: BOOLEAN
--		--
--		require
--			is_successful: is_successful
--		do
--			Result := has_option (interactive_option_switch)
--		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Web Application"
			-- <Precursor>

	non_switched_argument_name: STRING = "config_filename"
			-- <Precursor>

	non_switched_argument_description: STRING = "The path of the config.ini file to use."
			-- <Precursor>

	non_switched_argument_type: STRING = "file name"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
--			create Result.make (3)
--			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
--			Result.append_character ('.')
--			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
			Result := "not implemented"
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make (debug_level_switch, "Specifies a debug level. 0: No debug output. 10: All debug ouput.", True, False, "debug_level", "The debug level (0-10)", False))
		end

feature {NONE} -- Switches


	debug_level_switch: STRING = "d|debug_level"
--	interactive_option_switch: STRING = "i|interactive"

end

