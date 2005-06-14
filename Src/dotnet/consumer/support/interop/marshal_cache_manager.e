indexing
	description: "Marshalled interface for the Emitter"
	date: "$Date$"
	revision: "$Revision$"

class
	MARSHAL_CACHE_MANAGER

inherit
	MARSHAL_BY_REF_OBJECT

feature -- Access

	is_successful: BOOLEAN is
			-- Was the consuming successful?
		do
			Result := implementation.is_successful
		end
		
	is_initialized: BOOLEAN
			-- Has current object been initialized?
			
	last_error_message: SYSTEM_STRING is
			-- Last error message
		do
			Result := implementation.last_error_message
		end

feature -- Basic Exportations

	initialize (a_clr_version: SYSTEM_STRING) is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		do
			create implementation.make
			is_initialized := True
		ensure
			current_initialized: is_initialized
		end
		
	initialize_with_path (a_path, a_clr_version: SYSTEM_STRING) is
			-- initialize object with path to specific EAC and initializes it if not already done.
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
			path_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil (a_path))).exists
		local
			cr: CACHE_READER
		do
			create implementation.make_with_path (a_path)
			create cr
			if not cr.is_initialized then
				(create {EIFFEL_SERIALIZER}).serialize (create {CACHE_INFO}.make, cr.absolute_info_path, False)
			end
			is_initialized := True
		ensure
			current_initialized: is_initialized
		end

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		do	
			implementation.consume_assembly (a_name, a_version, a_culture, a_key)
		end
		
	consume_assembly_from_path (a_path: SYSTEM_STRING) is
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		do	
			implementation.consume_assembly_from_path (a_path)
		end
		
	relative_folder_name (a_name, a_version, a_culture, a_key: SYSTEM_STRING): SYSTEM_STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		do			
			Result := implementation.relative_folder_name (a_name, a_version, a_culture, a_key)
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	relative_folder_name_from_path (a_path: SYSTEM_STRING): SYSTEM_STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			path_exists: (create {FILE_INFO}.make (a_path)).exists
		do
			Result := implementation.relative_folder_name_from_path (a_path)
		ensure
			non_void_result: Result /= Void
			valid_result: Result.length > 0
		end
		
	assembly_info_from_path (a_path: SYSTEM_STRING): COM_ASSEMBLY_INFORMATION is
			-- retrieve a local assembly's information
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		do
			create Result.make (implementation.assembly_info_from_path (a_path))
		ensure
			non_void_result: Result /= Void
		end

	prepare_for_unload is
			-- prepares all that in necessary be before running app domain in unloaded
		do
			implementation.compact_and_clean_cache
			implementation.release_cached_assemblies
		end

feature {COM_CACHE_MANAGER2} -- Implementation
			
	implementation: CACHE_MANAGER
			-- Access to `CACHE_MANAGER'.

end -- class MARSHAL_CACHE_MANAGER
