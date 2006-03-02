indexing

	description:
		"Representation of an type anchored on a routine argument."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class LIKE_ARGUMENT

inherit
	LIKE_TYPE_A
		redefine
			actual_argument_type, is_like_argument
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_like_argument (Current)
		end

feature -- Properties

	is_like_argument: BOOLEAN is True
			-- Is Current a like argument? (True)

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				equivalent (actual_type, other.actual_type)
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_arg: LIKE_ARGUMENT
		do
			other_like_arg ?= other
			Result := other_like_arg /= Void
					and then other_like_arg.position = position
		end

	position: INTEGER
			-- Position in the argument list

feature -- Setting

	set_position (p: like position) is
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := actual_type.dump
			create Result.make (16 + actual_dump.count)
			Result.append ("[like arg #")
			Result.append_integer (position)
			Result.append ("] ")
			Result.append (actual_dump)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_L_bracket)
			st.add (ti_Like_keyword)
			st.add_space
			if f /= Void then
				st.add (create {LOCAL_TEXT}.make (f.arguments.argument_names.i_th (position)))
			else
				st.add (ti_Argument_index)
				st.add_int (position)
			end
			st.add (ti_R_bracket)
			st.add_space
			actual_type.ext_append_to (st, f)
		end

feature {COMPILER_EXPORTER} -- Primitives

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_ARGUMENT is
			-- Check if the anchored type is still a non like type and
			-- update `actual_type'.
		local
			l_argument_type: TYPE_AS
			l_controler_state: BOOLEAN
		do
			l_controler_state := like_control.is_on
			if l_controler_state and like_control.has_argument (position) then
				like_control.raise_error
			else
				if not l_controler_state then
						-- Enable like controler only if not already enabled.
					like_control.turn_on
				end
				l_argument_type := f.arguments.i_th (position)
				Result := twin
					-- Recalculation of the anchor
				Result.set_actual_type
					(l_argument_type.solved_type (feat_table, f).actual_type)
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end
				if not l_controler_state then
						-- Disable like controler only if it was not enabled before
						-- entering current routine.
					like_control.turn_off
				end
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_ARGUMENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := twin
			Result.set_actual_type (actual_type.instantiation_in (type, written_id))
		end

	actual_argument_type (a_arg_types: ARRAY [TYPE_A]): TYPE_A is
			-- Type for conformance.
			-- `actual_type' is the declared type and is the wrong one for
			-- conformance validation.
		do
			check
				valid_position: a_arg_types.valid_index (position)
			end
			Result := a_arg_types.item (position)
		end

	create_info: CREATE_ARG is
			-- Byte code information for entity type creation
		do
			create Result
			Result.set_position (position)
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

end -- class LIKE_ARGUMENT
