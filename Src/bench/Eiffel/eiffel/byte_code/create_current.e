indexing
	description: "Creation of a like Current."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CURRENT 

inherit
	CREATE_INFO
		redefine
			generate_cid, make_gen_type_byte_code,
			generate_reverse, generate_cid_array,
			generate_cid_init
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_GEN_CONF_LEVEL
		export
			{NONE} all
		end

feature -- C code generation

	analyze is
			-- Mark we need the dynamic type of current
		do
			context.mark_current_used
			context.add_dt_current
		end

	generate is
			-- Generate creation type id (dynamic type) of current	
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.putstring ("RTLNC(")
			context.Current_register.print_register
			buffer.putchar (')')
		end

feature -- Il code generation

	generate_il is
			-- Generate byte code for like Current creation type.
		do
			il_generator.generate_current
			il_generator.create_like_object
			il_generator.generate_check_cast (Void, context.current_type)
		end

	generate_il_type is
			-- Load type of Current object.
		do
			il_generator.generate_current
			il_generator.load_type
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a like Current creation type.
		do
			ba.append (Bc_ccur)
		end

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		do
			-- Nothing.
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.putint (Like_current_type)
			buffer.putstring (", Dftype(")
			context.Current_register.print_register
			buffer.putstring ("), ")
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_short_integer (Like_current_type)
		end

	generate_cid_array (buffer : GENERATION_BUFFER; 
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			buffer.putint (Like_current_type)
			buffer.putstring (", 0,")
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
			context.Current_register.print_register
			buffer.putstring (");")
			buffer.new_line
			dummy := idx_cnt.next
		end

	type_to_create : CL_TYPE_I is

		do
			-- None.
			-- If Current is generic it already
			-- carries all the info in it's header.
		end

feature -- Assignment attempt

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.putstring ("Dftype(")
			context.Current_register.print_register
			buffer.putstring (")")
		end

end -- class CREATE_CURRENT
