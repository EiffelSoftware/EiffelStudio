-- External routines for debugging
-- run-time counterpart: /C/ipc/ewb/eif_out.c

class DEBUG_EXT

feature

	send_rqst_0 (code: INTEGER) is
		external
			"C"
		end;

	send_rqst_1 (code: INTEGER; info1: INTEGER) is
		external
			"C"
		end;

	send_rqst_2 (code: INTEGER; info1: INTEGER; info2: INTEGER) is
		external
			"C"
		end;

	send_rqst_3 (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: INTEGER) is
		external
			"C"
		end;

	send_integer_value (value: INTEGER) is
		external
			"C"
		end

	send_real_value (value: REAL) is
		external
			"C"
		end

	send_double_value (value: DOUBLE) is
		external
			"C"
		end

	send_char_value (value: CHARACTER) is
		external
			"C"
		end

	send_bool_value (value: BOOLEAN) is
		external
			"C"
		end

	send_ptr_value (value: POINTER) is
			-- value is the value of the pointer
		external
			"C"
		end

	send_string_value (value: POINTER) is
			-- value is the address of a C string
		external
			"C"
		end

	send_ref_value (value: INTEGER) is
			-- value is the address of the object
		external
			"C"
		end

	recv_ack: BOOLEAN is
		external
			"C"
		end;

	recv_dead: BOOLEAN is
		external
			"C"
		end;

	c_twrite (data: POINTER; size: INTEGER) is
		external
			"C"
		end;

	c_send_str (str: POINTER) is
		external
			"C"
		end;	

	c_tread: STRING is
		external
			"C"
		end;

end
