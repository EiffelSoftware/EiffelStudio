note
	description: "[
			Summary description for {IRON_ARGUMENTS_PARSER}.
			
			
				iron list 						: List of available packages, i.e. packages that have been installed
												: as well as packages available from the Iron server.
				iron list --installed 			: List of installed packages.
				iron install package_name 		: Install a package.
				iron install -f package_file 	: Install a package from a file.
				iron remove package_name 		: Remove a package.
				iron search package_name 		: Search for a package.
				iron info package_name 			: Information about a package.

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INFO_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			switch_groups,
			sub_system_name
		end

	IRON_ARGUMENTS

create
	make,
	make_with_source

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_is_using_separated_switch_values (False)
--			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	make_with_source (src: ARGUMENT_SOURCE)
			-- Initialize argument parser
		do
			make
			set_argument_source (src)
		end

	sub_system_name: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string ({IRON_INFO_TASK}.name)
		end

feature -- Access

	copyright: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ("Copyright Eiffel Software 2011-2013. All Rights Reserved.")
		end

--	output_ecf: PATH
--		once
--			if has_option (output_switch) and then attached option_of_name (output_switch) as o and then o.has_value then
--				create Result.make_from_string (o.value)
--			else
--				Result := current_working_path.extended ("integration_all.ecf") -- Current working directory
--			end
--			if not Result.is_absolute then
--				Result := Result.absolute_path
--			end
--		end

--	directories: LIST [PATH]
--			-- List of directories to locate ecfs in
--		local
--			l_options: like values
--			d: DIRECTORY
--		once
--			l_options := values.twin
--			from l_options.start until l_options.after loop
--				create d.make (l_options.item)
--				if d.exists and then d.is_readable then
--					l_options.forth
--				else
--					l_options.remove
--				end
--			end
--			create {ARRAYED_LIST [PATH]} Result.make (l_options.count)
--			l_options.do_all (agent (s: IMMUTABLE_STRING_32; res: LIST [PATH])
--					do
--						res.force (create {PATH}.make_from_string (s))
--					end (?, Result))
--		end

--	excluded_directories: detachable LIST [PATH]
--			-- List of excluded directories
--		local
--			p: PATH
--		once
--			if
--				has_option (excluded_directory_switch) and then
--				attached options_of_name (excluded_directory_switch) as opts and then not opts.is_empty
--			then
--				create {ARRAYED_LIST [PATH]} Result.make (opts.count)
--				across
--					opts as c
--				loop
--					if c.item.has_value then
--						create p.make_from_string (c.item.value)
--						if not p.is_absolute then
--							p := exec_env.current_working_path.extended_path (p)
--						end
--						Result.force (p)
--					end
--				end
--			end
--		end

--	execution_forced: BOOLEAN
--		once
--			Result := has_option (force_switch)
--		end

	verbose: BOOLEAN
		once
			Result := has_option (verbose_switch)
		end

--	root_directory: PATH
--		once
--			if has_option (root_switch) and then attached option_of_name (root_switch) as o and then o.has_value then
--				create Result.make_from_string (o.value)
--			else
--				Result := current_working_path -- Current working directory
--			end
--		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "path")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "folder to look Eiffel configuration files")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "folder")
		end

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name)
		end

	version: IMMUTABLE_STRING_32
			--  <Precursor>
		local
			s: STRING_32
		once
			create s.make (5)
			s.append_natural_16 ({IRON_CONSTANTS}.major_version)
			s.append_character ('.')
			s.append_natural_16 ({IRON_CONSTANTS}.minor_version)
			create Result.make_from_string (s)
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)
--			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (root_switch, "Root directory", True, False, "folder", "Root directory", False))
--			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (output_switch, "Output config file", False, False, "ecf_file", "output config file", False))
--			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Force execution without any confirmation", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output", True, False))
--			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (excluded_directory_switch, "Excluded directories", True, True, "path", "directory", False))

		end

	switch_groups: attached ARRAYED_LIST [attached ARGUMENT_GROUP]
			-- Valid switch grouping
		once
			create Result.make (3)
--			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (x86_switch), switch_of_name (use_compiler_switch), switch_of_name (aync_switch), switch_of_name (ignore_switch)>>, True))
--			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (manual_switch), switch_of_name (aync_switch), switch_of_name (ignore_switch)>>, True))
--			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (list_compilers_switch), switch_of_name (x86_switch)>>, False))
		end


--				iron list 						: List of available packages, i.e. packages that have been installed
--												: as well as packages available from the Iron server.
--				iron list --installed 			: List of installed packages.
--				iron install package_name 		: Install a package.
--				iron install -f package_file 	: Install a package from a file.
--				iron remove package_name 		: Remove a package.
--				iron search package_name 		: Search for a package.
--				iron info package_name 			: Information about a package.
--				
--	list_switch

--	root_switch: STRING = "r|root"
--	force_switch: STRING = "f|force"
	verbose_switch: STRING = "v|verbose"
--	excluded_directory_switch: STRING = "x|exclude"
--	output_switch: STRING = "o|output"

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"rt.eiffel.com
		]"

end
