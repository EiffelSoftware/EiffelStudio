indexing

	description:
		"Command to change subquery operators of PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ADD_SUBQUERY_CMD 

inherit
	EV_COMMAND
	SHARED_QUERY_VALUES

creation
	make

feature {NONE} -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		end


feature -- Command Execution

	execute (arg: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Execute Current
		local
			parser: QUERY_PARSER
			txt: STRING
			operator: SUBQUERY_OPERATOR
			string_arg: STRING
		do
			txt := query_window.subquery
			if txt /= Void and then not txt.empty then 
				clear_values
				create parser
				if parser.parse (txt, Current) then
					query_window.all_subqueries.append (subqueries)
					create string_arg.make(0)
					string_arg ?= arg.first
					create operator.make (string_arg)
					query_window.all_operators.extend (operator)
					query_window.all_operators.append (subquery_operators)
					query_window.update_query_form
					query_window.subquery_text.set_text ("")
				end

			end
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- class EB_ADD_SUBQUERY_CMD
