indexing

	description: 
		"Error for a non-boolean expression.";
	date: "$Date$";
	revision: "$Revision $"

deferred class VWBE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature -- Properties

	code: STRING is "VWBE";
			-- Error code

	type: TYPE_A;

	where: STRING is
		deferred
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string (where);
			st.add_new_line;
			st.add_string ("Expression type: ");
			type.append_to (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

end -- class VWBE
