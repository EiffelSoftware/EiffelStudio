class BITS_VALUE

inherit

	DEBUG_VALUE;
	DEBUG_EXT;
	IPC_SHARED;
	BEURK_HEXER

creation
	make

feature

	append_value (cw: CLICK_WINDOW) is 
		do 
			cw.put_string ("BIT");
			send_rqst_3 (Rqst_inspect, In_bit_addr, 0, hex_to_integer (addr));
			cw.put_string (" = ");
			cw.put_string (clone (c_tread));
			cw.new_line
			
		end;

	addr: STRING;
			-- Physical address of the bit object

	size: INTEGER;

	make (ref: POINTER; s: like size) is
		do
			addr := ref.out;
			size := s;
		end

end

