class EWB_SHOW_SUBQUERIES

inherit
	EWB_QUERY

feature {NONE} -- Execution

	execute is
		do
			show_all_subqueries;
			show_active_total_query;
		end;

feature {NONE} -- Implementation

	show_all_subqueries is
		local
			i: INTEGER;
		do
			from
				io.putstring ("All subqueries:%N");
				subqueries.start;
				i := 1;
			until
				subqueries.after
			loop
				io.putchar ('[');
				io.putint (i);
				io.putstring ("] ");
				io.putstring (subqueries.item.column);
				io.putchar (' ');
				io.putstring (subqueries.item.operator);
				io.putchar (' ');
				io.putstring (subqueries.item.value);
				io.putstring (" is ");
				if subqueries.item.is_active then
					io.putstring ("active");
				else
					io.putstring ("inactive");
				end;
				io.putchar ('%N');
				i := i + 1;
				subqueries.forth;
			end;
		end;

	show_active_total_query is
		do
			from
				io.putstring ("%NThe total active query:%N");
				subqueries.start;
				subquery_operators.start;
			until
				subqueries.after
			loop
				if subqueries.item.is_active then
					io.putstring (subqueries.item.column);
					io.putchar (' ');
					io.putstring (subqueries.item.operator);
					io.putchar (' ');
					io.putstring (subqueries.item.value);
					if not subquery_operators.after then
						if subquery_operators.item.is_active then
							io.putchar (' ');
							io.putstring (subquery_operators.item.actual_operator);
						end;
					end;
					io.putchar ('%N');
				end;
				subqueries.forth;
				if not subquery_operators.after then
					subquery_operators.forth;
				end;
			end;
		end;

feature -- Properties

	name: STRING is
		once
			Result := show_subqueries_cmd_name;
		end;

	help_message: STRING is
		once
			Result := show_subqueries_help;
		end;

	abbreviation: CHARACTER is
		once
			Result := show_subqueries_abb;
		end;

end -- class EWB_SHOW_SUBQUERIES
