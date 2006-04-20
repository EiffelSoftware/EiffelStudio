indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EWB_INACTIVATE_SUBQUERY

inherit
	EWB_QUERY
		redefine
			loop_action
		end;

feature {NONE} -- Execution

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS;
			index_str: STRING;
			first_time: BOOLEAN
		do
			command_arguments := command_line_io.command_arguments;
			from
				index_str := "a";
					-- Fancy string for until-clause
				first_time := true;
			until
				index_str.is_integer
			loop
				if not first_time then
					io.put_string ("Index must be an integer.%N");
				end;
				if command_arguments.argument_count >= 2 then
					index_str := command_arguments.item (2);
				else
					io.put_string ("--> Subquery index: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					index_str := command_arguments.item (1);
				end;
				if not index_str.is_integer then
					io.put_string ("Index must be an integer.%N");
					io.put_string ("--> Subquery index: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					index_str := command_arguments.item (1);
				end;
				first_time := false;
			end;
			index := index_str.to_integer;
			execute;
		end;

	execute is
		do
			if index <= subqueries.count then
				subqueries.go_i_th (index);
				if not subqueries.off and then subqueries.item /= Void then
					subqueries.item.inactivate;
					from
					until
						subqueries.after or else subqueries.item.is_active
					loop
						subqueries.forth;
					end;
					if subqueries.after then
						from
							subquery_operators.finish;
						until
							subquery_operators.before or else 
								subquery_operators.item.is_active
						loop
							subquery_operators.back;
						end;
						if not subquery_operators.before then
							subquery_operators.item.inactivate;
						end;
					else
						if index <= subquery_operators.count then
							subquery_operators.go_i_th (index);
							subquery_operators.item.inactivate;
						end;
					end;
				else
					io.put_string ("There is no items available at this index.%N")
				end
			else
				io.put_string ("Index must be valid.%N");
			end;
		end;

feature -- Properties

	name: STRING is
		once
			Result := inactivate_subquery_cmd_name;
		end;

	help_message: STRING is
		once
			Result := inactivate_subquery_help;
		end;

	abbreviation: CHARACTER is
		once
			Result := inactivate_subquery_abb;
		end;

feature {NONE} -- Attributes

	index: INTEGER;

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

end -- class EWB_INACTIVATE_SUBQUERY
