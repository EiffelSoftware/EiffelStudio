indexing
	description: "BSTR string for COM Interop"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BSTR_STRING

inherit
	DISPOSABLE

create
	make_by_uni_string,
	make_by_pointer
	
feature {NONE} -- Initialization

	make_by_uni_string (astring: UNI_STRING) is
			-- creates new instance from a unistring
		require
			non_void_string: astring /= Void
		do
			item := c_get_bstr (astring.item)
		ensure
			string_created: item /= default_pointer
		end
		
	make_by_pointer (p: POINTER) is
			-- create a BSTR from a pointer
		require
			non_void_pointer: p /= default_pointer
		do
			item := p
		end
		
feature -- Access

	item: POINTER
		-- pointer to the BSTR string
		
feature -- Basic Oprtations

	string: STRING is
			-- return a STRING
		do
			Result := uni_string.string
		end
		
	uni_string: UNI_STRING is
			-- returns a UNI_STRING
		do
			create Result.make_by_pointer (item)
		end
		
feature -- Destruction

	dispose is
			-- free up used resources
		do
			c_free_bstr (item)
		end
		
feature {NONE} -- Implementation

	c_get_bstr (astring: POINTER): POINTER is
			-- returns a BSTR from a UNI_STRING
		external
			"C signature (LPWSTR): EIF_POINTER use %"OleAuto.h%""
		alias
			"SysAllocString"
		end
		
	c_free_bstr (abstr: POINTER) is
			-- frees a BSTR
		external
			"C signature (BSTR) use %"OleAuto.h%""
		alias
			"SysFreeString"
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

end -- class ISE_COM_CACHE_MANAGER_INTERFACE
