indexing

	description: 
		"Run time value representing of reference object.";
	date: "$Date$";
	revision: "$Revision $"

class REFERENCE_VALUE

inherit

	DEBUG_VALUE
		redefine
			set_hector_addr
		end;
	OBJECT_ADDR
		undefine
			is_equal
		end;
	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal
		end;
	CHARACTER_ROUTINES
		undefine
			is_equal
		end;

creation {RECV_VALUE, ATTR_REQUEST}

	make, make_attribute

feature {NONE} -- Initialization

	make (reference: POINTER; id: like dynamic_type_id) is
			-- Set `address' to `reference' address
			-- and `dynamic_type_id' to `id'.
		local
			void_pointer: POINTER
		do
			set_default_name;
			if reference /= Void_pointer then
				address := reference.out
			end;
			dynamic_type_id := id;
		end;

	make_attribute (attr_name: like name; a_class: like e_class;
						type: like dynamic_type_id; addr: like address) is
		require
			not_attr_name_void: attr_name /= Void;
			not_addr_void: addr /= Void
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			dynamic_type_id := type;
			if not addr.is_equal ("Void") then
				address := addr
			end
		end;

feature -- Properties

	address: STRING;
			-- Address of referenced object (Void if no object)

	string_value: STRING;
			-- Value if the reference object is a STRING

feature -- Access

	dynamic_class: CLASS_C is
		do
			Result := private_dynamic_class;
			if Result = Void then
				if Eiffel_system.valid_dynamic_id (dynamic_type_id) then
					--| Extra safe test. The dynamic type should be known
					--| from the system, but somehow Dino managed to crash
					--| ebench here. This is very weird!!!
					Result := Eiffel_system.class_of_dynamic_id (dynamic_type_id)
					private_dynamic_class := Result
				end
			end;
		end;

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		local
			ec: CLASS_C;
			status: APPLICATION_STATUS
		do 
			if address = Void then
				st.add_string ("NONE = Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					ec.append_name (st);
					st.add_string (" [");
					status := Application.status;
					if status /= Void and status.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string ("]");
					if string_value /= Void then
						st.add_string (" = ");
						st.add_string (string_value)
					end
				else
					Any_class.append_name (st);
					st.add_string (" = Unknown")
				end
			end
		end;

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
			-- If referenced object is a STRING, get its value.
		local
			ec: CLASS_C;
			value: STRING;
			value_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER
		do
			if address /= Void then
				address := hector_addr (address);
				ec := dynamic_class;
				if 
					ec /= Void and then
					ec.lace_class = Eiffel_system.string_class
				then
					send_rqst_3 (Rqst_inspect, In_string_addr, 0, hex_to_integer (address));
					value := c_tread;
					value_count := value.count;
					!! string_value.make (value_count + 2);
					string_value.extend ('%"');
					from
						value_area := value.area
					until
						i >= value_count or i >= Application.displayed_string_size
					loop
						string_value.append (char_text (value_area.item (i)));
						i := i + 1
					end;
					string_value.extend ('%"');
					if value_count > Application.displayed_string_size then
						string_value.append (" ...")
					end
				end
			end
		end;

feature {NONE} -- Property

	dynamic_type_id: INTEGER;
			-- Dynamic type id of return type

	private_dynamic_class: CLASS_C
			-- Saved class 

end -- class REFERENCE_VALUE
