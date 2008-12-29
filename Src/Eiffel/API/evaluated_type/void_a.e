note
	description: "VOID actual type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VOID_A

inherit
	TYPE_A
		redefine
			is_reference, is_void, same_as, c_type
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_void_a (Current)
		end

feature -- Property

	is_void: BOOLEAN = True
			-- Is the current actual type a void type ?

	is_reference: BOOLEAN = False
			-- Current type is certainly not a reference since it is nothing.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Access

	hash_code: INTEGER
		do
			Result := {SHARED_HASH_CODE}.void_code
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is `other' the same as Current ?
		do
			Result := other.is_void
		end

	associated_class: CLASS_C
		do
			-- No associated calss
		end

feature -- Output

	dump: STRING = "Void"
			-- Dumped trace

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C)
		do
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_void, Void)
		end

feature {COMPILER_EXPORTER}

	conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current conform to `other'?
		do
			Result := other.conformance_type.is_void
		end

	c_type: VOID_I
			-- Void type
		do
			Result := void_c_type
		end

	create_info: CREATE_INFO
		do
			-- Do nothing
		ensure then
			False
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

end -- class VOID_A
