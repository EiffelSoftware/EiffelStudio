indexing

	description: 
		"Error when feature type is an invalid anchored type.";
	date: "$Date$";
	revision: "$Revision $"

class VTAT1R 

inherit

	VTAT1
		rename
			build_explain as old_build_explain
		end;
	VTAT1
		redefine
			build_explain
		select
			build_explain
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Anchor name: Result");
			st.add_new_line;
			old_build_explain (st);
		end;

end -- class VTAT1R
