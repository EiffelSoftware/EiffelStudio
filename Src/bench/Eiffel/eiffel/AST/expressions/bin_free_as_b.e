indexing

	description: "Free binary expression description. Version for Bench";
	date: "$Date$";
	revision: "$Revision$"

class BIN_FREE_AS_B

inherit

	BIN_FREE_AS
		rename
			left as old_free_left,
			right as old_free_right
		redefine
			op_name, set_infix_function_name
		end;

	BINARY_AS_B
		undefine
			set, operator_is_keyword
		select
			left, right
		end

feature -- Attributes

	op_name: ID_AS_B;
			-- Free operator name

feature

	byte_anchor: BIN_FREE_B is
			-- Byte code type
		do
			!!Result
		end;

feature {BINARY_AS_B}

	set_infix_function_name (name: ID_AS_B) is
		do
			op_name := clone (name)
			op_name.tail (op_name.count - 7);
			-- 7 = "_infix_".count
		end;

end -- class BIN_FREE_AS_B
