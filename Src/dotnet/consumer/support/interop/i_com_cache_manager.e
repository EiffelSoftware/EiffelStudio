indexing
	description: "COM interface for supported metadata consumer"
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE1A4-412E-4517-8BD0-56F31E07E879") end

deferred class
	I_COM_CACHE_MANAGER

feature -- Initialization

	initialize (a_clr_version: SYSTEM_STRING) is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		deferred
		ensure
			clr_version_set: clr_version = a_clr_version
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
		deferred
		ensure
			clr_version_set: clr_version = a_clr_version
			eac_path_set: eac_path = a_path
			current_initialized: is_initialized
		end

feature -- Uninitialization

	unload is
			-- unloads initialized app domain and cache releated objects to preserve resources
		deferred
		end

feature -- Access

	is_successful: BOOLEAN is
			-- Was the consuming successful?
		deferred
		end
		
	is_initialized: BOOLEAN is
			-- has COM object been initialized?
		deferred
		end
		
	last_error_message: SYSTEM_STRING is
			-- Last error message
		deferred
		end

feature -- Basic Operations

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		deferred
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING) is
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		end

feature -- Query

	relative_folder_name (a_name, a_version, a_culture, a_key: SYSTEM_STRING): SYSTEM_STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		deferred
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
		deferred
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end

	assembly_info_from_assembly (a_path: SYSTEM_STRING): I_COM_ASSEMBLY_INFORMATION is
			-- retrieve a local assembly's information
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		deferred
		ensure
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Implementation

	clr_version: SYSTEM_STRING is
			-- Version of CLR used to emit data
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		deferred
		end

	eac_path: SYSTEM_STRING is
			-- Location of EAC `Eiffel Assembly Cache'
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		deferred
		end
		
end -- I_COM_CACHE_MANAGER
