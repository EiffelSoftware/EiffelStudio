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
					io.putstring ("Index must be an integer.%N");
				end;
				if command_arguments.argument_count >= 2 then
					index_str := command_arguments.item (2);
				else
					io.putstring ("--> Subquery index: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
					index_str := command_arguments.item (1);
				end;
				if not index_str.is_integer then
					io.putstring ("Index must be an integer.%N");
					io.putstring ("--> Subquery index: ");
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
					io.putstring ("There is no items available at this index.%N")
				end
			else
				io.putstring ("Index must be valid.%N");
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

end -- class EWB_INACTIVATE_SUBQUERY
