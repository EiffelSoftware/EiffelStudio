-- External routines for debugging

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

	c_handshake: BOOLEAN is
		external
			"C"
		end;

	recv_request: ANY is
		external
			"C"
		end;

	recv_ack: BOOLEAN is
		external
			"C"
		end;

	recv_dead: BOOLEAN is
		external
			"C"
		end;

	c_twrite (data: ANY; size: INTEGER) is
		external
			"C"
		end;

	c_send_str (str: ANY) is
		external
			"C"
		end;	

	c_recv_str: STRING is
		external
			"C"
		end;

	c_tread: STRING is
		external
			"C"
		end;

	c_tpipe is
		external
			"C"
		end;

end
