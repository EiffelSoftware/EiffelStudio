indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EXTERNAL_CALL_STACK_ELEMENT

inherit
	CALL_STACK_ELEMENT

create
	make

feature -- Change

	set_info (a_oa: STRING; a_cn, a_fn: STRING; a_bi: INTEGER; a_info: STRING) is
		require
			object_address_not_void: a_oa /= Void
			class_name_not_void: a_cn /= Void
			routine_name_not_void: a_fn /= Void
			break_index_positive: a_bi >= 0
		do
			class_name := a_cn
			routine_name := a_fn
			break_index := a_bi
			object_address := a_oa
			info := a_info
		end

feature -- Properties

	info: STRING

	is_eiffel_call_stack_element: BOOLEAN is False
		-- Is Current an Eiffel Call Stack Element ?

	object_address: STRING

feature -- Output

	display_arguments (st: STRUCTURED_TEXT) is
			-- Display the arguments passed to the routine
			-- associated with Current call.
		do
		end

	display_locals (st: STRUCTURED_TEXT) is
			-- Display the local entities and result (if it exists) of
			-- the routine associated with Current call.
		do
		end

	display_feature (st: STRUCTURED_TEXT) is
			-- Display information about associated routine.
		do
				-- Print object address (14 characters)
			st.add_string ("[")
			st.add_string (display_object_address)
			st.add_string ("] ")
			st.add_column_number (14)
				-- Print class name
			st.add_string (class_name)
			st.add_string (" ")
			st.add_column_number (26)

			st.add_string (routine_name)

			-- print line number
			st.add_string(" ( @ ")
			st.add_int(break_index)
			st.add_string(" )")
		end

	display_object_address: like object_address is
		do
			Result := object_address
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

end -- class EIFFEL_CALL_STACK_ELEMENT
