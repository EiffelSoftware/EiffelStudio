class REFERENCE_VALUE

inherit

	DEBUG_VALUE
		redefine
			set_hector_addr
		end;
	OBJECT_ADDR;
	SHARED_DEBUG;
	CHARACTER_ROUTINES

creation
	make

feature

	append_value (cw: CLICK_WINDOW) is 
		local
			os: OBJECT_STONE;
			class_c: CLASS_C
		do 
			if address = Void then
				cw.put_string (" Void")
			else
				class_c := System.class_types.item (dynamic_type + 1).associated_class;
				class_c.append_clickable_name (cw);
				cw.put_string (" [");
				if Run_info.is_running and Run_info.is_stopped then
					!! os.make (address, class_c);
					cw.put_clickable_string (os, address)
				else
					cw.put_string (address)
				end;
				cw.put_string ("]");
				if string_value /= Void then
					cw.put_string (" = ");
					cw.put_string (string_value)
				end
			end
		end;

	address: STRING;
			-- Address of referenced object (Void if no object)

	dynamic_type: INTEGER;

	make (reference: POINTER; type: like dynamic_type) is
		local
			void_pointer: POINTER
		do
			if reference /= void_pointer then
				address := reference.out
			end;
			dynamic_type := type;
		end;

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
			-- If referenced object is a STRING, get its value.
		local
			value: STRING;
			i: INTEGER
		do
			if address /= Void then
				address := hector_addr (address);
				if System.class_types.item (dynamic_type + 1).associated_class.lace_class = System.string_class then
					send_rqst_3 (Rqst_inspect, In_string_addr, 0, hex_to_integer (address));
					value := clone (c_tread);
					!! string_value.make (value.count + 2);
					string_value.extend ('%"');
					from
						i := 1;
					until
						i > value.count
					loop
						string_value.append (char_text (value.item (i)));
						i := i + 1
					end;
					string_value.extend ('%"')
				end
			end
		end;

	string_value: STRING;
			-- Value if the reference object is a STRING

end

