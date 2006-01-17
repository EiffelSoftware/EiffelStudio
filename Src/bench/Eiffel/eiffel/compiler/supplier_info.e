indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Description of a supplier

class
	SUPPLIER_INFO 

inherit
	SHARED_WORKBENCH

create

	make

feature 

	supplier_id: INTEGER;
			-- Supplier

	supplier: CLASS_C is
			-- Corresponding class of id `supplier_id'
		do
			Result := System.class_of_id (supplier_id)
		end

	occurrence: INTEGER;
			-- Occurrence of the supplier in the class

	set_occurrence (i: INTEGER) is
			-- Assign `i' to `occurrence'.
		do
			occurrence := i;
		end;

	make (cl_id: like supplier_id) is
			-- Initialization
		require
			good_argument: cl_id > 0
		do
			supplier_id := cl_id
			occurrence := 1
		end;

	add_occurrence is
			-- Increment `occurrence' of 1.
		do
			occurrence := occurrence + 1;
		end;

	remove_occurrence is
			-- Decrement `occurrence' of 1.
		require
			good_occurrence: occurrence >= 1;
		do
			occurrence := occurrence - 1;
		end;

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

end
