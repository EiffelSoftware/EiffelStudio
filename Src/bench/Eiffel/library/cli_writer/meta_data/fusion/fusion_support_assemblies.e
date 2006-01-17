indexing
	description: "Encapsulation of IEnumAssemblies defined in <vs_support.h>"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			"C++ IEnumAssemblies signature (long *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"get_Count"
		end

	c_ith (p: POINTER; i: INTEGER; ass_info: POINTER): INTEGER
		is
			-- Call `IEnumAssemblies->IthItem'.
		external
			"C++ IEnumAssemblies signature (long, IAssemblyInfo**): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"IthItem"
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

end -- class FUSION_SUPPORT_ASSEMBLIES
