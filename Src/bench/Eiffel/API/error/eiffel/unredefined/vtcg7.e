indexing
	description: "Error for violation of the constrained genericity %
				%rule."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCG7

inherit
	VTCG
		redefine
			build_explain
		end

feature -- Properties

	parent_type: TYPE_A
			-- Parent type involved in the error

	in_constraint: BOOLEAN
			-- Is checked done in constraint clause of a class?

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			if in_constraint then
				a_text_formatter.add ("In constraint genericity clause")
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("In declaration: ")
			parent_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			Precursor {VTCG} (a_text_formatter)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_parent_type (p: TYPE_A) is
			-- Assign `p' to `parent_type'.
		require
			p_not_void: p /= Void
		do
			parent_type := p
		ensure
			parent_type_set: parent_type = p
		end

	set_in_constraint (v: like in_constraint) is
			-- Assign `v' to `in_constraint'.
		do
			in_constraint := v
		ensure
			in_constraint_set: in_constraint = v
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

end -- class VTCG7
