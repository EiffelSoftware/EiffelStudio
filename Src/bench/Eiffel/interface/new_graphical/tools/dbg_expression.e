indexing
	description: "Objects that represents an expression to evaluate..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	DBG_EXPRESSION

inherit
	DEBUG_OUTPUT
		rename
			debug_output as expression
		end

--create
--	make_with_expression

feature {NONE} -- Initialization

	make_with_expression (new_expr: STRING) is
		do
			syntax_error := False
			error_message := Void
			expression := new_expr
			parse_expression
		end

feature {EB_EXPRESSION} -- Parsing

	set_expression (new_expr: STRING) is
		require
			valid_expression: valid_expression (expression)
		do
			syntax_error := False
			error_message := Void
			expression := new_expr
			parse_expression
--		ensure
--			expression_set: expression = new_expr
		end

	parse_expression is
		require
			valid_expression: valid_expression (expression)
		deferred
		end

feature -- Properties

	expression: STRING
			-- String representation of the like Current.

feature -- Status

	valid_expression (expr: STRING): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void
			if Result then
				Result := not expr.has ('%R') and not expr.has ('%N')
			end
		end

feature -- Access

	syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.

feature {NONE} -- Implementation data

invariant
	valid_expression: valid_expression (expression)

end
