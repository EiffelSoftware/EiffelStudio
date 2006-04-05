indexing

	description:
		"Class to represent subquery in a SCROLLABLE_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"


class
	SCROLLABLE_SUBQUERY

inherit
	SCROLLABLE_LIST_ELEMENT

create
	make, make_first

feature -- Creation

	make_first ( a_subquery: STRING ) is
		do
			create subquery.make(0)
			subquery := a_subquery
			create operator.make(0)
			index := 1
		end

	make ( an_operator, a_subquery: STRING; i: INTEGER ) is
		do
			create subquery.make(0)
			create operator.make(0)
			subquery := a_subquery
			operator := an_operator
			index := i
		end

feature -- Access

	value : STRING is
		do
			create Result.make(0)
			Result.append( operator )
			if operator /= "" then
				Result.extend(' ')
			end
			Result.append( subquery )
		end
	
	set_index (idx: INTEGER) is
		do
			index := idx
		end

feature -- Attributes

	operator,
		-- boolean operator

	subquery: STRING
		-- the subquery

	index: INTEGER;
		-- index of the subquery in the query

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

end -- SCROLLABLE_SUBQUERY
