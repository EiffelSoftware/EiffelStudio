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
				io.put_string ("All subqueries:%N");
				subqueries.start;
				i := 1;
			until
				subqueries.after
			loop
				io.put_character ('[');
				io.put_integer (i);
				io.put_string ("] ");
				io.put_string (subqueries.item.column);
				io.put_character (' ');
				io.put_string (subqueries.item.operator);
				io.put_character (' ');
				io.put_string (subqueries.item.value);
				io.put_string (" is ");
				if subqueries.item.is_active then
					io.put_string ("active");
				else
					io.put_string ("inactive");
				end;
				io.put_character ('%N');
				i := i + 1;
				subqueries.forth;
			end;
		end;

	show_active_total_query is
		do
			from
				io.put_string ("%NThe total active query:%N");
				subqueries.start;
				subquery_operators.start;
			until
				subqueries.after
			loop
				if subqueries.item.is_active then
					io.put_string (subqueries.item.column);
					io.put_character (' ');
					io.put_string (subqueries.item.operator);
					io.put_character (' ');
					io.put_string (subqueries.item.value);
					if not subquery_operators.after then
						if subquery_operators.item.is_active then
							io.put_character (' ');
							io.put_string (subquery_operators.item.actual_operator);
						end;
					end;
					io.put_character ('%N');
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
