indexing
	description: "Error for violation of the constrained genericity %
				%rule."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCG6

inherit
	EIFFEL_ERROR
		redefine
			build_explain,
			is_defined
		end

feature -- Properties

	feature_name: STRING

	constraint_class: CLASS_C

	constraint_type: TYPE_A
			-- Constraint type

	code: STRING is "VTCG"
			-- Error code

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then feature_name /= Void and then
				(constraint_class /= Void or else constraint_type /= Void)
		end

feature -- Output


	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add_new_line
			a_text_formatter.add ("Error: feature ")
			if constraint_class /= Void then
				a_text_formatter.add_feature_name (feature_name, constraint_class)
			else
				a_text_formatter.add_char ('`')
				a_text_formatter.add (feature_name)
				a_text_formatter.add_char ('%'')
			end
			a_text_formatter.add (" from ")
			if constraint_class /= Void then
				constraint_class.append_signature (a_text_formatter, False)
			else
				check
					constraint_type_not_void: constraint_type /= Void
				end
				constraint_type.append_to (a_text_formatter)
			end
			a_text_formatter.add (" cannot be used for creation.")
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (a_name: STRING) is
			-- Set missing `a_name' of `constraint_class' to `feature_name'.
		require
			feature_name_not_void: a_name /= Void
		do
				--| We don't need to clone the string since it
				--| is a temporary string.
			feature_name := a_name
		ensure
			feature_name_set: feature_name = a_name
		end

	set_constraint_class (c: CLASS_C) is
			-- Set `c' to `constraint_class' which does not
			-- contain `feature_name'
		require
			class_exists: c /= Void
		do
			constraint_class := c
		ensure
			constraint_class_set: constraint_class = c
		end

	set_constraint_type (t: TYPE_A) is
			-- Set `t' to `constraint_type' which does not
			-- contain `feature_name'.
		require
			t_not_void: t /= Void
		do
			constraint_type := t
		ensure
			constraint_type_set: constraint_type = t
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

end
