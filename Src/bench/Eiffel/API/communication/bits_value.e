class BITS_VALUE

inherit

	DEBUG_VALUE
		rename
			set_hector_addr as get_value
		redefine
			get_value
		end;
	DEBUG_EXT;
	IPC_SHARED;
	BEURK_HEXER

creation
	make

feature

	get_value is
			-- Convert the physical address of the bit reference to
			-- its actual value. (should be called only once just after
			-- all the information has been received from the application.)
		do
			send_rqst_3 (Rqst_inspect, In_bit_addr, 0, hex_to_integer (value));
			value := clone (c_tread)
		end;
	
	append_value (cw: CLICK_WINDOW) is 
		do 
			cw.put_string ("BIT ");
			cw.put_int (value.count - 1);
			cw.put_string (" = ");
			cw.put_string (value)
		end;

	value: STRING;
			-- Physical address of the bit object or its actual value
			-- after calling `get_value'

	make (ref: POINTER; s: INTEGER) is
		do
			--| `s' is supposed to be the size, but it does not work.
			--| It is then computed from the bit value.
			value := ref.out
		end

end

