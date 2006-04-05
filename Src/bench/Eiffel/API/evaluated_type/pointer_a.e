indexing
	description: "Actual type for pointer type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_A

inherit
	BASIC_A
		redefine
			is_pointer, type_i, associated_class, same_as,
			default_create, process
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of POINTER_A.
		do
			make (associated_class.class_id)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_pointer_a (Current)
		end

feature -- Property

	is_pointer: BOOLEAN is True
			-- Is the current type a pointer type ?

	associated_class: CLASS_C is
			-- Class POINTER
		once
			Result := System.pointer_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	type_i: POINTER_I is
			-- Pointer C type
		do
			Result := pointer_c_type
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_pointer
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

end -- class POINTER_A
