indexing

	description: 
		"Run time value representing of reference object.";
	date: "$Date$";
	revision: "$Revision $"

class REFERENCE_VALUE

inherit

	ABSTRACT_DEBUG_VALUE
		redefine
			set_hector_addr, address
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

	SHARED_DEBUG
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
		do
			name := attr_name;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			dynamic_type_id := type;
			address := addr
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

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_object (address, dynamic_class)
		end

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

	append_value (st: STRUCTURED_TEXT) is 
		local
			ec: CLASS_C;
			status: APPLICATION_STATUS
		do 
			if address = Void then
				st.add_string ("Void")
			else
				ec := dynamic_class;
				if ec /= Void then
					st.add_string ("[");
					status := Application.status;
					if status /= Void and status.is_stopped then
						st.add_address (address, name, ec)
					else
						st.add_string (address)
					end;
					st.add_string ("]");
					if string_value /= Void then
						st.add_new_line
						st.add_string (string_value)
					end
				else
					Any_class.append_name (st);
					st.add_string ("Unknown")
				end
			end
		end;

	type_and_value: STRING is
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
			str: STRING
		do
			if address = Void then
				Result := NONE_representation
			else
				ec := dynamic_class;
				if ec /= Void then
					create Result.make (60)
					Result.append (ec.name_in_upper)
					Result.append (Left_square_bracket)
					Result.append (address)
					Result.append (Right_square_bracket)
					str := string_value
					if str /= Void then
						Result.append (Equal_sign_str)
						Result.append (str)
					end
				else
					create Result.make (20)
					Result.append (Any_class.name_in_upper)
					Result.append (Is_unknown)
				end
			end
		end

	NONE_representation: STRING is "NONE = Void"

	Left_square_bracket: STRING is " ["

	Right_square_bracket: STRING is "]"

	Equal_sign_str: STRING is " = "

	Is_unknown: STRING is " = Unknown"

	output_value: STRING is
			-- Return a string representing `Current'.
		do
			if address = Void then
				Result := "Void"
			else
				Result := "[" + address + "]"
				if string_value /= Void then
					Result.append (" = " + string_value)
				end
			end
		end

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result := address /= Void
		end

	children: LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		local
			obj: DEBUGGED_OBJECT
		do
			create obj.make (address, min_slice, max_slice)
			Result := obj.attributes
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if address /= Void then
				Result := Reference_value
			else
				Result := Void_value
			end
		end

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

	min_slice: INTEGER is
			-- From which attribute number should special objects be displayed?
		do
			Result := min_slice_ref.item
		end

	max_slice: INTEGER is
			-- Up to which attribute number should special objects be displayed?
		do
			Result := max_slice_ref.item
		end

	dynamic_type_id: INTEGER;
			-- Dynamic type id of return type

	private_dynamic_class: CLASS_C
			-- Saved class 

end -- class REFERENCE_VALUE
