indexing
	description: "Binary arithmetic operation. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred
	class ARITHMETIC_AS_B

inherit
	ARITHMETIC_AS
		redefine
			left, right
		end

	BINARY_AS_B
		undefine
			operator_is_keyword, balanced_result,
			balanced, operator_is_special
		redefine
			left, right
		end

feature

	left, right: EXPR_AS_B

end -- class ARITHMETIC_AS_B
