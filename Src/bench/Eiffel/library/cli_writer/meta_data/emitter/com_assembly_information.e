indexing
	description: "[
		Eiffel interface class for emitter.exe or ISE.CacheManager.dll assemblies
		Encapsulates the COM_ASSEMBLY_INFORMATION class
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ASSEMBLY_INFORMATION

inherit
	COM_OBJECT

create {COM_CACHE_MANAGER}
	make_by_pointer
	
feature -- Access

	name: STRING is
			-- assembly name
		local
			res: POINTER
		do
			last_call_success := c_name (item, $res)
			if res /= default_pointer then
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
			if res /= default_pointer then
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
			if res /= default_pointer then
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
			if res /= default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
	is_in_gac: BOOLEAN is
			-- Was assembly consumed in GAC
		local
			l_res: INTEGER
		do
			last_call_success := c_is_in_gac (item, $l_res)
			Result := l_res /= 0
		ensure
			success: last_call_success = 0
		end
		
	is_consumed: BOOLEAN is
			-- has assembly been consumed?
		local
			l_res: INTEGER
		do
			last_call_success := c_is_consumed (item, $l_res)
			Result := l_res /= 0
		ensure
			success: last_call_success = 0
		end	
		
	consumed_folder_name: STRING is
			-- assembly consumed folder name
		local
			res: POINTER
		do
			last_call_success := c_consumed_folder_name (item, $res)
			if res /= default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (res)).string
			end
		ensure
			success: last_call_success = 0
		end
		
feature {NONE} -- Implementation
	
	c_name (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly name
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"name"
		end
		
	c_version (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly version
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"version"
		end
		
	c_culture (ap:POINTER; aret_val: POINTER): INTEGER is
			-- asssembly culture
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"culture"
		end
		
	c_public_key_token (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly public key token
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"public_key_token"
		end

	c_is_in_gac (ap:POINTER; aret_val: POINTER): INTEGER is
			-- was assembly consumed in GAC
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (VARIANT_BOOL*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"is_in_gac"
		end

	c_is_consumed (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly consumed folder name
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (VARIANT_BOOL*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"is_consumed"
		end

	c_consumed_folder_name (ap:POINTER; aret_val: POINTER): INTEGER is
			-- assembly consumed folder name
		external
			"C++ EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION signature (LPWSTR*):EIF_INTEGER use %"metadata_consumer.h%""
		alias
			"consumed_folder_name"
		end

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

end -- class COM_ASSEMBLY_INFORMATION
