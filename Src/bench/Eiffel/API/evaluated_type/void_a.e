indexing
	description: "VOID actual type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VOID_A

inherit
	TYPE_A
		redefine
			is_void, same_as
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_void_a (Current)
		end

feature -- Property

	is_void: BOOLEAN is True
			-- Is the current actual type a void type ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_void
		end

	associated_class: CLASS_C is
		do
			-- No associated calss
		end

feature -- Output

	dump: STRING is "Void"
			-- Dumped trace

	ext_append_to (st: TEXT_FORMATTER; f: E_FEATURE) is
		do
			st.process_keyword_text (ti_void, Void)
		end

feature {COMPILER_EXPORTER}

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		do
			Result := other.conformance_type.is_void
		end

	type_i: VOID_I is
			-- Void type
		once
			create Result
		end

	create_info: CREATE_INFO is
		do
			-- Do nothing
		ensure then
			False
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

end -- class VOID_A
