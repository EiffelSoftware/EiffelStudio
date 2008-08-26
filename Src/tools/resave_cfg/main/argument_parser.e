indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR})
		end

feature -- Access

	files: DS_BILINEAR [STRING] is
			-- List of files to resave
		require
			is_successful: is_successful
		local
			l_options: like values
			l_result: DS_ARRAYED_LIST [!STRING]
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				if not file_system.is_file_readable (l_options.item) then
					l_options.remove
				else
					l_options.forth
				end
			end
			create l_result.make (l_options.count)
			l_options.do_all (agent l_result.force_last)
			Result := l_result
		ensure
			result_attached: Result /= Void
			reuslt_contains_attached_items: not Result.has (Void)
		end

	directories: DS_BILINEAR [STRING] is
			-- List of directories to locate ecfs in
		require
			is_successful: is_successful
		local
			l_options: like values
			l_result: DS_ARRAYED_LIST [!STRING]
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				if not file_system.is_directory_readable (l_options.item) then
					l_options.remove
				else
					l_options.forth
				end
			end
			create l_result.make (l_options.count)
			l_options.do_all (agent l_result.force_last)
			Result := l_result
		ensure
			result_attached: Result /= Void
			reuslt_contains_attached_items: not Result.has (Void)
		end

	use_directory_recusion: BOOLEAN is
			-- Indicates if directories should be recursively scanned
		require
			is_successful: is_successful
		once
			Result := has_option (recursive_switch)
		end

feature {NONE} -- Usage

	non_switched_argument_name: !STRING = "path"
			--  <Precursor>

	non_switched_argument_description: !STRING = "An Eiffel configuration file or a directory"
			--  <Precursor>

	non_switched_argument_type: !STRING = "Eiffel configuration file/directory"
			--  <Precursor>

	name: !STRING = "savecfg"
			--  <Precursor>

	version: !STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_natural_16 ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_natural_16 ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
		end

feature {NONE} -- Switches

	switches: !ARRAYED_LIST [!ARGUMENT_SWITCH] is
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_SWITCH}.make (recursive_switch, "Recursive scan any directories for *.ecf", True, False))
		end

	recursive_switch: STRING = "r"

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
