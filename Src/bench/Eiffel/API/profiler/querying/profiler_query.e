class PROFILER_QUERY

feature -- Status setting

	set_subqueries (new_queries: LINKED_LIST [EWB_SUBQUERY]) is
			-- Set `subqueries' to `new_queries'.
		do
			from
				!! subqueries.make;
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

	set_subquery_operators (new_operators: LINKED_LIST [EWB_SUBQUERY_OPERATOR]) is
			-- Set `subquery_operators' to `new_operators'.
		do
			from
				!! subquery_operators.make;
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

feature -- Status report

	subquery_at (index: INTEGER): EWB_SUBQUERY is
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

	operator_at (index: INTEGER): EWB_SUBQUERY_OPERATOR is
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

	subqueries: LINKED_LIST [EWB_SUBQUERY]
			-- All active subqueries.

	subquery_operators: LINKED_LIST [EWB_SUBQUERY_OPERATOR]
			-- All active operators.

end -- class PROFILER_QUERY
