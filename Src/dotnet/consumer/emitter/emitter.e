indexing
	description	: "Emitter's root class"
	assembly_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (False) end,
		create {ASSEMBLY_COMPANY_ATTRIBUTE}.make ("Eiffel Software") end,
		create {ASSEMBLY_COPYRIGHT_ATTRIBUTE}.make ("Copyright Eiffel Software 1985-2003") end
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER

inherit
	ARGUMENT_PARSER
		rename
			make as parser_make
		end

	SHARED_XML_OUTPUT
		export
			{NONE} all
		end

	CACHE_PATH
		rename
			make as cache_path_make
		export
			{NONE} all
		end
		
	SAFE_ASSEMBLY_LOADER
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation procedure.
		do
			exec_from_cli := True
			parser_make (<<help_switch, help_spelled_switch, no_logo_switch, list_assemblies_switch, 
						list_assemblies_short, verbose_switch, verbose_short, add_switch, add_short,
						remove_switch, remove_short, compact_switch, nice_switch, nice_short, fullname_switch,
						fullname_short, out_switch, out_short, version_switch, version_short>>)
			parse
		
			if not successful then
				process_error (error_message)
			else
				if clr_version = Void then
						-- If it is Void, either an error was thrown, or we ask for
						-- usage information.
					clr_version := "v1.1.4322"
				end
				complete_initialization
				start
			end
		end
		
	complete_initialization is
			-- Completes initialization of instance given it current state
		require
			non_void_clr_version: clr_version /= Void
			valid_clr_version: not clr_version.is_empty and then clr_version.item (1).as_lower = 'v'
		do
			create cache_writer.make (clr_version)
			create cache_reader.make (clr_version)
			if verbose_output then
				cache_writer.set_status_printer (agent display_status)	
			end		
			cache_writer.set_error_printer (agent process_error)
		ensure
			non_void_cache_writer: cache_writer /= Void
		end

feature -- Access

	help_switch: STRING is "?"
			-- Switch used to display usage
	
	help_spelled_switch: STRING is "help"
			-- Switch used to display usage

	no_logo_switch: STRING is "nologo"
			-- Switch used to prevent copyright notice display

	list_assemblies_switch: STRING is "list"
			-- Switch used to list assemblies in EAC

	list_assemblies_short: STRING is "l"
			-- Shortcut equivalent of `list_assemblies_switch'

	verbose_switch: STRING is "verbose"
			-- Switch used to display all information.

	verbose_short: STRING is "v"
			-- Shortcut equivalent of `verbose_switch'

	add_switch: STRING is "add"
			-- Switch used to put assembly in EAC
	
	add_short: STRING is "a"
			-- Shortcut equivalent of `add_switch'

	remove_switch: STRING is "remove"
			-- Switch used to remove and assembly from EAC
	
	remove_short: STRING is "r"
			-- Shortcut equivalent of `remove_switch'
			
	compact_switch: STRING is "compact"
			-- Switch used to clean and compact EAC

	nice_switch: STRING is "nice"
			-- Switch used to create indented xml
			
	nice_short: STRING is "n"
			-- Shortcut equivalent of `nice_switch'
			
	fullname_switch: STRING is "fullname"
			-- Switch to indicate that assembly path is actually a display name
			
	fullname_short: STRING is "full"
			-- Shortcut equivaleent of `fullname_switch'
			
	out_switch: STRING is "out"
			-- Switch to specify alternative path to generate XML to.
			
	out_short: STRING is "o"
			-- Shortcut equivalent of `out_short'

	version_switch: STRING is "version"
			-- Switch to specify target CLR version.
			
	version_short: STRING is "ver"
			-- Shortcut equivalent of `version_switch'

feature -- Status report

	no_copyright_display: BOOLEAN
			-- Should copyright notice not be displayed?

	display_usage_help: BOOLEAN
			-- Should usage be displayed?

	list_assemblies: BOOLEAN
			-- Should EAC assemblies list be displayed?

	verbose_output: BOOLEAN
			-- Should consumption status output be displayed?

	add_to_eac: BOOLEAN
			-- Should assembly be put in EAC?
	
	remove_from_eac: BOOLEAN
			-- Should assembly be removed from EAC?
			
	path_is_full_name: BOOLEAN
			-- Is assembly path actually a display name?
			
	compact_cache: BOOLEAN
			-- Should EAC be compacted?
			
