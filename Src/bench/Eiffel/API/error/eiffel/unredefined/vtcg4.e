indexing
	description: "Error for violation of the constrained genericity %
				%rule by a parent type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	VTCG4 

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

feature -- Properties

	parent_type: CL_TYPE_A
			-- Parent type involved in the error

	error_list: LINKED_LIST [CONSTRAINT_INFO]
			-- Error description list

	code: STRING is "VTCG"
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("In parent clause: ")
			parent_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			from
				error_list.start
			until
				error_list.after
			loop
				error_list.item.build_explain (a_text_formatter)
				error_list.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_error_list (e: like error_list) is
			-- Assign `e' to `error_list'.
		do
			error_list := e
		end

	set_parent_type (p: CL_TYPE_A) is
			-- Assign `p' to `parent_type'.
		do
			parent_type := p
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

end -- class VTCG4
