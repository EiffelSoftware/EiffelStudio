note
	description: "[
			Arguments for the {LIBRARY_INDEXER_APPLICATION}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	LIBRARY_INDEXER_ARGUMENTS

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			is_using_unix_switch_style,
			switch_prefixes
		end

	SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR})
		end

feature -- Access

	copyright: STRING = "Copyright Eiffel Software 2011-2013"
			-- Copyright information.
			-- Not used if empty.

feature {NONE} -- Status report		

	is_using_unix_switch_style: BOOLEAN = True
			-- <Precursor>
			--| Avoid using /flag ...

	switch_prefixes: ARRAY [CHARACTER_32]
			-- Prefixes used to indicate a command line switch.
		once
			Result := <<'-'>>
		end

feature -- Access

	files: ARRAYED_LIST [PATH]
			-- List of files to resave
		require
			is_successful: is_successful
		local
			l_options: like values
			p: PATH
		once
			l_options := values
			create Result.make (l_options.count)
			across
				l_options as ic
			loop
				create p.make_from_string (ic.item)
				if file_system.is_file_readable (p) then
					Result.force (p)
				end
			end
		ensure
			result_attached: Result /= Void
			reuslt_contains_attached_items: not Result.has (Void)
		end

	directories: ARRAYED_LIST [PATH]
			-- List of directories to locate ecfs in
		require
			is_successful: is_successful
		local
			l_options: like values
			p: PATH
		once
			l_options := values
			create Result.make (l_options.count)
			across
				l_options as ic
			loop
				create p.make_from_string (ic.item)
				if file_system.is_directory_readable (p) then
					Result.force (p)
				end
			end
		ensure
			result_attached: Result /= Void
			reuslt_contains_attached_items: not Result.has (Void)
		end

	is_verbose: BOOLEAN
			-- Verbose output ?
		require
			is_successful: is_successful
		once
			Result := has_option (verbose_switch)
		end

	use_directory_recursion: BOOLEAN
			-- Indicates if directories should be recursively scanned
		require
			is_successful: is_successful
		once
			Result := has_option (recursive_switch) or else	recursion_limit = 0 --| By default it is recursive
		end

	recursion_limit: INTEGER
			-- Limit recursion to `Result' depth
		once
			if
				attached option_of_name (limit_switch) as opt and then
				attached opt.value as s and then
				s.is_integer
			then
				Result := s.to_integer
			end
		end

	searching_term: detachable READABLE_STRING_32
			-- Term to search in database.
		once
			if
				attached option_of_name (search_switch) as opt
			then
				Result := opt.value
			end
		end

	reset_requested: BOOLEAN
		once
			Result := has_option (reset_switch)
		end

	update_requested: BOOLEAN
		once
			Result := has_option (update_switch)
		end

feature {NONE} -- Usage

	non_switched_argument_name: STRING = "path"
			--  <Precursor>

	non_switched_argument_description: STRING = "An Eiffel configuration file or a directory"
			--  <Precursor>

	non_switched_argument_type: STRING = "Eiffel configuration file/directory"
			--  <Precursor>

	name: STRING = "library_analyzer"
			--  <Precursor>

	version: attached STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_natural_16 ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_natural_16 ({EIFFEL_CONSTANTS}.minor_version)
		end

feature {NONE} -- Switches

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (10)
			Result.extend (create {ARGUMENT_SWITCH}.make (reset_switch, "Reset any saved index", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (update_switch, "Update database with new library if any", True, False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (search_switch, "Search library including class_name", True, False, "class_name", "A class name", False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (platform_switch, "Platform", True, False, platform_switch, "Platform", True))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (concurrency_switch, "Concurrency", True, False, concurrency_switch, "Concurrency", True))

			Result.extend (create {ARGUMENT_SWITCH}.make (il_generation_switch, "Is Dotnet?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (dynamic_runtime_switch, "Dynamic runtime?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Recursive scan any directories for *.ecf (default=True)", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (limit_switch, "Limit depth when scanning directories for *.ecf", True, False, "depth", "Depth in folder (default=1)", True))
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output?", True, False))
		end


	reset_switch: STRING = "z|reset"
	update_switch: STRING = "u|update"

	search_switch: STRING = "s|search"

	platform_switch: STRING = "platform"

	concurrency_switch: STRING = "concurrency"

	il_generation_switch: STRING = "dotnet"

	dynamic_runtime_switch: STRING = "dynamic_runtime"

	recursive_switch: STRING = "r|recursive"
	limit_switch: STRING = "limit"

	verbose_switch: STRING = "v|verbose"

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
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
