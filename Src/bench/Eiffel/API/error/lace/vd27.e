indexing

	description: 
		"Error when root creation procedure name is not valid.";
	date: "$Date$";
	revision: "$Revision $"

class VD27

inherit

	LACE_ERROR

feature -- Properties

	creation_routine: STRING;
			-- Error creation routine 

	root_class: CLASS_C;
			-- Root class

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Root class: ");
			root_class.append_name (st);
			st.add_new_line;
			st.add_string ("Invalid procedure name: ");
			st.add_string (creation_routine);
			st.add_new_line
		end;

feature {CLASS_C} -- Setting

	set_creation_routine (a_name: STRING) is
		do
			creation_routine := a_name;
		end;

	set_root_class (a_class: like root_class) is
		do
			root_class := a_class;
		end;

end -- class VD27
