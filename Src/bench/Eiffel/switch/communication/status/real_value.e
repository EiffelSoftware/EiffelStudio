indexing

	description: 
		"Run time value representing of a real";
	date: "$Date$";
	revision: "$Revision $"

class REAL_VALUE

inherit

	DEBUG_VALUE

creation {RECV_VALUE, ATTR_REQUEST}

	make, make_attribute

feature {NONE} -- Implementation

	make (v: like value) is
			-- Set `value' to `v'.
		do
			set_default_name;
			value := v
		end;

	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
		require
			not_attr_name_void: attr_name /= Void;
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			value := v
		end;

feature -- Property

	value: REAL;

feature -- Access

	dynamic_class: CLASS_C is
		do
			Result := Eiffel_system.real_class.compiled_class
		ensure then
			non_void_result: Result /= Void
		end

feature -- Output

	 append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			dynamic_class.append_name (st)
			st.add_string (" = ");
			st.add_string (value.out)
		end;

end -- class REAL_VALUE
