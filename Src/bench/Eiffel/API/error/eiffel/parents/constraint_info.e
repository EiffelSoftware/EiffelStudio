indexing
	description: "Description of a violation of the constrained %
				%genericity validity rule."
	date: "$Date$"
	revision: "$Revision $"

class CONSTRAINT_INFO 

feature -- Properties

	type: GEN_TYPE_A
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER
			-- Number of the generic parameter violating the rule

	actual_type, c_type: TYPE_A
			-- Types involved

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		require
			actual_type /= Void
			c_type /= Void
		do
			st.add_string ("For type: ")
			type.append_to (st)
			st.add_new_line
			st.add_string ("Argument number: ")
			st.add_int (formal_number)
			st.add_string (":")
			st.add_new_line
			st.add_string ("Actual generic parameter: ")
			actual_type.append_to (st)
			st.add_new_line
			st.add_string ("Type to which it should conform: ")
			c_type.append_to (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `type1'.
		do
			actual_type := t
		end

	set_constraint_type (t: TYPE_A) is
			-- Assign `t' to `type2'.
		do
			c_type := t
		end

	set_type (t: GEN_TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_formal_number (i: INTEGER) is
			-- Assign `i' to `formal_number'.
		do
			formal_number := i
		end

end -- class CONSTRAINT_INFO
