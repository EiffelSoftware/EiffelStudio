indexing

	description: "Binary comparison operation. Version for Bench";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARISON_AS_B

inherit

	COMPARISON_AS
		rename
			left as old_left,
			right as old_right
		end;

	BINARY_AS_B
		undefine
			balanced, operator_is_special, operator_is_keyword
		select
			left, right
		end

feature

end -- class COMPARISON_AS_B
