indexing

	description: 
		"Error when the creation type of an instruction %
		%is a formal generic parameter.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC1 

inherit

	VGCC
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 1
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build the error message
		do
			st.add_string ("Creation of: ");
			st.add_string (target_name);
			st.add_new_line;
		end

end -- class VGCC1
