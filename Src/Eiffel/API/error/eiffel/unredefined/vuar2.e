note
	description: "Error for a feature call: type mismatch on one argument."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR2

inherit

	VUAR
		redefine
			build_explain, is_defined, subcode
		end

	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Creation

	make (context: AST_CONTEXT; f: detachable FEATURE_I; u: detachable ID_AS; c: CLASS_C; i: INTEGER; t, a: TYPE_A; l: LOCATION_AS)
			-- Initialize an error object in context `context' with feature `f' called on class `c'
			-- with argument position `i' of formal type `t' and actual type `a' at location `l'.
		require
			f_or_u_attached: attached f or attached u
			c_attached: attached c
			valid_i: attached f implies 0 < i and i <= f.argument_count
			a_attached: attached a
			t_attached: attached t
			l_attached: attached l
		do
			if attached f then
				set_called_feature (f, c.class_id)
				set_argument_name (f.arguments.item_name (i))
			elseif attached u then
				set_argument_name (u.name_32)
			end
			set_argument_position (i)
			set_actual_type (a)
			set_formal_type (t)
			set_location (l)
			context.init_error (Current)
		end

feature -- Properties

	subcode: INTEGER
		do
			Result := 2
		end

	argument_name: STRING
			-- Name of the involved argument

	argument_position: INTEGER

	formal_type: TYPE_A
			-- Formal type of the argument

	actual_type: TYPE_A
			-- Actual type of the call

feature -- Status report

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				argument_name /= Void and then formal_type /= Void and then actual_type /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		local
			l_actual_type: CL_TYPE_A
			l_formal_type: CL_TYPE_A
			l_same_class_name: BOOLEAN
			argument_name_title: STRING
			argument_position_title: STRING
			formal_argument_type_title: STRING
			actual_argument_type_title: STRING
		do
				-- Find out if we should also show the group corresponding to the type
				-- involved when they have the same name (which would be confusion to the user).
				--| Note: The same code is present in VJAR.
			if attached {CL_TYPE_A} actual_type as at and then attached {CL_TYPE_A} formal_type as ft then
				l_actual_type := at
				l_formal_type := ft
				l_same_class_name := l_actual_type.class_id /= l_formal_type.class_id and then
					l_actual_type.base_class.name.is_equal (l_formal_type.base_class.name)
			end

			if attached called_feature then
				print_called_feature (a_text_formatter)
				argument_name_title := "Argument name: "
				argument_position_title := "Argument position: "
				formal_argument_type_title := "Formal argument type: "
				actual_argument_type_title := "Actual argument type: "
			else
				argument_name_title := "Tuple field name: "
				argument_position_title := "Tuple field position: "
				formal_argument_type_title := "Tuple field type: "
				actual_argument_type_title := "Source expression type: "
			end
			a_text_formatter.add (argument_name_title)
			a_text_formatter.add (argument_name)
			a_text_formatter.add_new_line
			a_text_formatter.add (argument_position_title)
			a_text_formatter.add_int (argument_position)
			a_text_formatter.add_new_line
			a_text_formatter.add (formal_argument_type_title)
			formal_type.append_to (a_text_formatter)
			if l_same_class_name then
				check attached l_formal_type then
					a_text_formatter.add (" (from ")
					a_text_formatter.add_group (l_formal_type.base_class.lace_class.group,
						l_formal_type.base_class.lace_class.target.name)
					a_text_formatter.add (")")
				end
			end
			a_text_formatter.add_new_line
			a_text_formatter.add (actual_argument_type_title)
			actual_type.append_to (a_text_formatter)
			if l_same_class_name then
				check attached l_actual_type then
					a_text_formatter.add (" (from ")
					a_text_formatter.add_group (l_actual_type.base_class.lace_class.group,
						l_actual_type.base_class.lace_class.target.name)
					a_text_formatter.add (")")
				end
			end
			a_text_formatter.add_new_line
		end

feature {NONE} -- Setting

	set_argument_name (n: STRING)
			-- Assign `n' to `argument_name'.
		do
			argument_name := n
		end

	set_argument_position (i: INTEGER)
		do
			argument_position := i
		end

	set_formal_type (t: TYPE_A)
			-- Assign `t' to `formal_type'.
		do
			formal_type := t
		end

	set_actual_type (a: TYPE_A)
			-- Assign `a' to `actual_type'.
		do
			actual_type := a
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

end -- class VUAR2
