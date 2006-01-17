indexing

	description:
		"The query as to run the profile information with."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILER_QUERY

feature -- Status setting

	set_subqueries (new_queries: LINKED_LIST [SUBQUERY]) is
			-- Set `subqueries' to `new_queries'.
		do
			from
				create subqueries.make;
				new_queries.start;
			until
				new_queries.after
			loop
				if new_queries.item.is_active then
					subqueries.extend (new_queries.item)
				end
				new_queries.forth;
			end;
		end;

	append_subqueries (new_subqueries: LINKED_LIST [SUBQUERY]) is
			-- Append `new_subqueries' to `subqueries'.
		require
			subquires_not_void: subqueries /= Void
		do
			from
				new_subqueries.start
			until
				new_subqueries.after
			loop
				if new_subqueries.item.is_active then
					subqueries.extend (new_subqueries.item)
				end;
				new_subqueries.forth
			end
		end;

	set_subquery_operators (new_operators: LINKED_LIST [SUBQUERY_OPERATOR]) is
			-- Set `subquery_operators' to `new_operators'.
		do
			from
				create subquery_operators.make;
				new_operators.start;
			until
				new_operators.after
			loop
				if new_operators.item.is_active then
					subquery_operators.extend (new_operators.item)
				end;
				new_operators.forth;
			end;
		end;

	append_subquery_operators (new_operators: LINKED_LIST [SUBQUERY_OPERATOR]) is
			-- Add `new_operators' to `subquery_operators'.
		do
			from
				new_operators.start
			until
				new_operators.after
			loop
				if new_operators.item.is_active then
					subquery_operators.extend (new_operators.item)
				end;
				new_operators.forth
			end
		end;

	merge (other: like Current) is
			-- Merge contents of `other' into Current.
		do
			if subqueries = Void then
				create subqueries.make
			end;
			if subquery_operators = Void then
				create subquery_operators.make
			end
			append_subqueries (other.subqueries)
			append_subquery_operators (other.subquery_operators)
		end

	extend_subquery_operator (new_operator: SUBQUERY_OPERATOR) is
			-- Add only one operator to subquery_operators
		do
			if new_operator.is_active then
				subquery_operators.extend (new_operator)
			end
		end

feature -- Status report

	image: STRING is
			-- Image of all subqueries and operators.
		local
			sq: SUBQUERY
			i: INTEGER
			so: SUBQUERY_OPERATOR
		do
			from
				i := 1
				create Result.make (0)
			until
				i > subqueries.count
			loop
				sq := subquery_at (i)
				Result.append (sq.image)
				if i <= subquery_operators.count then
					Result.extend (' ')
					so := operator_at (i)
					Result.append (so.actual_operator)
				end
				Result.extend ('%N')
				i := i + 1
			end
		end		

	subquery_at (index: INTEGER): SUBQUERY is
			-- Result is the subquery at position `index'.
		require
			index_large_enough: index >= 1;
			index_small_enough: index <= subqueries.count;
		local
			i: INTEGER
		do
			from
				i := 1;
				subqueries.start
			until
				i = index
			loop
				subqueries.forth;
				i := i + 1;
			end;
			Result := subqueries.item;
		end;

	operator_at (index: INTEGER): SUBQUERY_OPERATOR is
			-- Result is the operator at position `index'.
		require
			index_large_enough: index >= 1;
			index_small_enough: index <= subquery_operators.count;
		local
			i: INTEGER
		do
			from
				i := 1;
				subquery_operators.start
			until
				i = index
			loop
				subquery_operators.forth;
				i := i + 1;
			end;
			Result := subquery_operators.item;
		end;

	subqueries: LINKED_LIST [SUBQUERY]
			-- All active subqueries.

	subquery_operators: LINKED_LIST [SUBQUERY_OPERATOR];
			-- All active operators.

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

end -- class PROFILER_QUERY
