indexing
	description: "Description of a violation of the constrained %
				%genericity validity rule."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class CONSTRAINT_INFO

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Properties

	type: GEN_TYPE_A
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER
			-- Number of the generic parameter violating the rule

	actual_type_set: TYPE_SET_A
			-- Type set involved

	c_type: TYPE_SET_A
			-- Type set involved in the constraint

	unmatched_creation_constraints: LIST[FEATURE_I]
			-- List of unmatched creation constraints

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C) is
		require
			a_text_formatter_not_void: a_text_formatter /= Void
			a_context_class_not_void: a_context_class /= Void
			actual_type_set /= Void
			c_type /= Void
		local
			l_gen_type: GEN_TYPE_A
			l_current_class: CLASS_C
		do
			l_current_class := system.current_class
			system.set_current_class (a_context_class)
			a_text_formatter.add_new_line
			a_text_formatter.add ("For type: ")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Formal #")
			a_text_formatter.add_int (formal_number)
			a_text_formatter.add (": ")
			actual_type_set.ext_append_to (a_text_formatter, type.associated_class )
			a_text_formatter.add_new_line
			if c_type.has_formal then
				l_gen_type ?= type
				check type_is_generic: l_gen_type /= Void end
				c_type := c_type.twin
				c_type.substitude_formals (l_gen_type)
			end
			if not actual_type_set.is_valid or else not actual_type_set.conform_to_type (c_type) then
				a_text_formatter.add ("Type to which it should conform: ")
				c_type.ext_append_to (a_text_formatter, type.associated_class)
				a_text_formatter.add_new_line
			end

			if unmatched_creation_constraints /= Void then
				if actual_type_set.has_deferred then
					a_text_formatter.add ("Unmet creation constraint features because class is deferred:%N")
				else
					a_text_formatter.add ("Unmet creation constraint features:%N")
				end
				unmatched_creation_constraints.do_all (
					agent (aa_text_formatter: TEXT_FORMATTER; a_feature: FEATURE_I)
							-- Print all features
						do
							aa_text_formatter.add_feature_name (a_feature.names_heap.item (a_feature.feature_name_id), a_feature.written_class)
							aa_text_formatter.add (" ")
						end (a_text_formatter, ?))
				a_text_formatter.add ("%N")
			end
			system.set_current_class (l_current_class)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_unmatched_creation_constraints (a_unmatched_creation_constraints: LIST[FEATURE_I])
			-- Set `unmatched_creation_constraints' to `a_unmatched_creation_constraints'
		do
			unmatched_creation_constraints := a_unmatched_creation_constraints
		ensure
			set: unmatched_creation_constraints = a_unmatched_creation_constraints
		end

	set_actual_type_set (t: TYPE_SET_A) is
			-- Assign `t' to `type1'.
		do
			actual_type_set := t
		end

	set_constraint_types (t: TYPE_SET_A) is
			-- Assign `t' to `type2'.
		do
			c_type := t
		end

	set_type (t: GEN_TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_formal_number (i: INTEGER) is
			-- Assign `i' to `formal_number'.
		do
			formal_number := i
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

end -- class CONSTRAINT_INFO
