indexing

	description: "Binary comparison operation. Version for Bench";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARISON_AS_B

inherit

	COMPARISON_AS
		redefine
			left, right
		end;

	BINARY_AS_B
		undefine
			balanced, operator_is_special, operator_is_keyword
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

end -- class COMPARISON_AS_B
