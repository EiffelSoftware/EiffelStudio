-- Creation of a like Current.

class CREATE_CURRENT 

inherit

	CREATE_INFO
		redefine
			generate_cid, make_gen_type_byte_code,
			generate_reverse, generate_cid_array,
			generate_cid_init
		end
	SHARED_GENERATION

feature 

	analyze is
			-- Mark we need the dynamic type of current
		do
			context.mark_current_used;
			context.add_dt_current;
		end;

	generate is
			-- Generate creation type id (dynamic type) of current	
		local
			buffer: GENERATION_BUFFER;
		do
			buffer := context.buffer;
			buffer.putstring ("Dftype(")
			context.Current_register.print_register_by_name
			buffer.putchar (')')
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a like Current creation type.
		do
			ba.append (Bc_ccur);
		end;

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		do
			-- Nothing.
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.putint (-12)
			buffer.putstring (", Dftype(")
			context.Current_register.print_register_by_name
			buffer.putstring ("), ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_short_integer (-12)
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			buffer.putstring ("-12, 0,")
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; 
					   final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			dummy := idx_cnt.next
			buffer.putstring ("typarr[")
			buffer.putint (idx_cnt.value)
			buffer.putstring ("] = Dftype(")
			context.Current_register.print_register_by_name
			buffer.putstring (");")
			buffer.new_line
			dummy := idx_cnt.next
		end

	type_to_create : CL_TYPE_I is

		do
			-- None.
			-- If Current is generic it already
			-- carries all the info in it's header.
		end;

feature -- Assignment attempt

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.putstring ("Dftype(")
			context.Current_register.print_register_by_name
			buffer.putstring (")")
		end

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.new_line;
		end
end
