indexing
	description: "Error when the Ace file is empty.(NOT DEFINED IN THE ETL)"
	date: "$Date$"
	revision: "$Revision$"

class VD54

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Empty Ace file");
			st.add_new_line
		end;

end -- class VD54
