indexing

	description: 
		"Description of a violation of the constrained %
		%genericity validity rule.";
	date: "$Date$";
	revision: "$Revision $"

class CONSTRAINT_INFO 

feature -- Properties

	type: GEN_TYPE_A;
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER;
			-- Number of the generic parameter violating the rule

	actual_type, c_type: TYPE_A;
			-- Types involved

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		require
			actual_type /= Void;
			c_type /= Void;
		do
			ow.put_string ("For type: ");
			type.append_to (ow);
			ow.put_string ("%NArgument number: ");
			ow.put_int (formal_number);
			ow.put_string (":%NActual generic parameter: ");
			actual_type.append_to (ow);
			ow.put_string ("%NType to which it should conform: ");
			c_type.append_to (ow);
			ow.new_line;
		end

feature {COMPILER_EXPORTER} -- Setting

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

end -- class CONSTRAINT_INFO
