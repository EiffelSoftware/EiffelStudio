indexing
	description: "[
		Eiffel interface class for EiffelSoftware.MetadataConsumer.exe or EiffelSoftware.MetadataConsumer.dll assemblies
		Encapsulates the COM_CACHE_MANAGER class
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_CACHE_MANAGER

inherit
	COM_OBJECT
		rename
			is_successful as is_com_successful
		end

create
	make_by_pointer
	
feature -- Initialization

	initialize (a_clr_version: UNI_STRING) is
			-- Initialize current.
		require
			a_clr_version_not_void: a_clr_version /= Void
		local
			l_ver: BSTR_STRING
		do
			create l_ver.make_by_uni_string (a_clr_version)
			last_call_success := c_initialize (item, l_ver.item)
			is_initialized := last_call_success = 0
		ensure
			success: last_call_success = 0
		end
		
	initialize_with_path (a_path, a_clr_version: UNI_STRING) is
			-- Initialize current with `a_path' as ISE_EIFFEL var.
		require
			a_path_not_void: a_path /= Void
			a_clr_version_not_void: a_clr_version /= Void
		local
			l_path, l_ver: BSTR_STRING
		do
			create l_path.make_by_uni_string (a_path)
			create l_ver.make_by_uni_string (a_clr_version)
			last_call_success := c_initialize_with_path (item, l_path.item, l_ver.item)
			is_initialized := last_call_success = 0
		ensure
			success: last_call_success = 0
		end
		
feature -- Access

	is_initialized: BOOLEAN
			-- Has Current been correctly initiliazed?

	is_successful: BOOLEAN is
			-- Was last operation successful?
		require
			initialized: is_initialized
		local
			res: INTEGER
		do
			last_call_success := c_is_successful (item, $res)
			Result := res /= 0
		ensure
			success: last_call_success = 0
		end
	
	last_error_message: UNI_STRING is
			-- Last error message of a failed operation
		require
			initialized: is_initialized
		local
			res: POINTER
		do
			last_call_success := c_last_error_message (item, $res)
			if res /= default_pointer then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
		end

feature -- Basic Oprtations
	
	consume_assembly (a_name, a_version, a_culture, a_key: UNI_STRING) is
			-- Consume an assembly into the EAC from at least `a_name'
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			initialized: is_initialized		
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			bstr_name: BSTR_STRING
			bstr_version: BSTR_STRING
			bstr_culture: BSTR_STRING
			bstr_key: BSTR_STRING
		do	
			create bstr_name.make_by_uni_string (a_name)
			if a_version /= Void then
				create bstr_version.make_by_uni_string (a_version)
			else
				create bstr_version.make_by_pointer (default_pointer)
			end
			if a_culture /= Void then
				create bstr_culture.make_by_uni_string (a_culture)
			else
				create bstr_culture.make_by_pointer (default_pointer)
			end
			if a_key /= Void then
				create bstr_key.make_by_uni_string (a_key)
			else
				create bstr_key.make_by_pointer (default_pointer)
			end

			last_call_success := c_consume_assembly (item, bstr_name.item, bstr_version.item, bstr_culture.item, bstr_key.item)
		ensure
			success: last_call_success = 0
		end
		
	consume_assembly_from_path (a_path: UNI_STRING) is
			-- consume assembly found at 'apath' and all of its dependacies into EAC.
			-- GAC dependacies will be put into the EAC
		require
			initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			bstr_path: BSTR_STRING
		do
			create bstr_path.make_by_uni_string (a_path)
			last_call_success := c_consume_assembly_from_path (item, bstr_path.item)
		ensure
			success: last_call_success = 0
		end
		
	relative_folder_name (a_name, a_version, a_culture, a_key: UNI_STRING): UNI_STRING is
			-- Retrieves relative path to an assembly using at least `a_name'
		require
			initialized: is_initialized		
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			bstr_name: BSTR_STRING
			bstr_version: BSTR_STRING
			bstr_culture: BSTR_STRING
			bstr_key: BSTR_STRING
			res: POINTER
		do	
			create bstr_name.make_by_uni_string (a_name)
			if a_version /= Void then
				create bstr_version.make_by_uni_string (a_version)
			else
				create bstr_version.make_by_pointer (default_pointer)
			end
			if a_culture /= Void then
				create bstr_culture.make_by_uni_string (a_culture)
			else
				create bstr_culture.make_by_pointer (default_pointer)
			end
			if a_key /= Void then
				create bstr_key.make_by_uni_string (a_key)
			else
				create bstr_key.make_by_pointer (default_pointer)
			end

			last_call_success := c_relative_folder_name (item, bstr_name.item, bstr_version.item, bstr_culture.item, bstr_key.item, $res)

			if res /= default_pointer then
				create Result.make_by_pointer (res)
			end
			
		ensure
			success: last_call_success = 0
		end

	relative_folder_name_from_path (a_path: UNI_STRING): UNI_STRING is
			-- Retrieves relative path to an assembly at `a_path' metadata.
		require
			initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			bstr_path: BSTR_STRING
			res: POINTER
		do	
			create bstr_path.make_by_uni_string (a_path)
			last_call_success := c_relative_folder_name_from_path (item, bstr_path.item, res)
			if res /= default_pointer then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
		end
		
	assembly_info_from_assembly (a_path: UNI_STRING): COM_ASSEMBLY_INFORMATION is
			-- retrieve the assembly information from a assembly
		require
			initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		local
			bstr_path: BSTR_STRING
			res: POINTER
		do
			create bstr_path.make_by_uni_string (a_path)
			last_call_success := c_assembly_info_from_assembly (item, bstr_path.item, $res)
			
			if res /= default_pointer then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
			non_void_result: Result /= Void
		end

	unload is
			-- unloads initialized app domain and cache releated objects to preserve resources
		do
			last_call_success := c_unload (item)
		ensure
			success: last_call_success = 0
		end
		
