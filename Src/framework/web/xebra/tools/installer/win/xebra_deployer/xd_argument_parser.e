note
	description: "[
		Parses arguments to launch xebra_deployer.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"
class
	XD_ARGUMENT_PARSER

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

	install_dir: STRING
			-- The path of install directory
		require
			is_successful: is_successful
		do
			Result := value
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Deploy Replacer"
			-- <Precursor>

	non_switched_argument_name: STRING = "install_dir"
			-- <Precursor>

	non_switched_argument_description: STRING = "The path of installed xebra files and folders"
			-- <Precursor>

	non_switched_argument_type: STRING = "folder name"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			Result := {XU_CONSTANTS}.Version
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (2)
--			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make (debug_level_switch, "Specifies a debug level. 0: No debug output. 10: All debug ouput.", True, False, "debug_level", "The debug level (0-10)", False))
--			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "If set, all webapps will be cleaned", True, False))
--			Result.extend (create {ARGUMENT_SWITCH}.make (assume_webapps_are_running_switch, "If set, the server assumes that the webapps are already running and does not translate, compile and run them before connect to them.", True, False))
		end


--feature {NONE} -- Switches

--	debug_level_switch: STRING = "d|debug_level"
--	clean_switch: STRING = "c|clean"
--	assume_webapps_are_running_switch: STRING = "r|assume_webapps_are_running"

end

