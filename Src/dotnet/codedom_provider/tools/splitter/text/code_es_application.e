indexing
	description: "Command line splitter utility."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_APPLICATION

inherit
	EV_THREAD_SEVERITY_CONSTANTS
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Process arguments and execute corresponding
			-- actions.
		local
			l_cls: COMMAND_LINE_SYNTAX
			l_clp: COMMAND_LINE_PARSER
			l_args: ARGUMENTS
		do
			create l_cls.make (option_specifications)
			create l_clp.make (l_cls)
			create l_args
			l_clp.parse (l_args.argument_array)
			exe_name := l_clp.executable_without_suffix
			if l_clp.valid_options.has ("-v") then
				print_version_info
			elseif l_clp.valid_options.has ("-h") then
				print (l_cls.program_help (exe_name, Void, Void))
			elseif not l_clp.invalid_options_found then
				if l_clp.valid_options.has ("-m") then
					regular_expression := l_clp.valid_options.item ("-m").first
				else
					regular_expression := ".*\.es"
				end
				folder := l_clp.valid_options.item ("-f").first
				process_subfolders := l_clp.valid_options.has ("-s")
				no_logo := l_clp.valid_options.has ("-n")
				if l_clp.valid_options.has ("-d") then
					destination_folder := l_clp.valid_options.item ("-d").first
				end
				split_files
			else
				print (l_clp.error_message)
				print (l_cls.program_usage (exe_name) + "%N")
				print ("Use -h/--help for more help." + "%N")
			end
		end		

feature -- Access

	folder: STRING
			-- Folder containing Eiffel multi-class files
		
	regular_expression: STRING
			-- Regular expression that file name must match to be processed
	
	process_subfolders: BOOLEAN
			-- Should subfolders be processed?
	
	no_logo: BOOLEAN
			-- Do not display copyright notice if true
	
	destination_folder: STRING
			-- Folder where Eiffel source files should be created

feature {NONE} -- Implementation

	split_files is
			-- Split multi-class Eiffel files into Eiffel source files according to settings.
		require
			non_void_folder: folder /= Void
			non_void_regular_expression: regular_expression /= Void
		local
			l_splitter: CODE_ES_SPLITTER
		do
			if not no_logo then
				print_version_info
			end
			create l_splitter.make (folder, regular_expression, destination_folder, process_subfolders)
			l_splitter.split_files (agent display_event)
		end

	display_event (a_event: CODE_ES_EVENT) is
			-- Display event on console.
		require
			non_void_event: a_event /= Void
		do
			inspect
				a_event.severity
			when Information then
				print (a_event.message)
				print ("%N")
			when Warning then
				print ("Warning: ")
				print (a_event.message)
				print ("%N")
			when Error then
				print ("%NERROR: ")
				print (a_event.message)
				print ("%N%N")
			else
				check
					should_not_be_here: False
				end
			end
		end

	print_version_info is
			-- Print version information.
		do
			print ("eSplitter v1.0.1402%NCopyright(c) Eiffel Software, All rights reserved.%N%N")
		end

	option_specifications: ARRAY [STRING] is
			-- The recognized options of this program
		once
			Result := <<"-v,--version#Version information.",
				"-h,--help#Help on using this program.",
				"-f,--folder!=FOLDER!#Folder containing Eiffel multi-class files.",
				"-m,--match=REGEXP!#Regular expression that file name must match to be processed, by default matches all files with extension '.es'.",
				"-s,--subfolders#Also process files in subfolders.",
				"-d,--destination=DESTINATION!#Folder where generated Eiffel class files should be created.%
												% If not specified, creates Eiffel class files in same folder%
												% as corresponding Eiffel multi-class file.",
				"-n,--nologo#Do not display copyright notice.">>
		end

	file_names: LIST [STRING]
			-- Names of the files to operate on

	exe_name: STRING;
			-- Name of this executable

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_ES_APPLICATION

--+--------------------------------------------------------------------
--| eSplit
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------