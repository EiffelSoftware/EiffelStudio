-- Error for unvalid equality

class VWEQ 

inherit

	FEATURE_ERROR
		rename
			build_explain as old_build_explain
		end;

	FEATURE_ERROR
		redefine
			build_explain
		select
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

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Ttype1 = ");
			a_clickable.put_string (type1.dump);
			a_clickable.put_string ("%N%Ttype2 = ");
			a_clickable.put_string (type2.dump);
			a_clickable.put_string ("%N")
		end

end
