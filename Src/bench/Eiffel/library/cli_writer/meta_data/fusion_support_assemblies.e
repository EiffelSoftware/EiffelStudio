indexing
	description: "Encapsulation of IEnumAssemblies defined in <vs_support.h>"
	date: "$Date$"
	revision: "$Revision$"

class
	FUSION_SUPPORT_ASSEMBLIES

inherit
	COM_OBJECT
		
create
	make_by_pointer
	
feature -- Access

	count: INTEGER is
		-- Number of assemblies in Current
		do
			Result :=  (c_count (item))
		end
		
	ith_assembly_info (a_index: INTEGER): FUSION_SUPPORT_ASSEMBLY_INFO is
		-- COM interface to assembly information at index 'a_index'
		do
			create Result.make_by_pointer (c_ith (item, a_index))
		end
		
feature {NONE} -- Implementation

	c_count (an_item: POINTER): INTEGER is
			-- Call `IEnumAssemblies->Count'.
		external
			"C use %"cli_writer.h%""
		end
		
	c_ith (an_item: POINTER; a_index: INTEGER): POINTER is
			-- Call `IEnumAssemblies->IthItem'.
		external
			"C use %"cli_writer.h%""
		end

end -- class FUSION_SUPPORT_ASSEMBLIES
