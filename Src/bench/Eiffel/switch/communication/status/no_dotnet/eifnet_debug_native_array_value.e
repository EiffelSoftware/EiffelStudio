indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_NATIVE_ARRAY_VALUE

inherit
	ABSTRACT_SPECIAL_VALUE

feature -- Access

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
		end

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
		end;

feature {ABSTRACT_DEBUG_VALUE} -- Output
		
	append_value (st: STRUCTURED_TEXT) is 
			-- Append only the value of Current to `st'.
		do 
		end;
		
feature -- Output	

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
		end

	get_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		do
		end

	fill_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		do
		end

	string_value: STRING is
		do
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

end -- class EIFNET_DEBUG_NATIVE_ARRAY_VALUE

