indexing 
	description: "Precompiler: takes care of precompiling ace files and maintains%
						%precompiled libraries cache."
	date: "$$"
	revision: "$$"

class
	CODE_PRECOMPILER

inherit
	CODE_DOM_PATH
		export
			{NONE} all
		end

	CODE_PRECOMPILER_REGISTRY_SETTINGS
		export
			{NONE} all
		end

	CODE_CONFIGURATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_ace_file_name, a_directory: STRING) is
			-- Initialize instance.
		require
			non_void_ace_file_name: a_ace_file_name /= Void
			non_void_directory: a_directory /= Void
			valid_ace_file_name: not a_ace_file_name.is_empty
			valid_directory: not a_directory.is_empty
		local
			l_interp: CODE_ENV_INTERP
		do
			create l_interp
			ace_file_name := l_interp.interpreted_string (a_ace_file_name)
			root_directory := l_interp.interpreted_string (a_directory)
			if a_directory.item (a_directory.count) = Directory_separator then
				root_directory.keep_head (root_directory.count - 1)
			end
		ensure
			ace_file_name_set: ace_file_name.is_equal ((create {ENV_INTERP}).interpreted_string (a_ace_file_name))
			root_directory_set: root_directory /= Void
		end

feature -- Access

	ace_file_name: STRING
			-- Ace file name (including path)
	
	root_directory: STRING
			-- Directory which includes sub-directory where to perform precompilation

	successful: BOOLEAN
			-- Was last call to `precompile' successful?
	
	precompile_path: STRING
			-- Path to last precompile

	precompile_assembly: ASSEMBLY
			-- Assembly corresponding to precompile dll

	precompile_files: LIST [STRING]
			-- List of generated dlls filenames (including path)

feature -- Basic Operations

	precompile is
			-- Try precompiling or recover cached precompile
			-- Set `successful' and `precompile_path'.
		local
			l_dir_file, l_ace_file: RAW_FILE
			l_rel_dir, l_abs_dir, l_compiler_path, l_file, l_dll: STRING
			l_index, l_index_2, l_counter: INTEGER
			l_exists, l_retried: BOOLEAN
			l_start_info: SYSTEM_DLL_PROCESS_START_INFO
			l_process: SYSTEM_DLL_PROCESS
			l_fcode_dir: DIRECTORY
			l_res: SYSTEM_OBJECT
			l_files, l_dlls: LIST [STRING]
		do
			if not l_retried then
				successful := False
				precompile_path := Void
				precompile_files := Void
				create l_ace_file.make (ace_file_name)
				if l_ace_file.exists then
					l_rel_dir := directory (ace_file_name)
					if l_rel_dir /= Void then
						create l_abs_dir.make (root_directory.count + 1 + l_rel_dir.count)
						l_abs_dir.append (root_directory)
						l_abs_dir.append (Directory_separator.out)
						l_abs_dir.append (l_rel_dir)
						if {SYSTEM_DIRECTORY}.exists (l_abs_dir) then
							create l_dir_file.make (l_abs_dir)
							if l_ace_file.change_date > l_dir_file.change_date then
								-- Cache is obsolete
								safe_directory_delete (l_abs_dir)
								remove_precompile (ace_file_name)
							else
								precompile_path := l_abs_dir
								successful := True
							end
						end
					end
					if not successful then

						-- Extract ace file name for directory name
						l_index := ace_file_name.last_index_of ('.', ace_file_name.count)
						l_index_2 := ace_file_name.last_index_of (Directory_separator, ace_file_name.count)
						if l_index_2 = 0 then
							if l_index = 0 then
								l_rel_dir := ace_file_name
							else
								l_rel_dir := ace_file_name.substring (1, l_index - 1)
							end
						else
							if l_index > l_index_2 + 1 then
								l_rel_dir := ace_file_name.substring (l_index_2 + 1, l_index - 1)
							elseif l_index = l_index_2 + 1 then -- weird, the path has "\." in it
								l_rel_dir := "precomp"
							else
								check
									valid_file_name: l_index_2 < ace_file_name.count
								end
								l_rel_dir := ace_file_name.substring (l_index_2 + 1, ace_file_name.count)
							end
						end
						check
							non_void_rel_dir: l_rel_dir /= Void
							valid_rel_dir: not l_rel_dir.is_empty
						end
						create l_abs_dir.make (root_directory.count + 1 + l_rel_dir.count)
						create l_abs_dir.make (root_directory.count + 1 + l_rel_dir.count)
						l_abs_dir.append (root_directory)
						l_abs_dir.append (Directory_separator.out)
						l_abs_dir.append (l_rel_dir)
						from
							l_exists := {SYSTEM_DIRECTORY}.exists (l_abs_dir)
							if l_exists then
								l_abs_dir.append ("_2")
								l_exists := {SYSTEM_DIRECTORY}.exists (l_abs_dir)
								l_counter := 2
							end
						until
							not l_exists
						loop
							l_counter := l_counter + 1
							l_abs_dir.keep_head (l_abs_dir.last_index_of ('_', l_abs_dir.count))
							l_abs_dir.append (l_counter.out)
							l_exists := {SYSTEM_DIRECTORY}.exists (l_abs_dir)
						end
						l_res := {SYSTEM_DIRECTORY}.create_directory (l_abs_dir)
						
						-- Now precompile in directory `l_abs_dir'
						l_compiler_path := Compiler_path
						if l_compiler_path = Void then
							Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_compiler_path, [])
						else
							create l_start_info.make_from_file_name_and_arguments (l_compiler_path + Directory_separator.out + Compiler_file_name, "-batch -precompile -finalize -c_compile -metadata_cache_path %"" + compiler_metadata_cache + "%" -ace %"" + ace_file_name + "%"")
							l_start_info.set_working_directory (l_abs_dir)
							l_start_info.set_create_no_window (True)
							l_start_info.set_redirect_standard_error (False)
							l_start_info.set_redirect_standard_output (False)
							l_start_info.set_use_shell_execute (False)
							create l_process.make
							l_process.set_start_info (l_start_info)
							if l_process.start then
								l_process.wait_for_exit
							end
						end
					end
					-- Check if precompile was successful
					create l_fcode_dir.make (l_abs_dir + "\EIFGEN\F_Code")
					if l_fcode_dir.exists then
						l_files := l_fcode_dir.linear_representation
						from
							l_files.start
							create {ARRAYED_LIST [STRING]} l_dlls.make (2)
						until
							l_files.after
						loop
							l_file := l_files.item
							if l_file.count > 3 and then (l_file.substring_index (".dll", l_file.count - 3) = l_file.count - 3) then
								create l_dll.make (l_abs_dir.count + 15 + l_file.count)
								l_dll.append (l_abs_dir)
								l_dll.append ("\EIFGEN\F_Code\")
								l_dll.append (l_file)
								l_dlls.extend (l_dll)
							end
							l_files.forth
						end
						-- Now load assembly, there is probably a lib dll as well
						-- so we try loading the dlls until we find one that really loads
						from
							l_dlls.start
							precompile_assembly := Void
						until
							l_dlls.after or precompile_assembly /= Void
						loop
							safe_assembly_load (l_dlls.item)
							l_dlls.forth
						end
						precompile_files := l_dlls
					end
					successful := precompile_assembly /= Void
					if successful then
						precompile_path := l_abs_dir

						-- Save precompile directory / ace file name association
						if l_counter > 0 then
							l_rel_dir.append_character ('_')
							l_rel_dir.append (l_counter.out)
						end
						if has_directory (ace_file_name) then
							change_precompile_directory (ace_file_name, l_rel_dir)
						else
							add_precompile (ace_file_name, l_rel_dir)
						end
					else
						-- Clean up
						safe_directory_delete (l_abs_dir)
					end
				end
			end
		rescue
			l_retried := True
			successful := False
			precompile_path := Void
			retry
		end

feature {NONE} -- Implementation

	safe_directory_delete (a_dir: STRING) is
			-- Delete directory `a_dir'.
			-- Do not throw exception on error.
		require
			non_void_directory: a_dir /= Void
		local
			l_retried: BOOLEAN
			l_dir: DIRECTORY
		do
			if not l_retried then
				create l_dir.make (a_dir)
				if l_dir.exists then
					l_dir.recursive_delete
				end
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	safe_assembly_load (a_path: STRING) is
			-- Try loading assembly located at `a_path' into `precompile_assembly'.
			-- Do nothing if `a_path' does not represent a path to an assembly.
		require
			non_void_path: a_path /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				precompile_assembly := {ASSEMBLY}.load_from (a_path)
			end
		rescue
			precompile_assembly := Void
			l_retried := True
			retry
		end

invariant
	non_void_ace_file_name: ace_file_name /= Void
	valid_ace_file_name: not ace_file_name.is_empty
	non_void_root_directory: root_directory /= Void
	valid_root_directory: not root_directory.is_empty and then root_directory.item (root_directory.count) /= Directory_separator
	non_void_precompile_path_iff_successful: successful = (precompile_path /= Void)
	non_void_precompile_files_iff_successful: successful = (precompile_files /= Void)

end -- class CODE_PRECOMPILER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------