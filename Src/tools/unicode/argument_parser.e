﻿note
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

	input_file: detachable READABLE_STRING_32
			-- Density of generated tables.
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (input_file_switch) as l_value then
				Result := l_value.value
			end
		end

	property_template: READABLE_STRING_32
			-- Name of template used to generate properties.
		do
			if attached {ARGUMENT_OPTION} option_of_name (property_template_switch) as l_value then
				Result := l_value.value
			else
				Result := {STRING_32} "character_property.template"
			end
		end

	output_path: READABLE_STRING_32
			-- Path where files will be generated. By default in current directory.
		do
			if attached {ARGUMENT_OPTION} option_of_name (output_switch) as l_value then
				Result := l_value.value
			else
				Result := {STRING_32} ""
			end
		end

	unicode_version: READABLE_STRING_32
			-- Version of Unicode data.
		require
			is_successful: is_successful
		once
			if attached option_of_name (unicode_version_switch) as o then
				Result := o.value
			else
				Result := {STRING_32} "Unknown"
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

feature -- Usage

	name: STRING = "Unicode Helper Generator"
			-- <Precursor>

	version: STRING = "1.3"
			-- <Precursor>

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 2012-2019. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (6)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (input_file_switch, "UnicodeData.txt file", False, False, "file", "Name of UnicodeData.txt file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (density_switch, "Density for tables", True, False, "density", "Density of table as a ratio", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (property_template_switch, "Template used for generation of character properties", True, False, "template", "Template file", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Directory where files will be generated", True, False, "dir", "Directory for outputs", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (stat_switch, "Display statistics", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (unicode_version_switch, "Version of Unicode data", False, False, "version", "Version string, e.g. %"6.2.0%"", False))
		end

	Switch_prefixes: ARRAY [CHARACTER_32]
			-- <Precursor>
		once
			Result := << {CHARACTER_32} '-' >>
		end

feature {NONE} -- Switches

	density_switch: STRING_32 = "d|density"
	input_file_switch: STRING_32 = "i|input"
	output_switch: STRING_32 = "o|output_directory"
	property_template_switch: STRING_32 = "p|property_template"
	stat_switch: STRING_32 = "s|statistics"
	unicode_version_switch: STRING_32 = "u|unicode_version"
			-- Argument switches

end
