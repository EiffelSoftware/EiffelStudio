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

	filter_file: detachable READABLE_STRING_32
			-- Name of the filter file (if any) to select entries from the input file.
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (filter_switch) as o then
				Result := o.value
			end
		end

	group_file: detachable READABLE_STRING_32
			-- Name of the group file (if any) to annotate entries from the input file.
		require
			is_successful: is_successful
		once
			if attached {ARGUMENT_OPTION} option_of_name (group_switch) as o then
				Result := o.value
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

	categories: like options_values_of_name
			-- Specified categories.
		do
			Result := options_values_of_name (category_switch)
		end

feature -- Status report

	has_statistic: BOOLEAN
			-- Is generation of statistics requested?
		require
			is_successful: is_successful
		once
			Result := has_option (stat_switch)
		end

	has_range: BOOLEAN
			-- Is range output requested?
		require
			is_successful: is_successful
		once
			Result := has_option (range_switch)
		end

	is_negated: BOOLEAN
			-- Is filter negated (i.e. take only entries not in the filter into account)?
		require
			is_successful: is_successful
		once
			Result := has_option (negate_switch)
		end

feature -- Usage

	name: STRING = "Unicode Helper Generator"
			-- <Precursor>

	version: STRING = "1.5"
			-- <Precursor>

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 2012-2022. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (11)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (category_switch, "Categories to select", True, True, "category", "2-letter general category value", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (density_switch, "Density for tables", True, False, "density", "Density of table as a ratio", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (filter_switch, "Filter to select entries from UnicodeData.txt", True, False, "filter", "Filter file in standard Unicode UCD format with entries to keep", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (group_switch, "Groups to annotate entries from UnicodeData.txt", True, False, "filter", "Group file in standard Unicode UCD format with group names", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (input_file_switch, "UnicodeData.txt file", True, False, "file", "Name of UnicodeData.txt file", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (negate_switch, "Negate filter (i.e. output entries not in the filter)", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Directory where files will be generated", True, False, "dir", "Directory for outputs", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (property_template_switch, "Template used for generation of character properties", True, False, "template", "Template file", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (range_switch, "Output ranges of specified categories instead of generating character properties", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (stat_switch, "Display statistics", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (unicode_version_switch, "Version of Unicode data", False, False, "version", "Version string, e.g. %"6.2.0%"", False))
		end

	Switch_prefixes: ARRAY [CHARACTER_32]
			-- <Precursor>
		once
			Result := << {CHARACTER_32} '-' >>
		end

feature {NONE} -- Switches

	category_switch: STRING_32 = "c|category"
	density_switch: STRING_32 = "d|density"
	filter_switch: STRING_32 = "f|filter"
	group_switch: STRING_32 = "g|group"
	input_file_switch: STRING_32 = "i|input"
	negate_switch: STRING_32 = "n|negate"
	output_switch: STRING_32 = "o|output_directory"
	property_template_switch: STRING_32 = "p|property_template"
	range_switch: STRING_32 = "r|range"
	stat_switch: STRING_32 = "s|statistics"
	unicode_version_switch: STRING_32 = "u|unicode_version"
			-- Argument switches

end
