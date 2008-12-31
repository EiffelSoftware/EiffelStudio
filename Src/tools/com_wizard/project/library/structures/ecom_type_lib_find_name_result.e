note
	description: "Result structure of ECOM_TYPE_INFO.find_name"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_TYPE_LIB_FIND_NAME_RESULT
	
create
	make
	
feature -- Initialization

	make (cnt: INTEGER)
			-- Initialize attributes
		do
			create type_info.make (1, cnt)
			create member_ids.make (1, cnt)
			count := cnt
		end
		
feature -- Access 

	type_info: ARRAY [ECOM_TYPE_INFO]
			-- Instances of ECOM_TYPE_INFO that matched name passed to ECOM_TYPE_LIB.`find_name'
		
	member_ids: ARRAY [INTEGER]
			-- Array of identifiers of ITypeInfo interfaces
		
	count: INTEGER
			-- Size of arrays
			
feature -- Element Change

	put_member_ids (value, index: INTEGER)
			-- Set `item' of `member_ids' at `index' with `value'.
		do
			member_ids.put (value, index)
		end
		
	put_type_info (value: ECOM_TYPE_INFO; index: INTEGER)
			-- Set `item' of `type_info' at `index' with `value'.
		do
			type_info.put (value, index)
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
end -- class ECOM_TYPE_LIB_FIND_NAME_RESULT


