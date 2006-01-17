indexing
	description	: "Class to represent subquery in a EV_MULTI_COLUMN_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SUBQUERY_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

create
	make_normal, make_first

create {EB_SUBQUERY_ITEM}
	make_filled

feature -- Creation

	make_first (a_subquery: STRING) is
		do
			create subquery.make (0)
			subquery := a_subquery
			create operator.make (0)
			number := 1
			default_create
			extend (value)
		end

	make_normal (an_operator, a_subquery: STRING; i: INTEGER) is
		do
			create subquery.make (0)
			create operator.make (0)
			subquery := a_subquery
			operator := an_operator
			number := i
			default_create
			extend (value)
		end

feature -- Access

	value: STRING is
		do
			create Result.make (0)
			Result.append (operator)
			if operator /= "" then
				Result.extend (' ')
			end
			Result.append (subquery)
		end

	set_number (idx: INTEGER) is
		do
			number := idx
		end

feature -- Attributes

	operator,
		-- boolean operator

	subquery: STRING
		-- the subquery

	number: INTEGER;
		-- index of the subquery in the query

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

end -- class EB_SUBQUERY_ITEM
