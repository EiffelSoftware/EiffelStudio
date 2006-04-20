indexing
	description: "Dotnet debug value associated with Basic type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_BASIC_VALUE [G]

inherit
	DEBUG_VALUE [G]
		rename
			make as dv_make
		redefine
			dump_value
		end
	
	EIFNET_ABSTRACT_DEBUG_VALUE
		redefine
			dump_value
		end
	
create {DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Redefinition of make

	make (a_referenced_value: like icd_referenced_value; a_sk_type: INTEGER; v: like value) is
		require
			a_referenced_value_not_void: a_referenced_value /= Void
		do
			icd_referenced_value := a_referenced_value
			dv_make (a_sk_type, v)
		end
		
feature -- Access : Redefinition of dump_value
		
	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
			-- (from ABSTRACT_DEBUG_VALUE)
		do
			Result := Precursor {DEBUG_VALUE}
			if Result /= Void then
				Result.set_value_dotnet (icd_referenced_value)
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
