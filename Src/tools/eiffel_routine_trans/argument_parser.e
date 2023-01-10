note
	description: "Report viewer's argument parser"
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		redefine
			switch_prefixes
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes argument parser.
		do
			make_option_parser (not {PLATFORM}.is_windows)
		end

feature -- Access

	input_file: detachable STRING_32
			-- Input file
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (input_file_switch) as l_value then
				Result := l_value.value
			end
		end

	translate_file: detachable STRING_32
			-- Name of template used to generate properties.
		do
			if attached {ARGUMENT_OPTION} option_of_name (translate_file_switch) as l_value then
				Result := l_value.value
			end
		end

	output_path: detachable STRING_32
			-- Output file path
		do
			if attached {ARGUMENT_OPTION} option_of_name (output_switch) as l_value then
				Result := l_value.value
			end
		end

feature {NONE} -- Usage

	name: STRING = "Eiffel Routine Translator"
			-- <Precursor>

	version: STRING = "1.0"
			-- <Precursor>

	copyright: STRING = "Copyright Eiffel Software 2012-2023. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (input_file_switch, "Input file", False, False, "file", "Name of the file to be translated", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (translate_file_switch, "TRANSLAT file", False, False, "file", "TRANSLAT file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Output file to be saved. If not specified, result will be printed", True, False, "file", "Output file", False))
		end

	Switch_prefixes: ARRAY [CHARACTER_8]
			-- <Precursor>
		once
			Result := << '-' >>
		end

feature {NONE} -- Switches

	input_file_switch: STRING = "i|input"
	translate_file_switch: STRING = "t|translate_file"
	output_switch: STRING = "o|output_file"
			-- Argument switches

end
