indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW";
	date: "$Date$";
	revision: "$Revision$"

class ADD_SUBQUERY_CMD 

inherit
	COMMAND
	SHARED_QUERY_VALUES

creation
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
				!! parser;
				if parser.parse (txt, Current) then
					tool.all_subqueries.append (subqueries)
					!! string_arg.make(0)
					string_arg ?= arg
					!! operator.make (string_arg)
					tool.all_operators.extend (operator)
					tool.all_operators.append (subquery_operators)
					tool.update_query_form
					tool.subquery_text.clear
				end

			end
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW

end -- end ADD_SUBQUERY_CMD
