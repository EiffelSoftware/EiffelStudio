note

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
			initialize_info, annotation_flags
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_like_argument (Current)
		end

feature -- Properties

	is_like_argument: BOOLEAN = True
			-- Is Current a like argument? (True)

	has_like_argument: BOOLEAN = True
			-- Has the type like argument in its definition? (True)

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				equivalent (actual_type, other.actual_type) and then
				has_same_marks (other)
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		local
			other_like_arg: LIKE_ARGUMENT
		do
			other_like_arg ?= other
			if other_like_arg /= Void then
				Result := other_like_arg.position = position and then
					has_same_marks (other_like_arg)
			end
		end

	position: INTEGER
			-- Position in the argument list

feature -- Setting

	set_position (p: like position)
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Generic conformance

	annotation_flags: NATURAL_16
			-- <Precursor>
		do
			Result := Precursor
			if not compiler_profile.is_experimental_mode then
					-- Unlike {LIKE_TYPE_A} and {FORMAL_A}, if the type is declared without an attachment
					-- mark but the `actual_type' is attached we will need to declare the attachment mark,
					-- this is needed as in non-experimental mode, the type of an object is always detachable
					-- thus we would create a T [detachable A] when T [A] was expected if the argument is
					-- associated to an object of type A.
				if not has_attached_mark and is_attached then
					Result := Result | {SHARED_GEN_CONF_LEVEL}.attached_type
				end
			end
		end

	initialize_info (an_info: like shared_create_info)
		do
			an_info.set_position (position)
		end

	create_info: CREATE_ARG
		do
			create Result
			Result.set_position (position)
		end

	shared_create_info: CREATE_ARG
		once
			create Result
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := actual_type.dump
			create Result.make (16 + actual_dump.count)
			Result.append_character ('[')
			dump_marks (Result)
			Result.append ("like arg#")
			Result.append_integer (position)
			Result.append ("] ")
			Result.append (actual_dump)
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_L_bracket)
			ext_append_marks (a_text_formatter)
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Like_keyword, Void)
			a_text_formatter.add_space
			--Martins 2/6/2007: this code here does not work anymore because of switch from E_FAETURE to CLASS_C
			-- As it has to be removed anyway we do not spent any effort to enable it again.
			-- if a_context_class /= Void then
				--a_text_formatter.process_local_text (a_context_class.arguments.argument_names.i_th (position))
			--else
			a_text_formatter.add ({SHARED_TEXT_ITEMS}.ti_Argument_index)
			a_text_formatter.add_int (position)

			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_R_bracket)
			a_text_formatter.add_space
			if is_valid then
				actual_type.ext_append_to (a_text_formatter, a_context_class)
			end
		end

feature {COMPILER_EXPORTER} -- Primitives

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): like Current
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

	actual_argument_type (a_arg_types: ARRAYED_LIST [TYPE_A]): TYPE_A
			-- Type for conformance.
			-- `actual_type' is the declared type and is the wrong one for
			-- conformance validation.
		do
			check
				valid_position: a_arg_types.valid_index (position)
			end
				-- Preserve attachment status of the current type.
			Result := a_arg_types.i_th (position).to_other_attachment (Current).to_other_variant (Current)
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class LIKE_ARGUMENT
