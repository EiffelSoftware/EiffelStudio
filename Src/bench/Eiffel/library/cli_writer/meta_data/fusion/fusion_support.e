indexing
	description: "Encapsulation of IFusionSupport"
	date: "$Date$"
	revision: "$Revision$"

class
	FUSION_SUPPORT

inherit
	COM_OBJECT
	
creation {FUSION_FACTORY}
	make_by_pointer
	
feature -- Access

	signed (a_loc: UNI_STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
		local
			is_signed: INTEGER
			a_bstr: POINTER
		do
			a_bstr := c_get_bstr (a_loc.item)
			last_call_success := c_signed (item, a_bstr, $is_signed)				
			c_free_bstr (a_bstr)
			Result := is_signed /= 0
		end
		
	get_assembly_info_from_assembly (a_loc: UNI_STRING): FUSION_SUPPORT_ASSEMBLY_INFO is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc'
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
		local
			p, a_bstr: POINTER
		do
			a_bstr := c_get_bstr (a_loc.item)
			last_call_success := c_get_assembly_info_from_assembly (item, a_bstr, $p)
			c_free_bstr (a_bstr)
			create Result.make_by_pointer (p)
		end

feature -- Definition

	assemblies: FUSION_SUPPORT_ASSEMBLIES is
			-- Create new scope and returns an assembly enumerator.
		local
			p: POINTER
		do
			last_call_success := c_get_gac_assemblies (item, $p)
			create Result.make_by_pointer (p)
		ensure
			no_error: last_call_success = 0	
		end

feature {NONE} -- Implementation

	c_get_bstr (a_string: POINTER): POINTER is
			-- Retrieve a BSTR from 'a_string' which is a LPWSTR.
		external
			"C macro signature (LPWSTR): EIF_POINTER use %"cli_writer.h%""
		alias
			"SysAllocString"
		end
	
	c_free_bstr (a_bstr: POINTER) is
			-- Free memory associated with 'a_bstr'
		external
			"C macro signature (BSTR) use %"cli_writer.h%""
		alias
			"SysFreeString"
		end

	c_get_gac_assemblies (p, ass: POINTER): INTEGER is
			-- Call `IFusionSupport->GetGacAssemblies'.
		external
			"C++ IFusionSupport signature (IEnumAssemblies**): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"GetGacAssemblies"
		end
		
	c_signed (p, a_loc, sgned: POINTER): INTEGER is
			-- Call `IFusionSupport->IsAssemblySigned'.
		external
			"C++ IFusionSupport signature (BSTR, VARIANT_BOOL *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"IsAssemblySigned"
		end
		
	c_get_assembly_info_from_assembly (p, a_loc, ass_info: POINTER): INTEGER is
			-- Call `IFusionSupport->GetAssemblyInfoFromAssembly'.
		external
			"C++ IFusionSupport signature (BSTR, IAssemblyInfo**): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"GetAssemblyInfoFromAssembly"
		end

end -- class FUSION_SUPPORT
