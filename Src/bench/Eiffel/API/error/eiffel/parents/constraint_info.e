-- Description of a violation of the constrained genericity validity rule

class CONSTRAINT_INFO 

feature 

	type: GEN_TYPE_A;
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER;
			-- Number of the generic parameter violating the rule

	actual_type, c_type: TYPE_A;
			-- Types involved

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `type1'.
		do
			actual_type := t;
		end;

	set_constraint_type (t: TYPE_A) is
			-- Assign `t' to `type2'.
		do
			c_type := t;
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

	build_explain (error_window: CLICK_WINDOW) is
		require
			type /= Void;
			actual_type /= Void;
			c_type /= Void;
		do
			error_window.put_string ("For type: ");
			type.append_clickable_signature (error_window);
			error_window.put_string ("%NArgument number: ");
			error_window.put_int (formal_number);
			error_window.put_string (":%NActual generic parameter: ");
			actual_type.append_clickable_signature (error_window);
			error_window.put_string ("%NType to which it should conform: ");
			c_type.append_clickable_signature (error_window);
			error_window.new_line;
		end

end
