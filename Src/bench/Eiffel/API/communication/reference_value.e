class REFERENCE_VALUE

inherit

	DEBUG_VALUE
		redefine
			set_hector_addr
		end;
	OBJECT_ADDR;
	SHARED_DEBUG;
	CHARACTER_ROUTINES;
	SHARED_SLICE

creation
	make

feature

	append_value (cw: CLICK_WINDOW) is 
		local
			type: CLASS_TYPE;
			class_types: ARRAY [CLASS_TYPE];
			os: OBJECT_STONE;
			class_c: CLASS_C
		do 
			if address = Void then
				cw.put_string ("NONE = Void")
			else
					-- Extra safe test. The dynamic type should be known
					-- from the system, but somehow Dino managed to crash
					-- ebench here. This is very weird!!!
				class_types := System.class_types;
				if class_types.valid_index (dynamic_type + 1) then
					type := class_types.item (dynamic_type + 1)
				end;
				if type /= Void then
					class_c := type.associated_class;
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
			type: CLASS_TYPE;
			class_types: ARRAY [CLASS_TYPE];
			value: STRING;
			value_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER
		do
			if address /= Void then
				address := hector_addr (address);
					-- Extra safe test. The dynamic type should be known
					-- from the system, but somehow Dino managed to crash
					-- ebench here. This is very weird!!!
				class_types := System.class_types;
				if class_types.valid_index (dynamic_type + 1) then
					type := class_types.item (dynamic_type + 1)
				end;
				if 
					type /= Void and then
					type.associated_class.lace_class = System.string_class
				then
					send_rqst_3 (Rqst_inspect, In_string_addr, 0, hex_to_integer (address));
					value := c_tread;
					value_count := value.count;
					!! string_value.make (value_count + 2);
					string_value.extend ('%"');
					from
						value_area := value.area
					until
						i >= value_count or i >= Default_slice
					loop
						string_value.append (char_text (value_area.item (i)));
						i := i + 1
					end;
					string_value.extend ('%"');
					if value_count > Default_slice then
						string_value.append (" ...")
					end
				end
			end
		end;

	string_value: STRING;
			-- Value if the reference object is a STRING

end

