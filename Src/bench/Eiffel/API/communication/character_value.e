class CHARACTER_VALUE

inherit
	
	DEBUG_VALUE;
	CHARACTER_ROUTINES
		undefine
			is_equal
		end

creation {RECV_VALUE, ATTR_REQUEST}

	make, make_attribute

feature {NONE} -- Initialization

	make (v: like value) is
			-- Set `value' to `v'.
		do
			set_default_name;
			value := v
		end;

	make_attribute (attr_name: like name; a_class: like e_class; v: CHARACTER) is
		require
			not_attr_name_void: attr_name /= Void;
		do
			name := attr_name;
			if a_class /= Void then
				is_attribute := True;
				e_class := a_class;
			end;
			value := v
		end;

feature -- Property

	value: CHARACTER;

feature -- Access

	dynamic_class: E_CLASS is
		do
			Result := Eiffel_system.character_class.compiled_eclass
		ensure then
			non_void_result: Result /= Void
		end

feature -- Output

	 append_type_and_value (cw: CLICK_WINDOW) is 
		do 
			dynamic_class.append_clickable_name (cw)
			cw.put_string (" = ");
			cw.put_char ('%'');
			cw.put_string (char_text (value));
			cw.put_char ('%'')
		end;

end -- class CHARACTER_VALUE
