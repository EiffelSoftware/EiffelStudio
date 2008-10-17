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
			actual_argument_type, is_like_argument, has_like_argument, evaluated_type_in_descendant,
			initialize_info
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

	has_like_argument: BOOLEAN is True
			-- Has the type like argument in its definition? (True)

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				equivalent (actual_type, other.actual_type) and then
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_arg: LIKE_ARGUMENT
		do
			other_like_arg ?= other
			if other_like_arg /= Void then
				Result := other_like_arg.position = position and then
					has_same_attachment_marks (other_like_arg)
			end
		end

	position: INTEGER
			-- Position in the argument list

feature -- Setting

	set_position (p: like position) is
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Generic conformance

	initialize_info (an_info: like shared_create_info) is
		do
			an_info.set_position (position)
		end

	create_info: CREATE_ARG is
		do
			create Result
			Result.set_position (position)
		end

	shared_create_info: CREATE_ARG is
		once
			create Result
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := actual_type.dump
			create Result.make (16 + actual_dump.count)
			Result.append_character ('[')
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
			Result.append ("like arg#")
			Result.append_integer (position)
			Result.append ("] ")
			Result.append (actual_dump)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		do
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_L_bracket)
			if has_attached_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_exclamation)
			elseif has_detachable_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_question)
			end
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Like_keyword, Void)
			st.add_space
			--Martins 2/6/2007: this code here does not work anymore because of switch from E_FAETURE to CLASS_C
			-- As it has to be removed anyway we do not spent any effort to enable it again.
			-- if c /= Void then
				--st.process_local_text (c.arguments.argument_names.i_th (position))
			--else
			st.add ({SHARED_TEXT_ITEMS}.ti_Argument_index)
			st.add_int (position)

			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_R_bracket)
			st.add_space
			if is_valid then
				actual_type.ext_append_to (st, c)
			end
		end

feature {COMPILER_EXPORTER} -- Primitives

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): like Current is
		local
			l_new_type: TYPE_A
		do
			if a_ancestor /= a_descendant then
				l_new_type := a_feature.arguments.i_th (position).evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature)
				if l_new_type /= actual_type then
					Result := twin
					Result.set_actual_type (l_new_type)
				else
					Result := Current
				end
			else
				Result := Current
			end
		end

	actual_argument_type (a_arg_types: ARRAY [TYPE_A]): TYPE_A is
			-- Type for conformance.
			-- `actual_type' is the declared type and is the wrong one for
			-- conformance validation.
		do
			check
				valid_position: a_arg_types.valid_index (position)
			end
				-- Preserve attachment status of the current type.
			Result := to_current_attachment (a_arg_types.item (position))
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class LIKE_ARGUMENT
