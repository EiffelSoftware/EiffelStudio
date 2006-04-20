indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EWB_ADD_SUBQUERY

inherit
	EWB_QUERY
		redefine
			loop_action
		end

feature {NONE} -- Execute

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS
			query_parser: QUERY_PARSER
		do
			command_arguments := command_line_io.command_arguments
			if command_arguments.argument_count >= 4 then
				create subquery.make (command_arguments.item (2), command_arguments.item (3), command_arguments.item (4))
			else
				extra_help
				from
					io.put_string ("--> Subquery: ")
					command_line_io.get_name
					command_arguments := command_line_io.command_arguments;
					create query_parser
				until
					command_arguments.argument_count = 3 and then query_parser.parse (query_string (command_arguments), Current)
						--| Guillaume - 09/26/97
				loop
					io.put_string ("--> Subquery: ")
					command_line_io.get_name
					command_arguments := command_line_io.command_arguments
				end
				-- create subquery.make (command_arguments.item (1), command_arguments.item (2), command_arguments.item (3)); --| Done in query_parser.parse
			end
			execute
		end

	execute is
		local
			sq_op: SUBQUERY_OPERATOR
		do
			-- subqueries.extend (subquery); --| Done in query_parser.parse
			if subqueries.count > 1 then
				create sq_op.make ("and");
				subquery_operators.extend (sq_op);
				from
					subqueries.finish;
				until
					subqueries.before or not subqueries.item.is_active
				loop
					subqueries.back;
				end;
				if not subqueries.before then
					from
						subquery_operators.go_i_th (subqueries.index);
						subquery_operators.item.inactivate;
					until
						subqueries.before or subqueries.item.is_active
					loop
						subqueries.back;
					end;
					if not subqueries.before then
						subquery_operators.go_i_th (subqueries.index);
						subquery_operators.item.activate;
					end;
				end;
			end;
		end;

feature -- Properties

	name: STRING is
		once
			Result := add_subquery_cmd_name;
		end;

	help_message: STRING is
		once
			Result := add_subquery_help;
		end;

	abbreviation: CHARACTER is
		once
			Result := add_subquery_abb;
		end;

feature {NONE} -- Implementation

	query_string (command_arguments: EWB_ARGUMENTS): STRING is
		local
			i : INTEGER
		do
			from
				i := 1
				create Result.make (0)
			until
				i > command_arguments.argument_count
			loop
				Result.append (command_arguments.entry (i))
				Result.extend (' ')
				i := i + 1
			end
		end

	extra_help is
			-- Prints some extra help on this command.
		do
			io.put_string ("A subquery has the following form: ");
			io.put_string ("attribute operator value%N%N");
			io.put_string ("attribute is one of: featurename, calls, total, self, descendants, percentage%N");
			io.put_string ("operator is one of: < > <= >= = /= in%N");
			io.put_string ("value is one of: integer (for calls), string_with_wildcards (for featurename)%N");
			io.put_string ("%T%T real (for other attributes) or a bounded_value%N");
			io.put_string ("%T%T%TA string_with_wildcards is a string containing%N%T%T%T'*' or '?'%N");
			io.put_string ("%T%T%TA bounded_value is a value followed by '-' followed by%N%T%T%Ta value%N");
			io.put_string ("%T%T%T%TNo strings are allowed here.%N");
		end;

feature {NONE} -- Attributes

	subquery: SUBQUERY;

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

end -- class EWB_ADD_SUBQUERY
