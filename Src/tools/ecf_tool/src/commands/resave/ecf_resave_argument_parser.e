note
	description: "[
		Arguments for ECF_RESAVE objects
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_RESAVE_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			sub_system_name
		end

	APPLICATION_COMMAND_ARGUMENT_PARSER

	CONF_FILE_CONSTANTS

create
	make,
	make_with_source

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR})
		end

	make_with_source (src: ARGUMENT_SOURCE)
			-- Initialize argument parser
		do
			make
			set_argument_source (src)
		end

feature -- Access

	files: ITERABLE [READABLE_STRING_32]
			-- List of files to resave
		require
			is_successful: is_successful
		local
			l_result: ARRAYED_LIST [READABLE_STRING_32]
			f: PLAIN_TEXT_FILE
		once
			create l_result.make (values.count)
			across values as ic loop
				create f.make_with_name (ic.item)
				if f.exists and then f.is_access_readable and then not f.is_directory then
					l_result.force (ic.item)
				end
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

	directories: ITERABLE [READABLE_STRING_32]
			-- List of directories to locate ecfs in
		require
			is_successful: is_successful
		local
			l_result: ARRAYED_LIST [READABLE_STRING_32]
			d: DIRECTORY
		once
			create l_result.make (values.count)
			across values as ic loop
				create d.make_with_name (ic.item)
				if d.exists and then d.is_readable then
					l_result.force (ic.item)
				end
			end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

	use_directory_recusion: BOOLEAN
			-- Indicates if directories should be recursively scanned
		require
			is_successful: is_successful
		once
			Result := has_option (recursive_switch)
		end

	namespace: detachable STRING
		do
			if
				attached option_of_name (namespace_switch) as opt and then
				attached opt.value as v and then
				v.is_valid_as_string_8
			then
				Result := v.to_string_8
			elseif attached ecf_version as v then
				Result := versioned_namespace (v)
			end
		end

	schema: detachable STRING
		do
			if
				attached option_of_name (schema_switch) as opt and then
				attached opt.value as v and then
				v.is_valid_as_string_8
			then
				Result := v.to_string_8
			elseif attached ecf_version as v then
				Result := versioned_schema (v)
			end
		end

	versioned_schema (v: READABLE_STRING_8): STRING
		do
			create Result.make_from_string (schema_1_0_0)
			Result.replace_substring_all ("1-0-0", v)
		end

	versioned_namespace (v: READABLE_STRING_8): STRING
		do
			create Result.make_from_string (namespace_1_0_0)
			Result.replace_substring_all ("1-0-0", v)
		end

	ecf_version: detachable STRING
		do
			if
				attached option_of_name (ecf_version_switch) as opt and then
				attached opt.value as v and then
				v.is_valid_as_string_8
			then
				Result := v.to_string_8
			end
		end

	reset_uuid_requested: BOOLEAN
			-- Indicates if ecf UUID should be reset to new value.
		require
			is_successful: is_successful
		once
			Result := has_option (reset_uuid_switch)
		end

	is_quiet: BOOLEAN
			-- Should only errors be reported?
		require
			is_successful: is_successful
		once
			Result := has_option (quiet_switch)
		end

feature {NONE} -- Usage

	non_switched_argument_name: STRING = "path"
			--  <Precursor>

	non_switched_argument_description: STRING = "An Eiffel configuration file or a directory"
			--  <Precursor>

	non_switched_argument_type: STRING = "Eiffel configuration file/directory"
			--  <Precursor>

	name: STRING = "resave"
			--  <Precursor>

	sub_system_name: detachable IMMUTABLE_STRING_32
			-- Sub system name
			-- (from ARGUMENT_BASE_PARSER)
			-- (export status {NONE})
		do
			Result := name
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Recursive scan any directories for *.ecf", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (namespace_switch, "Eiffel Configuration File namespace", True, False, "namespace", "URL of the namespace", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (schema_switch, "Eiffel Configuration File schema", True, False, "schema", "URL of the schema", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (ecf_version_switch, "Eiffel Configuration File schema version (schema and namespace will be set from this version)", True, False, "version", "ECF schema version (formatted like [0-9]-[0-9][0-9]*-[0-9])", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (reset_uuid_switch, "Reset UUID for *.ecf", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (quiet_switch, "Suppress output except for errors", True, False))
		end

	recursive_switch: STRING = "r|recursive"

	schema_switch: STRING = "schema"

	namespace_switch: STRING = "namespace"

	ecf_version_switch: STRING = "ecf_version"

	reset_uuid_switch: STRING = "reset_uuid"

	quiet_switch: STRING = "quiet"

;note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
