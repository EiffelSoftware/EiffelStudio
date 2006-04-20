indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

end -- class EWB_SHOW_SUBQUERIES
