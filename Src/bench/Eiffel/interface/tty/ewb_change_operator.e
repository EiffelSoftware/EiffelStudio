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
							io.putstring ("--> Operator index followed by operator ('and' or 'or'): ");
							command_line_io.get_name;
							command_arguments := command_line_io.command_arguments;
						until
							command_arguments.argument_count = 2
						loop
							io.putstring ("--> Please enter an operator index followed by an operator ('and' or 'or'): ");
							command_line_io.get_name;
							command_arguments := command_line_io.command_arguments;
						end;
						index_str := command_arguments.item (1);
						new_operator := command_arguments.item (2);
					end;
				end;
					-- Check index
				if not index_str.is_integer then
					io.putstring ("Index must be an integer.%N");
					io.putstring ("--> Operator index: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					index_str := command_arguments.item (1);
				end;
					-- Check operator
				if not (new_operator.is_equal ("and") or else new_operator.is_equal ("or")) then
					io.putstring ("Operator must be 'and' or 'or'.%N");
					io.putstring ("--> New operator: ");
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
					io.putstring ("There is no items available at this index.%N")
				end
			else
				io.putstring ("Index must be valid.%N");
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

	new_operator: STRING;

end -- class EWB_CHANGE_OPERATOR
