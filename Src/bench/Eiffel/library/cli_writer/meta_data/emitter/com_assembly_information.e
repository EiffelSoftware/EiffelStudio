indexing
	description: "[
		Eiffel interface class for emitter.exe or ISE.CacheManager.dll assemblies
		Encapsulates the COM_ASSEMBLY_INFORMATION class
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ASSEMBLY_INFORMATION

inherit
	COM_OBJECT

create {COM_ISE_CACHE_MANAGER}
	make_by_pointer
	
feature -- Access

	name: STRING is
			-- assembly name
		local
			res: POINTER
		do
			last_call_success := c_name (item, $res)
			if res /= Void then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
	version: STRING is
			-- assembly version
		local
			res: POINTER
		do
			last_call_success := c_version (item, $res)
			if res /= Void then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
	culture: STRING is
			-- assembly culture
		local
			res: POINTER
		do
			last_call_success := c_culture (item, $res)
			if res /= Void then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
	public_key_token: STRING is
			-- assembly public key token
		local
			res: POINTER
		do
			last_call_success := c_public_key_token (item, $res)
			if res /= Void then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
feature {NONE} -- Implementation
	
	c_name (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly name
		external
			"C++ ISE_Cache_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"name"
		end
		
	c_version (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly version
		external
			"C++ ISE_Cache_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"version"
		end
		
	c_culture (ap:POINTER; aret_val: POINTER): INTEGER is
			-- asssembly culture
		external
			"C++ ISE_Cache_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"culture"
		end
		
	c_public_key_token (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly public key token
		external
			"C++ ISE_Cache_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"ise_cache_manager.h%""
		alias
			"public_key_token"
		end

end -- class COM_ASSEMBLY_INFORMATION
