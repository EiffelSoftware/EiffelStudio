indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EWB_CHANGE_OPERATOR

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
			not_first: BOOLEAN;
		do
			command_arguments := command_line_io.command_arguments;
			from
				index_str := "a";
					-- Fancy string for until-clause.
			until
				index_str.is_integer
				and (new_operator.is_equal ("and") or new_operator.is_equal ("or"))
			loop
				if command_arguments.argument_count >= 3 and not not_first then
					index_str := command_arguments.item (2);
					new_operator := command_arguments.item (3);
					new_operator.to_lower
				else
					if not not_first then
						from
							io.put_string ("--> Operator index followed by operator ('and' or 'or'): ");
							command_line_io.get_name;
							command_arguments := command_line_io.command_arguments;
						until
							command_arguments.argument_count = 2
						loop
							io.put_string ("--> Please enter an operator index followed by an operator ('and' or 'or'): ");
							command_line_io.get_name;
							command_arguments := command_line_io.command_arguments;
						end;
						index_str := command_arguments.item (1);
						new_operator := command_arguments.item (2);
					end;
				end;
					-- Check index
				if not index_str.is_integer then
					io.put_string ("Index must be an integer.%N");
					io.put_string ("--> Operator index: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					index_str := command_arguments.item (1);
				end;
					-- Check operator
				if not (new_operator.is_equal ("and") or else new_operator.is_equal ("or")) then
					io.put_string ("Operator must be 'and' or 'or'.%N");
					io.put_string ("--> New operator: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					new_operator := command_arguments.item (1);
				end;
				not_first := true;
			end;
			index := index_str.to_integer;
			execute;
		end;

	execute is
		do
			if index <= subquery_operators.count then
				subquery_operators.go_i_th (index);
				if not subquery_operators.off and then subquery_operators.item /= Void then
					subquery_operators.item.change_operator (new_operator);
				else
					io.put_string ("There is no items available at this index.%N")
				end
			else
				io.put_string ("Index must be valid.%N");
			end;
		end;

feature -- Porperties

	name: STRING is
		once
			Result := change_operator_cmd_name;
		end;

	help_message: STRING is
		once
			Result := change_operator_help;
		end;

	abbreviation: CHARACTER is
		once
			Result := change_operator_abb;
		end;

feature {NONE} -- Attributes

	index: INTEGER;

	new_operator: STRING;;

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

end -- class EWB_CHANGE_OPERATOR
