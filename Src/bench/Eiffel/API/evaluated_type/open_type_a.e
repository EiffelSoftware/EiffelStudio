indexing
	description: "Type of operand `?' in argument list of an agent creation. Just a placeholder during type check."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	OPEN_TYPE_A

inherit
	TYPE_A
		redefine
			is_valid,
			is_equivalent,
			same_as,
			associated_class,
			ext_append_to,
			dump,
			type_i,
			good_generics,
			conform_to,
			instantiation_in,
			format
		end

feature -- Visitor
	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_open_type_a (Current)
		end

feature -- Properties

	is_valid: BOOLEAN is
		do
			Result := True
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			t : OPEN_TYPE_A
		do
			t ?= other
			Result := (t /= Void)
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_type: OPEN_TYPE_A
		do
			other_type ?= other
			Result := (other_type /= Void)
		end

	associated_class: CLASS_C is
			-- Associated class to the type (Void)
		do
			-- Nothing.
		ensure then
			not_called : False
		end

feature -- Output

	ext_append_to (st: TEXT_FORMATTER; f: E_FEATURE) is
		do
			st.add (ti_Open_arg)
		end

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (1)
			Result.append (".")
		end

feature {COMPILER_EXPORTER}

	type_i : CL_TYPE_I is

		do
		ensure then
			not_called : False
		end

	good_generics: BOOLEAN is

		do
			Result := True
		end

feature {COMPILER_EXPORTER} -- Conformance

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		do
			-- An open type can be replaced by anything
			Result := True
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in `written_id'
		do
			Result := Current
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		do
			-- Not creatable
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	format (ctxt: TEXT_FORMATTER_DECORATOR) is

		do
			ctxt.process_string_text ("?", Void)
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

end -- class OPEN_TYPE_A