feature {NONE} -- Implementation

	start is
			-- Execute emitter according to options
		require
			non_void_clr_version: clr_version /= Void
		local
			l_assembly: ASSEMBLY
			l_resolver: ASSEMBLY_RESOLVER
		do
			if not no_copyright_display then
				display_copyright		
			end
			if list_assemblies then
				display_assemblies_list
			elseif display_usage_help then
				display_usage
			elseif not successful then
				display_error
			else
				if path_is_full_name then
					l_assembly := load_assembly_from_full_name (target_path)
				else
					l_assembly := load_assembly_from_path (target_path)
				end

				if l_assembly = Void then
					set_error (Invalid_assembly, target_path)
					display_error
				elseif successful then
					create l_resolver.make (feature {APP_DOMAIN}.current_domain)
					l_resolver.add_resolver_path_from_assembly (l_assembly)
					
					if add_to_eac then
						add_assembly_to_eac (l_assembly.location)						
					elseif remove_from_eac then
						remove_assembly_from_eac (l_assembly.location)
					end
					
					l_resolver.remove_from_app_domain
				else
					process_error (error_message)
				end
			end
			if successful and compact_cache then
				compact_and_clean_cache
			end
		end

	process_switch (switch, switch_value: STRING) is
			-- Process switch `switch' associated with value `switch_value'.
		do
			if switch.is_equal (help_switch) or switch.is_equal (help_spelled_switch) then
				display_usage_help := True
			elseif switch.is_equal (no_logo_switch) then
				no_copyright_display := True
			elseif switch.is_equal (list_assemblies_short) or switch.is_equal (list_assemblies_switch) then
				list_assemblies := True
			elseif switch.is_equal (verbose_short) or switch.is_equal (verbose_switch) then
				verbose_output := True
			elseif switch.is_equal (add_short) or switch.is_equal (add_switch) then
				add_to_eac := True
			elseif switch.is_equal (remove_short) or switch.is_equal (remove_switch) then
				remove_from_eac := True
			elseif switch.is_equal (compact_switch) then
				compact_cache := True
			elseif switch.is_equal (nice_short) or switch.is_equal (nice_switch) then
				has_indented_output.set_item (True)
			elseif switch.is_equal (fullname_short) or switch.is_equal (fullname_switch) then
				path_is_full_name := True
			elseif switch.is_equal (out_short) or switch.is_equal (out_switch) then
				set_internal_eiffel_cache_path (switch_value)
			elseif switch.is_equal (version_switch) or switch.is_equal (version_short) then
				clr_version := switch_value
			end
		end

	process_non_switch (non_switch_value: STRING) is
			-- process the args with no swtiches
		do
			target_path := non_switch_value
		end

	post_process is
			-- Post argument parsing processing.
		do
			if not (list_assemblies or display_usage_help) and target_path = Void then
				set_error (No_target, Void)
			elseif not display_usage_help and clr_version = Void then
				set_error (Version_should_be_specified, Void)
			elseif not (list_assemblies or display_usage_help) then
				if not add_to_eac or remove_from_eac or list_assemblies or compact_cache then
					set_error (no_operation, Void)
				elseif clr_version = Void or clr_version.is_empty or clr_version.item (1).as_lower /= 'v' then
					set_error (invalid_version_specified, clr_version)	
				end
			end
			
			if list_assemblies or display_usage_help then
				verbose_output := True
			end
		end

	display_copyright is
			-- Display copyright notice
		require
			exec_from_command_line: exec_from_cli
		do
			io.put_string ("%NEiffel Metadata Consumer Version ")
			io.put_string (Version)
			io.put_string ("%NCopyright (C) EiffelSoftware. All rights reserved.")
			io.put_string ("%N%N")
		end
		
	display_usage is
			-- Display tool usage
		require
			exec_from_command_line: exec_from_cli
		do
			io.put_string ("Usage:%N%N")
			io.put_string ("  " + System_name + " /a <assembly> [/full] /ver:<version> [/o:<path>] [/compact] [/n] [/v] [/nologo]%N")
			io.put_string ("  " + System_name + " /r <assembly> [/full] /ver:<version> [/o:<path>] [/compact] [/v] [/nologo]%N")
			io.put_string ("  " + System_name + " /l <assembly> [/full] /ver:<version> [/o:<path>] [/nologo]%N%N")
			io.put_string ("  " + System_name + " /compact /ver:<version> [/o:<path>] [/nologo]%N%N")
			io.put_string ("Options:%N%N")
			
			io.put_string ("  /a[dd] - Put assembly in Eiffel Assembly Cache.%N")
			io.put_string ("  /r[emove] - Remove assembly from Eiffel Assembly Cache.%N")
			io.put_string ("  /ver[sion]:<version> - Runtime version of the assembly being consumed.%N")
			io.put_string ("  /o[ut]:<path> - Alternative path for Eiffel assembly cache.%N")
			io.put_string ("  /full[name] - Indicates that <assembly> is a full or part display name.%N")
			io.put_string ("  /l[ist] - List assemblies in EAC.%N")
			io.put_string ("  /compact - Cleans and compacts cache.%N")
			io.put_string ("  /n[ice] - Writes indented XML for each assemblies consumed metadata.%N")
			io.put_string ("  /v[erbose] - Display all information when consuming an assembly.%N")
			io.put_string ("  /nologo - Prevent display of copyright notice.%N")
			io.put_string ("  /? - Display's this usage guide.%N%N")
			
			io.put_string ("Arguments:%N%N")
			io.put_string ("  <assembly> - Name or path for assembly to generate XML metadata for.%N")
			io.put_string ("  <path> - A path to an existing folder on disk or UNC path.%N%N")
		end
	
	display_status (s: STRING) is
			-- Display progress status.
		require
			exec_from_command_line: exec_from_cli
		do
			io.put_string (s)
			io.put_new_line
		end

	process_error (s: STRING) is
			-- Display error.
		require
			exec_from_command_line: exec_from_cli
		do
			io.put_string ("%N" + "** Error: " + s + "%N%N")
			io.put_string ("Type 'emitter /?' for usage information.%N%N")
		end

	add_assembly_to_eac (a_path: STRING) is
			-- Consume assembly `a_path' and put results in EAC
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_clr_version: clr_version /= Void
			non_void_cache_writer: cache_writer /= Void
		do
			if exec_from_cli then
				display_status ("Consuming '" + a_path + "' and all of it's dependencies.")
			end	
			cache_writer.add_assembly (a_path)
		rescue
			cache_writer.clean_cache
		end

	remove_assembly_from_eac (a_path: STRING) is
			-- Remove assembly `a_path' from EAC
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_clr_version: clr_version /= Void
			non_void_cache_writer: cache_writer /= Void
		do
			if exec_from_cli then
				display_status ("Removing '" + a_path + "' and all dependents.")	
			end		
			cache_writer.remove_recursive_assembly (a_path)
		rescue
			cache_writer.clean_cache
		end
		
	display_assemblies_list is
			-- Displays list of assemblies in EAC
		local
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_desc: STRING
			l_target_name: STRING
			l_assembly_desc: STRING
			l_file_info: FILE_INFO
			l_show: BOOLEAN
			l_show_count: INTEGER
			i: INTEGER
		do
			if target_path /= Void and then not target_path.is_empty then
				l_target_name := target_path.as_lower
			end			
			
			l_assemblies := cache_reader.consumed_assemblies
			if l_assemblies /= Void and then not l_assemblies.is_empty then
				display_status ("The Eiffel Assembly Cache contains the following entries")
				from
					i := 1
				until
					i > l_assemblies.count
				loop
					l_assembly_desc := l_assemblies.item (i).out
					
					if l_target_name /= Void then
						if path_is_full_name then
							l_show := l_target_name.is_equal (l_assembly_desc.substring (1, l_target_name.count.min (l_assembly_desc.count)).as_lower)
						else
							if l_target_name.index_of ((create {OPERATING_ENVIRONMENT}).directory_separator, 1) > 0 then
								l_show := l_assemblies.item (i).has_same_path (l_target_name)
							else
								create l_file_info.make (l_assemblies.item (i).location)
								l_show := l_target_name.is_equal (l_file_info.name.to_lower)
							end
						end
					else
						l_show := True
					end
					if l_show then
						create l_desc.make (l_assemblies.count.out.count + 6 + l_assembly_desc.count)
						l_desc.append ("   ")
						l_desc.append_integer (i)
						l_desc.append (create {STRING}.make_filled (' ', l_assemblies.count.out.count - i.out.count + 1))
						l_desc.append (": ")
						l_desc.append (l_assembly_desc)
						display_status (l_desc)
						l_show_count := l_show_count + 1
					end
					i := i + 1
				end
				display_status ("%NNumber of items = " + l_show_count.out)
			else
				display_status ("The Eiffel Assembly Cache is empty.")
			end
		end
		
	compact_and_clean_cache is
			-- compacts and cleans cache info
		do
			cache_writer.clean_cache
			cache_writer.compact_cache_info
		end
	
	target_path: STRING
			-- Path to target assembly
			
	System_name: STRING is 
			-- Name of executable
		local
			l_file_info: FILE_INFO
		once
			create l_file_info.make ((create {ARGUMENTS}).argument (0))
			Result := l_file_info.name
		ensure then
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	Version: STRING is "3.0"
		
	is_path_relative (a_path: STRING): BOOLEAN is
			-- is `a_path' a relative path?
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_head: STRING
		do
			Result := True
			if a_path.count > 2 then
				l_head := a_path.substring (1, 2)
				if l_head.is_equal ("\\") then
						-- network path
					Result := False
				end
			end
			if Result then
					-- local path or http path
				Result := a_path.index_of (':', 1) = 0
			end
		end
	
	cache_writer: CACHE_WRITER
			-- cache writer to manipulate contents of specified EAC.

	cache_reader: CACHE_REFLECTION
			-- Cache reflection to read contents of specified EAC
			
	exec_from_cli: BOOLEAN
			-- Is consumer being executed from a command line interface?
	
invariant
	non_void_cache_writer: cache_writer /= Void
	non_void_cache_reader: cache_reader /= Void
	
end -- class EMITTER
