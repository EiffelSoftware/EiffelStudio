-- Creation of a like Current.

class CREATE_CURRENT 

inherit

	CREATE_INFO;
	SHARED_GENERATION_CONSTANTS

feature 

	analyze is
			-- Mark we need the dynamic type of current
		do
			context.mark_current_used;
			context.add_dt_current;
		end;

	generate is
			-- Generate creation type id (dynamic type) of current	
		do
			context.generate_current_dtype;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a like Current creation type.
		do
			ba.append (Bc_ccur);
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.new_line;
		end


end
