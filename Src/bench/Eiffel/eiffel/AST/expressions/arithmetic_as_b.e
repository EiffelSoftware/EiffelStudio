indexing

	description: "Binary arithmetic operation. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ARITHMETIC_AS_B

inherit

	ARITHMETIC_AS
		rename
			left as old_left,
			right as old_right
		end; 

	BINARY_AS_B
		undefine
			operator_is_keyword, balanced_result,
			balanced, operator_is_special
		redefine
			balanced, balanced_result, operator_is_special,
			operator_is_keyword
		select
			left, right
		end

end -- class ARITHMETIC_AS_B
