-- Error for a feature call: type mismatch one one argument

class VUAR2 

inherit

	VUAR
		rename
			build_explain as old_build_explain
		redefine
			code
		end;
	
	VUAR
		redefine
			build_explain, code
		select
			build_explain
		end

feature 

	code: STRING is "VUAR2";

	argument_name: STRING;
			-- Name of the involved argument

	formal_type: TYPE_A;
			-- Formal type of the argument

	actual_type: TYPE_A;
			-- Actual type of the call

	set_argument_name (n: STRING) is
			-- Assign `n' to `argument_name'.
		do
			argument_name := n;
		end;

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%T%Ttarget ");
			a_clickable.put_string (formal_type.dump);
			a_clickable.put_string ("%T%Tsource	");
			a_clickable.put_string (actual_type.dump);
			a_clickable.put_string ("%T%Tfor argument `");
			a_clickable.put_string (argument_name);
			a_clickable.put_string ("'%N")
		end;

end
		