feature {NONE} -- Implementation
		
	c_initialize (ap, ver: POINTER): INTEGER is
			-- initialize COM object 
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"Initialize"
		end
		
	c_initialize_with_path (ap:POINTER; ap2, ver: POINTER): INTEGER is
			-- initialize COM object with alternative ISE_EIFFEL path ?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR, BSTR):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"InitializeWithPath"
		end

	c_is_initalized (ap:POINTER; aret_val: POINTER): INTEGER is
			-- was the last operation successful?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (VARIANT_BOOL*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"IsInitialized"
		end

	c_is_successful (ap:POINTER; aret_val: POINTER): INTEGER is
			-- was the last operation successful?
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (VARIANT_BOOL*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"IsSuccessful"
		end
		
	c_last_error_message (ap:POINTER; aret_val: POINTER): INTEGER is
			-- last error message of a failed operation
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"LastErrorMessage"
		end

	c_consume_assembly (ap, a_name, a_version, a_culture, a_key: POINTER): INTEGER is
			-- Consume an assembly into the EAC from at least `a_name'
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR, BSTR, BSTR, BSTR): EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"ConsumeAssembly"
		end

	c_consume_assembly_from_path (ap, a_path: POINTER): INTEGER is
			-- Consume referenced assembly `a_path' an all of its dependacies into EAC
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR): EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"ConsumeAssemblyFromPath"
		end

	c_relative_folder_name (ap, a_name, a_version, a_culture, a_key: POINTER; aret_val:POINTER): INTEGER is
			-- Retireve the name of the folder for the given assembly using at least `a_name'
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR, BSTR, BSTR, BSTR, BSTR*): EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"RelativeFolderName"
		end

	c_relative_folder_name_from_path (ap, a_path: POINTER; a_ret_val: POINTER): INTEGER is
			-- Retireve the name of the folder for the given assembly at `a_path'
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR, BSTR*): EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"RelativeFolderNameFromPath"
		end
	
	c_assembly_info_from_assembly (ap, a_path: POINTER; a_ret_val: POINTER): INTEGER is
			-- -- retrieve the assembly information from a assembly
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature (BSTR, EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation**):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"AssemblyInfoFromAssembly"
		end
		
	c_unload (ap: POINTER): INTEGER is
			-- -- retrieve the assembly information from a assembly
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_IComCacheManager signature ():EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"Unload"
		end

		
end -- class COM_CACHE_MANAGER
