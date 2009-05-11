note
	description: "[
		no comment yet
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
		export
			{NONE} all
			{ANY} execute, has_executed, is_successful
		end

	XWA_CONFIG_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_single_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_NATURAL_RANGE_VALIDATOR}.make (1, 65000))
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access

	port: INTEGER
		require
			is_successful: is_successful
		do
			check l_value_is_natural: value.is_natural end
			Result := value.to_natural
		end


feature -- Status report

	is_interactive: BOOLEAN
		--
		require
			is_successful: is_successful
		do
			Result := has_option (interactive_option_switch)
		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Web Application"
			-- <Precursor>

	non_switched_argument_name: STRING = "port"
			-- <Precursor>

	non_switched_argument_description: STRING = "A port on which the Xebra Server can connect to the Web Application."
			-- <Precursor>

	non_switched_argument_type: STRING = "N"
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
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (interactive_option_switch, "Runs the application in interactive mode such that the user can shut it down via console.", False, False))
		end


feature {NONE} -- Switches

	interactive_option_switch: STRING = "i|interactive"

end

