indexing
	description: "Encapsulation of IFusionSupport"
	date: "$Date$"
	revision: "$Revision$"

class
	FUSION_SUPPORT

inherit
	COM_OBJECT
	
creation
	make,
	make_by_pointer
	
feature {NONE} -- Initialization

	make is
			-- New instance of a IFusionSupport.
		do
			item := new_fusion_support
		end

feature -- Access

	signed (a_loc: UNI_STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
		do
			Result := c_signed (item, a_loc.item)
		end
		
	get_assembly_info_from_assembly (a_loc: UNI_STRING): FUSION_SUPPORT_ASSEMBLY_INFO is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc'
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
		do
			create Result.make_by_pointer (c_get_assembly_info_from_assembly (item, a_loc.item))
		end

feature -- Definition

	assemblies: FUSION_SUPPORT_ASSEMBLIES is
			-- Create new scope and returns an assembly enumerator.
		do
			create Result.make_by_pointer (c_get_gac_assemblies (item))
		end

feature {NONE} -- Implementation

	new_fusion_support: POINTER is
			-- New instance of IFusionSupport
		external
			"C use %"cli_writer.h%""
		end

	c_get_gac_assemblies (an_item: POINTER): POINTER is
			-- Call `IFusionSupport->GetGacAssemblies'.
		external
			"C use %"cli_writer.h%""
		end
		
	c_signed (an_item, a_loc: POINTER): BOOLEAN is
			-- Call `IFusionSupport->IsAssemblySigned'.
		external
			"C use %"cli_writer.h%""
		end
		
	c_get_assembly_info_from_assembly (an_item, a_loc: POINTER): POINTER is
			-- Call `IFusionSupport->GetAssemblyInfoFromAssembly'.
		external
			"C use %"cli_writer.h%""
		end

end -- class FUSION_SUPPORT
