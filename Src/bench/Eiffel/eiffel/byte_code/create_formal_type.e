indexing
	description: "Creation of a formal generic parameter."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_FORMAL_TYPE

inherit
	CREATE_TYPE
		redefine
			generate, generate_gen_type_conversion,
			generate_cid, type_to_create, make_byte_code,
			analyze, generate_il, type
		end

creation
	make

feature -- Access

	type: FORMAL_I
			-- Current type of creation.

feature -- C code generation

	analyze is
		do
				-- Current is always used to generate the correct generic parameter.
			context.mark_current_used
		end

	generate is
			-- Generate formal creation type
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer

			buffer.putstring ("RTGPTID(")
			buffer.putint (context.current_type.generated_id (context.final_mode))
			buffer.putchar (',')
			context.current_register.print_register
			buffer.putchar (',')
			buffer.putint (type.position)
			buffer.putchar (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a formal creation type.
		local
			formal: FORMAL_I
		do
				-- Compute actual type of Current formal.
			formal ?= type
			formal.generate_gen_type_il (il_generator, True)
			
				-- Evaluate the type and create a corresponding object type.
			il_generator.generate_current
			il_generator.create_type
		end
		
feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a formal creation type.
		do
			ba.append (Bc_gen_param_create)
			ba.append_short_integer (context.current_type.generated_id (False))
			ba.append_integer (type.position)
		end

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is
		do
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
		do
		end

	type_to_create : CL_TYPE_I is
		do
		end

end -- class CREATE_FORMAL_TYPE
