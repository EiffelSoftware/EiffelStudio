indexing
	description: "Dotnet debug value associated with String value"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_STRING_VALUE

inherit

	ABSTRACT_REFERENCE_VALUE


	EIFNET_ABSTRACT_DEBUG_VALUE	
		undefine
			address
		end
	
create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value; f: like icd_frame) is
		do
		end

feature -- Access

	length: INTEGER is 0
		
	dynamic_class: CLASS_C is
		once
		end

	dump_value: DUMP_VALUE is
		do
		end

feature {NONE} -- Output
	
	type_and_value: STRING is
		do
		end
		
	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
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

