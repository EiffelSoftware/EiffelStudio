-- Creation of a like Current.

class CREATE_CURRENT 

inherit

	CREATE_INFO
	
feature 

	analyze is
			-- Mark we need the dynamic type of current
		do
			context.add_dt_current;
		end;

	generate is
			-- Generate creation type id (dynamic type) of current	
		local
			gen_file: UNIX_FILE;
		do
			gen_file := context.generated_file;
			if context.dt_current > 1 then
				gen_file.putstring ("dtype");
			else
				gen_file.putstring ("Dtype(Current)");
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a like Current creation type.
		do
			ba.append (Bc_ccur);
		end;

end
