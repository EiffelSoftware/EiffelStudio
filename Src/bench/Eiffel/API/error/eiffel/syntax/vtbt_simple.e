indexing
	description: "VTBT error detected at parsing time.";
	date: "$Date$";
	revision: "$Revision$"

class VTBT_SIMPLE

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature -- Property

	code: STRING is "VTBT";
			-- Error code

	value: INTEGER;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if value < 0 then
				st.add_string ("Constant: ");
				st.add_int (value);
				st.add_new_line;
			end;
		end;

feature {COMPILER_EXPORTER}

	set_value (i: INTEGER) is
		do
			value := i;
		end;

end -- class VTBT_SIMPLE
