indexing
	description: "Objects that represents an expression to evaluate..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"


class
	DBG_EXPRESSION_B

inherit
	DBG_EXPRESSION

create
	make_with_expression

feature -- Parsing

	parse_expression is
		local
			sp: SHARED_EIFFEL_PARSER
			p: EIFFEL_PARSER
			retried: BOOLEAN
		do
			if not retried then
				create sp
				p := sp.expression_parser
				p.parse_from_string ("feature " + expression)
				expression_ast ?= p.expression_node
				check
					expression_ast /= Void
				end
			else
				debug ("debugger_evaluator")
					io.error.put_string ("Error in DB_EXPRESSION.parse_expression %N")
					io.error.put_string (p.error_message + "%N")
				end
				syntax_error := True
				error_message := p.error_message
			end
		rescue
			retried := True
			retry
		end

feature -- properties

	expression_ast: EXPR_AS

end
