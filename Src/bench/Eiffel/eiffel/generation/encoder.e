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
