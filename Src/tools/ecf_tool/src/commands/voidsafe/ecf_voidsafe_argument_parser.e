note
	description: "[
		Arguments for ECF_VOIDSAFE objects
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ECF_VOIDSAFE_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			sub_system_name
		end

	APPLICATION_COMMAND_ARGUMENT_PARSER

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
			-- List of files to process.
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
			-- List of directories to locate ecfs in.
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
			-- Indicates if directories should be recursively scanned.
		require
			is_successful: is_successful
		once
			Result := has_option (recursive_switch)
		end

	is_quiet: BOOLEAN
			-- Is quiet mode enabled?
		require
			is_successful: is_successful
		once
			Result := has_option (quiet_switch)
		end

	is_simulation: BOOLEAN
			-- Is this a simulation?
			-- i.e: no file updated for real.
		require
			is_successful: is_successful
		once
			Result := has_option (simulation_switch)
		end

	is_updating_to_voidsafe_all: BOOLEAN
			-- Indicates if .ecf are updated directly to void-safety.
		require
			is_successful: is_successful
		once
			Result := has_option (set_voidsafe_all_switch)
		end

	is_updating_to_voidsafe_none: BOOLEAN
			-- Indicates if .ecf are updated directly to none void-safety.
		require
			is_successful: is_successful
		once
			Result := has_option (set_voidsafe_none_switch)
		end

	is_generating_both_voidsafe_files: BOOLEAN
			-- Indicates if tool generate associated -safe.ecf or .ecf | -unsafe.ecf files.
			-- This is enabled by default.
		require
			is_successful: is_successful
		once
			Result := has_option (set_voidsafe_both_switch) or not (is_updating_to_voidsafe_all or is_updating_to_voidsafe_none)
		end

feature {NONE} -- Usage

	non_switched_argument_name: STRING = "path"
			--  <Precursor>

	non_switched_argument_description: STRING = "An Eiffel configuration file or a directory"
			--  <Precursor>

	non_switched_argument_type: STRING = "Eiffel configuration file/directory"
			--  <Precursor>

	name: STRING = "voidsafe"
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
			create Result.make (6)
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Recursive scan any directories for *.ecf", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (quiet_switch, "Quiet mode", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (simulation_switch, "Simulation mode (no file updated or created)", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (set_voidsafe_both_switch, "Generate associated void-safe or void-unsafe .ecf file (using -safe.ecf and .ecf or -unsafe.ecf convention).", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (set_voidsafe_all_switch, "Update *.ecf file to void-safety", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (set_voidsafe_none_switch, "Update *.ecf file to void-unsafety (i.e not void-safe)", True, False))
		end


	recursive_switch: STRING = "r|recursive"
	quiet_switch: STRING = "q|quiet"
	simulation_switch: STRING = "i|simulation"

	set_voidsafe_all_switch: STRING = "to-all"
	set_voidsafe_none_switch: STRING = "to-none"
	set_voidsafe_both_switch: STRING = "both"

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
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
