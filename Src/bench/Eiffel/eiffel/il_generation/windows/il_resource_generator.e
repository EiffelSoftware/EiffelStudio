indexing
	description: "To compile non-compiled resources and add them in a specific IL module."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_RESOURCE_GENERATOR

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
		end
		
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end
		
	COMPILER_EXPORTER
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_module: like module; a_resources: like resources) is
			-- Initialize current instance with `a_module' where `a_resources' will
			-- be generated into.
		require
			a_module_not_void: a_module /= Void
			a_resources_not_void: a_resources /= Void
		do
			module := a_module
			resources := a_resources
		ensure
			module_set: module = a_module
			resources_set: resources = a_resources
		end

feature -- Generation

	generate is
			-- Generate `resources' in `module'. Compile `resources' items if necessary.
		local
			l_resources: ARRAYED_LIST [STRING]
			l_name: STRING
			l_new_name: STRING
			nb: INTEGER
			l_not_is_resource_generated: BOOLEAN
		do
			from
				create l_resources.make (resources.count)
				resources.start
			until
				resources.after
			loop
				l_name := resources.item
				nb := l_name.count
				l_not_is_resource_generated :=
					((nb > 5) and l_name.substring (nb - 4, nb).as_lower.is_equal (".resx")) or
					((nb > 4) and l_name.substring (nb - 3, nb).as_lower.is_equal (".txt"))
				if l_not_is_resource_generated then
					l_new_name := new_compiled_resource_file_name (l_name)
					generate_resource (l_name, l_new_name)
					l_resources.extend (l_new_name)
				else
					l_resources.extend (l_name)
				end
				resources.forth
			end
			
			from
				l_resources.start
			until
				l_resources.after
			loop
				l_name := l_resources.item
				define_resource (module, l_name, resource_name (l_name))
				l_resources.forth
			end
		end

feature -- Access

	module: IL_MODULE
			-- PE file in which `resources' will be generated.
			
	resources: LIST [STRING]
			-- List of resources.

feature {NONE} -- Implementation

	generate_resource (a_resource, a_target: STRING) is
			-- Generate a compiled resource in `a_target' using `a_resource' as resource file.
		require
			a_resource_not_void: a_resource /= Void
			a_target_not_void: a_target /= Void
		local
			l_env: IL_ENVIRONMENT
			l_rc: STRING
			l_cmd: STRING
			l_launch: WEL_PROCESS_LAUNCHER
			l_exec: EXECUTION_ENVIRONMENT
			l_virc: VIRC
		do
			create l_env.make (System.clr_runtime_version)
			l_rc := l_env.resource_compiler			
			
			if l_rc /= Void and then (create {RAW_FILE}.make (l_rc)).exists then
				if not (create {RAW_FILE}.make (a_resource)).exists then
					create l_virc.make_resource_file_not_found (a_resource)
				else
					create l_launch
					create l_exec
					l_cmd := l_rc + " %"" + a_resource + "%" %"" + a_target + "%""
					l_launch.launch (l_cmd, l_exec.current_working_directory, Void)
					if l_launch.last_process_result /= 0 then
						create l_virc.make_failed (a_resource)
					end
				end
			else
				create l_virc.make_rc_not_found (l_rc)
			end
			
			if l_virc /= Void then
				Error_handler.insert_warning (l_virc)
			end
		end

	resource_name (a_resource: STRING): STRING is
			-- Extract name of `a_resource' file without its extension.
		require
			a_resource_not_void: a_resource /= Void
		local
			dir_pos, dot_pos, nb: INTEGER
		do
			nb := a_resource.count
			dir_pos := a_resource.last_index_of ('\', nb) + 1
			if dir_pos = 0 then
				dir_pos := a_resource.last_index_of ('/', nb) + 1
			end
			
			dot_pos := a_resource.last_index_of ('.', nb)
			if dot_pos = 0 then
				dot_pos := nb
			else
				dot_pos := dot_pos - 1
			end
			
			Result := a_resource.substring (dir_pos.max (1), dot_pos)
		ensure
			resource_name_not_void: Result /= Void
		end
		
	new_compiled_resource_file_name (a_resource: STRING): FILE_NAME is
			-- Using `a_resource' generates a PATH in which output of compiling resource file
			-- `a_resource' will be generated.
		require
			a_resource_not_void: a_resource /= Void
		do
			if System.in_final_mode then
				create Result.make_from_string (System.Final_generation_path)
			else
				create Result.make_from_string (System.Workbench_generation_path)
			end
			Result.set_file_name (resource_name (a_resource))
			Result.add_extension (resources_extension)
		end

	define_resource (a_module: IL_MODULE; a_file, a_name: STRING) is
			-- Add resource file `a_file' with name `a_name' to `a_module'.
		require
			a_module_not_void: a_module /= Void
			a_file_not_void: a_file /= Void
			a_file_exists: (create {RAW_FILE}.make (a_file)).exists
			a_name_not_void: a_name /= Void
		local
			l_token: INTEGER
			l_resources: CLI_RESOURCES
			l_data: MANAGED_POINTER
			l_platform: PLATFORM
			l_raw_file: RAW_FILE
		do
				-- Get resources of `a_module' if already initialized,
				-- otherwise create a new one.
			if a_module.resources /= Void then
				l_resources := a_module.resources
			else
				create l_resources.make
				a_module.set_resources (l_resources)
			end

				-- Read content of `a_file' and add it to the list of known resources
				-- of `a_module'.
			create l_raw_file.make_open_read (a_file)
			
				-- Before putting the resource data in `l_data', we need to insert
				-- the number of bytes in the first 4 bytes of `l_data' so that
				-- we know exactly how long is the current resource entry.
			create l_platform
			create l_data.make (l_raw_file.count + l_platform.integer_32_bytes)
			l_data.put_integer_32_le (l_raw_file.count, 0)
			l_raw_file.read_data (l_data.item + l_platform.integer_32_bytes, l_raw_file.count)
			l_raw_file.close
			l_resources.extend (l_data)

				-- Add entry in manifest resource table of current module.
			l_token := a_module.md_emit.define_manifest_resource (
				create {UNI_STRING}.make (a_name), 0, 0, feature {MD_RESOURCE_FLAGS}.Public)
		ensure
			inserted: a_module.resources /= Void
		end

feature {NONE} -- Implementation: constants

	resources_extension: STRING is "resources"
			-- Compiled resources extension.
	
invariant
	module_not_void: module /= Void
	resources_not_void: resources /= Void

end -- class IL_RESOURCE_GENERATOR
