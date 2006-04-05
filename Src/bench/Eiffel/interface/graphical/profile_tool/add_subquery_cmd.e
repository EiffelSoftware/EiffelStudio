indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ADD_SUBQUERY_CMD 

inherit
	COMMAND
	SHARED_QUERY_VALUES

create
	make

feature -- Initialization

	make (a_tool: PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		end

feature -- Command Execution

	execute (arg: ANY) is
			-- Execute Current
		local
			parser: QUERY_PARSER;
			txt: STRING;
			operator: SUBQUERY_OPERATOR
			string_arg: STRING
		do
			txt := tool.subquery
			if txt /= Void and then not txt.is_empty then 
				clear_values;
				create parser;
				if parser.parse (txt, Current) then
					tool.all_subqueries.append (subqueries)
					create string_arg.make(0)
					string_arg ?= arg
					create operator.make (string_arg)
					tool.all_operators.extend (operator)
					tool.all_operators.append (subquery_operators)
					tool.update_query_form
					tool.subquery_text.clear
				end

			end
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW;

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

end -- end ADD_SUBQUERY_CMD
