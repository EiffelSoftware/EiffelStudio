indexing
	description: "[
		Eiffel interface class for emitter.exe or ISE.CacheManager.dll assemblies
		Encapsulates the COM_ISE_CACHE_MANAGER class
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ISE_CACHE_MANAGER

inherit
	COM_OBJECT

create
	make,
	make_by_pointer
	
feature {NONE} -- Initialization

	make is
			-- creates new instance
		do
			item := new_ise_cache_manager
		end
		
feature -- Access

	is_successful: BOOLEAN is
			-- was the last operation successful?
		local
			res: INTEGER
		do
			last_call_success := c_is_successful (item, $res)
			Result := res /= 0
		ensure
			success: last_call_success = 0
		end
	
	last_error_message: UNI_STRING is
			-- last error message of a failed operation
		local
			res: POINTER
		do
			last_call_success := c_last_error_message (item, $res)
			if res /= Void then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
		end

feature -- Basic Oprtations
	
	consume_gac_assembly (aname, aversion, aculture, akey: UNI_STRING) is
			-- consume an assembly into the EAC from the gac defined by
			-- "'aname', Version='aversion', Culture='aculture', PublicKeyToken='akey'"
		require
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_void_key: akey /= Void
			non_empty_name: aname.length > 0
			non_empty_version: aversion.length > 0
			non_empty_culture: aculture.length > 0
			non_empty_key: akey.length > 0
		local
			bstr_name: BSTR_STRING
			bstr_version: BSTR_STRING
			bstr_culture: BSTR_STRING
			bstr_key: BSTR_STRING
		do	
			create bstr_name.make_by_uni_string (aname)
			create bstr_version.make_by_uni_string (aversion)
			create bstr_culture.make_by_uni_string (aculture)
			create bstr_key.make_by_uni_string (akey)

			last_call_success := c_consume_gac_assembly (item, bstr_name.item, bstr_version.item, bstr_culture.item, bstr_key.item)
		ensure
			success: last_call_success = 0
		end
		
	consume_local_assembly (apath, adest: UNI_STRING) is
			-- consume the local assembly found at 'apath' and all of its local dependacies into 'adest'.
			-- GAC dependacies will be put into the EAC
		require
			non_void_path: apath /= Void
			non_empty_path: apath.length > 0
			non_void_dest: adest /= Void
			assembly_exists: (create {RAW_FILE}.make (apath.string)).exists
			dest_exists: (create {DIRECTORY}.make (adest.string)).exists
		local
			bstr_path: BSTR_STRING
			bstr_dest: BSTR_STRING
		do
			create bstr_path.make_by_uni_string (apath)
			create bstr_dest.make_by_uni_string (adest)
			last_call_success := c_consume_local_assembly (item, bstr_path.item, bstr_dest.item)
		ensure
			success: last_call_success = 0
		end
		
	relative_folder_name (aname, aversion, aculture, akey: UNI_STRING): UNI_STRING is
			-- retireves the relative path to an assembly
		require
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_empty_name: aname.length > 0
			non_empty_version: aversion.length > 0
			non_empty_culture: aculture.length > 0
		local
			bstr_name: BSTR_STRING
			bstr_version: BSTR_STRING
			bstr_culture: BSTR_STRING
			bstr_key: BSTR_STRING
			res: POINTER
			void_pointer: POINTER
		do	
			create bstr_name.make_by_uni_string (aname)
			create bstr_version.make_by_uni_string (aversion)
			create bstr_culture.make_by_uni_string (aculture)
			if akey /= Void and akey.length > 0 then
				create bstr_key.make_by_uni_string (akey)
				last_call_success := c_relative_folder_name (item, bstr_name.item, bstr_version.item, bstr_culture.item, bstr_key.item, $res)
			else
				last_call_success := c_relative_folder_name (item, bstr_name.item, bstr_version.item, bstr_culture.item, void_pointer, $res)
			end

			if res /= Void then
				create Result.make_by_pointer (res)
			end
			
		ensure
			success: last_call_success = 0
		end
		
	assembly_info_from_assembly (apath: UNI_STRING): COM_ASSEMBLY_INFORMATION is
			-- retrieve the assembly information from a assembly
		require
			non_void_path: apath /= Void
			non_empty_path: apath.length > 0
		local
			bstr_path: BSTR_STRING
			res: POINTER
		do
			create bstr_path.make_by_uni_string (apath)
			last_call_success := c_assembly_info_from_assembly (item, bstr_path.item, $res)
			
			if res /= Void then
				create Result.make_by_pointer (res)
			end
		ensure
			success: last_call_success = 0
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Implementation

	new_ise_cache_manager: POINTER is
			-- Creates new instance
		external
			"C use %"cli_writer.h%""
		end
		
	c_is_successful (ap:POINTER; aret_val: POINTER): INTEGER is
			-- was the last operation successful?
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (VARIANT_BOOL*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"is_successful"
		end
		
	c_last_error_message (ap:POINTER; aret_val: POINTER): INTEGER is
			-- last error message of a failed operation
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"last_error_message"
		end

	c_consume_gac_assembly (ap, aname, aversion, aculture, akey: POINTER): INTEGER is
			-- consume an assembly into the EAC from the gac defined by
			-- "'aname', Version='aversion', Culture='aculture', PublicKeyToken='akey'"
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (BSTR, BSTR, BSTR, BSTR):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"consume_gac_assembly"
		end

	c_consume_local_assembly (ap, apath, adest: POINTER): INTEGER is
			-- consume a locally referenced assembly an all of its local dependacies into 'adest' and GAC dependacies into the EAC
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (BSTR, BSTR):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"consume_local_assembly"
		end

	c_relative_folder_name (ap, aname, aversion, aculture, akey: POINTER; aret_val:POINTER): INTEGER is
			-- retireve the name of the folder for the given assembly
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (BSTR, BSTR, BSTR, BSTR, LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"relative_folder_name"
		end
		
	c_assembly_info_from_assembly (ap, apath: POINTER; ret_val: POINTER): INTEGER is
			-- -- retrieve the assembly information from a assembly
		external
			"C++ ISE_Cache_COM_ISE_CACHE_MANAGER signature (BSTR, ISE_Cache_COM_ASSEMBLY_INFORMATION**):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"assembly_info_from_assembly"
		end
		
end -- class COM_ISE_CACHE_MANAGER_INTERFACE
