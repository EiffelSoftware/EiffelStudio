indexing

	description: 
		"Run time value representing a pointer.";
	date: "$Date$";
	revision: "$Revision $"

class POINTER_VALUE

inherit

	DEBUG_VALUE

creation {RECV_VALUE, ATTR_REQUEST}

	make, make_attribute

feature {NONE} -- Initialization

	make (v: POINTER) is
			-- Set `value' to `v'.
		do
			set_default_name;
			value := v.out
		end;

	make_attribute (attr_name: like name; a_class: like e_class; addr: like value) is
		require
			not_attr_name_void: attr_name /= Void;
			not_addr_void: addr/= Void
		do
			name := attr_name;
			if a_class /= Void then
				is_attribute := True;
				e_class := a_class;
			end;
			value := addr
		end;

feature -- Property

	value: STRING;
			-- Address of the pointer

feature -- Access

	dynamic_class: CLASS_C is
		do
			Result := Eiffel_system.pointer_class.compiled_class
		ensure then
			non_void_result: Result /= Void
		end

feature -- Output

	 append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			dynamic_class.append_name (st)
			st.add_string (" = C pointer ");
			st.add_string (value)
		end;

end -- class POINTER_VALUE
