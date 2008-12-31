note
	description: "COM CUSTDATAITEM structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_CUST_DATA_ITEM

inherit
	ECOM_STRUCTURE

create
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	guid: ECOM_GUID
			-- GUID
		do
			create Result.make_from_pointer (ccom_custdataitem_guid (item))
		ensure
			Result /= Void
		end

	variant_structure: ECOM_VARIANT
			-- VARIANT structure
		do
			create Result.make_from_pointer (ccom_custdataitem_variant (item))
		ensure
			Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of CUSTDATAITEM structure
		do
			Result := c_size_of_cust_data_item
		end

feature {NONE} -- Externals

	c_size_of_cust_data_item: INTEGER
		external 
			"C [macro %"E_custdataitem.h%"]"
		alias
			"sizeof(CUSTDATAITEM)"
		end

	ccom_custdataitem_guid (a_ptr: POINTER): POINTER
		external
			"C [macro %"E_custdataitem.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_custdataitem_variant (a_ptr: POINTER): POINTER
		external
			"C [macro %"E_custdataitem.h%"](EIF_POINTER): EIF_POINTER"
		end

note
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
end -- class ECOM_CUST_DATA_ITEM


