-- Error for unvalid equality

class VWEQ 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature 

	type1: TYPE_A;
			-- Left type of the equality

	type2: TYPE_A;
			-- Right type of the equality

	node: BIN_EQ_AS;
			-- Involved AS node

	set_type1 (t: TYPE_A) is
			-- Assign `t' to `type1'.
		do
			type1 := t;
		end;

	set_type2 (t: TYPE_A) is
			-- Assign `t' to `type2'.
		do
			type2 := t;
		end;

	set_node (n: BIN_EQ_AS) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	code: STRING is "VWEQ";
			-- Error code

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("%Ttype1 = ");
			put_string (type1.dump);
			put_string ("%N%Ttype2 = ");
			put_string (type2.dump);
			new_line
		end

end
