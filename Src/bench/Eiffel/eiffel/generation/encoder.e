-- Encoder of C generate names

class ENCODER 

inherit

	SHARED_WORKBENCH
	
feature {NONE}

	Address_table_buffer: STRING is
			-- String buffer
		once
			!! Result.make (7)
			Result.append ("e000000");
		end;

	Buffer: STRING is
			-- String buffer
		once
			!!Result.make (7);
			Result.append ("E000000");
		end;

	A_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("A000000");
		end;

	B_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("B000000");
		end;

	C_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("C000000");
		end;

	D_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("D000000");
		end;

	F_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("F000000");
		end;

	P_buffer: STRING is
		once
			!!Result.make (7);
			Result.append ("P000000");
		end;

feature {NONE} -- External features

	eif000 (s: POINTER; i,j: INTEGER) is
		external
			"C"
		end;

	eif101 (s: POINTER; i: INTEGER) is
		external
			"C"
		end;

	eif011 (s: POINTER; i: INTEGER) is
		external
			"C"
		end;

end
