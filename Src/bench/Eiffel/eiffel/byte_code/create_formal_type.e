indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_FORMAL_TYPE

inherit
	CREATE_TYPE
		redefine
			generate, generate_gen_type_conversion,
			generate_cid, type_to_create, make_byte_code
		end

creation
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Initialize
		require
			positive_position: n > 0
		do
			formal_position := n
		ensure
			formal_position_set: formal_position = n
		end

feature -- Access

	formal_position: INTEGER
				-- Position of the formal in the current type.

feature -- C code generation

	generate is
			-- Generate the creation type
		local
			buffer: GENERATION_BUFFER;
		do
			buffer := context.buffer

			buffer.putstring ("RTGPTID(")
			buffer.putint (context.current_type.generated_id (context.final_mode))
			buffer.putchar (',')
			context.current_register.print_register_by_name
			buffer.putchar (',')
			buffer.putint (formal_position)
			buffer.putchar (')');
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		do
			ba.append (Bc_gen_param_create)
			ba.append_integer (context.current_type.generated_id (False))
			ba.append_integer (formal_position)
		end;

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is
		do
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
		do
		end

	type_to_create : CL_TYPE_I is
		do
		end;

end -- class CREATE_FORMAL_TYPE
