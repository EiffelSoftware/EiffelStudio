-- Description of a violation of the constrained genericity validity rule

class CONSTRAINT_INFO 

inherit

	WINDOWS

feature 

	type: GEN_TYPE_A;
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER;
			-- Number of the generic parameter violating the rule

	type1, type2: TYPE_A;
			-- Types involved: `type1' doesn't conform to `type2'.

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

	set_type (t: GEN_TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_formal_number (i: INTEGER) is
			-- Assign `i' to `formal_number'.
		do
			formal_number := i;
		end;

	build_explain is
		require
			type /= Void;
			type1 /= Void;
			type2 /= Void;
		do
			error_window.put_string (type.dump);
			error_window.put_string (" [");
			error_window.put_int (formal_number);
			error_window.put_string ("]: ");
			error_window.put_string (type1.dump);
			error_window.put_string (" doesn't conform to ");
			error_window.put_string (type2.dump);
			error_window.new_line;
		end

end
