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
			last_call_success := c_count (item, $Result)
		ensure
			no_error: last_call_success = 0
		end
		
	i_th (i: INTEGER): FUSION_SUPPORT_ASSEMBLY_INFO is
			-- COM interface to assembly information at index 'a_index'
		local
			p: POINTER
		do
			last_call_success := c_ith (item, i, $p)
			create Result.make_by_pointer (p)
		ensure
			no_error: last_call_success = 0	
		end
	
feature {NONE} -- Implementation

	c_count (p, cnt: POINTER): INTEGER is
			-- Call `IEnumAssemblies->Count'.
		external
			"C++ IEnumAssemblies signature (long *): EIF_INTEGER use %"vs_support.h%""
		alias
			"get_Count"
		end

	c_ith (p: POINTER; i: INTEGER; ass_info: POINTER): INTEGER
		is
			-- Call `IEnumAssemblies->IthItem'.
		external
			"C++ IEnumAssemblies signature (long, IAssemblyInfo**): EIF_INTEGER use %"vs_support.h%""
		alias
			"IthItem"
		end

end -- class FUSION_SUPPORT_ASSEMBLIES
