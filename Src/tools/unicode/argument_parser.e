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

	density: REAL_64
			-- Density of generated tables.
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (density_switch) as l_value and then l_value.value.is_real_64 then
				Result := l_value.value.to_real_64
			else
				Result := 0.45
			end
		end

	input_file: detachable STRING
			-- Density of generated tables.
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (input_file_switch) as l_value then
				Result := l_value.value
			end
		end

	property_template: STRING
			-- Name of template used to generate properties.
		do
			if attached {ARGUMENT_OPTION} option_of_name (property_template_switch) as l_value then
				Result := l_value.value
			else
				Result := "character_32_property.template"
			end
		end

	output_path: STRING
			-- Path where files will be generated. By default in current directory.
		do
			if attached {ARGUMENT_OPTION} option_of_name (output_switch) as l_value then
				Result := l_value.value
			else
				Result := ""
			end
		end

feature -- Status report

	has_statistic: BOOLEAN
			-- Is generation of statistics requested?
		require
			is_successful: is_successful
		once
			Result := has_option (stat_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Unicode Helper Generator"
			-- <Precursor>

	version: STRING = "1.0"
			-- <Precursor>

	copyright: STRING = "Copyright Eiffel Software 2012-2016. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (input_file_switch, "UnicodeData.txt file", False, False, "file", "Name of UnicodeData.txt file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (density_switch, "Density for tables", True, False, "density", "Density of table as a ratio", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (property_template_switch, "Template used for generation of character properties", True, False, "template", "Template file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Directory where files will be generated", True, False, "dir", "Directory for outputs", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (stat_switch, "Display statistics", True, False))
		end

	Switch_prefixes: ARRAY [CHARACTER_8]
			-- <Precursor>
		once
			Result := << '-' >>
		end

feature {NONE} -- Switches

	density_switch: STRING = "d|density"
	input_file_switch: STRING = "i|input"
	stat_switch: STRING = "s|statistics"
	property_template_switch: STRING = "p|property_template"
	output_switch: STRING = "o|output_directory"
			-- Argument switches

end
