class TEST

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_argument
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			make_argument (True, True)
			execute (agent do_nothing)
		end

feature {NONE} -- Usage

	name: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "Argument parser test"
		end

	version: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "1.0"
		end

	copyright: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "Copyright (c) 2014, Eiffel Software. All Rights Reserved."
		end

feature {NONE} -- Switches

	non_switched_argument_name: STRING = "command"
			-- <Precursor>

	non_switched_argument_description: STRING = "Command to be executed."
			-- <Precursor>

	non_switched_argument_type: STRING = "Command line"
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (0)
		end

end
