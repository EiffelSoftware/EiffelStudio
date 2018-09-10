note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_ASSERT

inherit

	IV_STATEMENT

	IV_ASSERTION

create
	make, make_assume

feature {NONE} -- Initialization

	make_assume (a_expression: like expression)
			-- Create "assume a_expression".
		require
			a_expression_attached: attached a_expression
			boolean_expression: a_expression.type.is_boolean
		do
			make (a_expression)
			is_free := True
		ensure
			expression_set: expression = a_expression
			is_assume: is_free
		end

feature -- Status report

	is_free: BOOLEAN
			-- Is this assert actually an assume?

feature -- Status setting

	set_free (a_is_free: BOOLEAN)
			-- Set `is_free' to `a_is_free'.
		do
			is_free := a_is_free
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			if is_free then
				a_visitor.process_assume (Current)
			else
				a_visitor.process_assert (Current)
			end
		end

end
