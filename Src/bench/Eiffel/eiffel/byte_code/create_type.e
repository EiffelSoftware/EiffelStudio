indexing
	description: "Creation with an hardwired dynamic type."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_TYPE 

inherit
	CREATE_INFO
		redefine
			generate_cid, generate_reverse
		end

create
	make
	
feature	{NONE} -- Initialization

	make (t: TYPE_I) is
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_I
			-- Type to create

feature -- C code generation

	analyze is
			-- Analyze of generated code.
		do
			if is_generic then
					-- We always need current object when it
					-- is generic.
				context.mark_current_used
			end
		end
	
	generate is
			-- Generate creation type.
		local
			l_buffer: GENERATION_BUFFER
			l_final_mode: BOOLEAN
			l_cl_type: CL_TYPE_I
		do
			l_buffer := context.buffer
			l_final_mode := not context.workbench_mode
			
			if l_final_mode then
				l_buffer.putstring ("RTLNS(")
				generate_cid (l_buffer, l_final_mode)
				l_buffer.putstring (", ")
				l_cl_type ?= context.creation_type (type)
				l_buffer.putint (l_cl_type.type_id - 1)
				l_buffer.putstring (", ")
				l_cl_type.associated_class_type.skeleton.generate_size (l_buffer)
			else
				l_buffer.putstring ("RTLN(")
				generate_cid (l_buffer, l_final_mode)
			end
			l_buffer.putchar (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a hardcoded creation type.
		local
			cl_type_i: CL_TYPE_I
			gen_type_i: GEN_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)
			il_generator.create_object (cl_type_i)

			gen_type_i ?= cl_type_i
			if gen_type_i /= Void then
				il_generator.duplicate_top
				gen_type_i.generate_gen_type_il (il_generator, True)
				il_generator.assign_computed_type
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		local
			cl_type_i: CL_TYPE_I
			gen_type : GEN_TYPE_I
		do
			ba.append (Bc_ctype)
			cl_type_i ?= context.creation_type (type)
			gen_type  ?= cl_type_i
			ba.append_short_integer (cl_type_i.type_id - 1)

			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1)
		end

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= context.creation_type (type)

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
			-- Generate creation type.
		local
			cl_type_i : CL_TYPE_I
			gen_type  : GEN_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)
			gen_type  ?= cl_type_i

			if gen_type /= Void then
				buffer.putstring ("typres")
			else
				if final_mode then
					buffer.putint (cl_type_i.type_id - 1)
				else
					buffer.putstring ("RTUD(")
					buffer.generate_type_id (cl_type_i.associated_class_type.static_type_id)
					buffer.putchar (')')
				end
			end
		end

	type_to_create : CL_TYPE_I is
		do
			Result ?= context.creation_type (type)
		end

feature -- Assignment attempt

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
			-- Generate computed type of creation for assignment attempt.
		local
			cl_type_i : CL_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)

			if final_mode then
				buffer.putint (cl_type_i.type_id - 1)
			else
				buffer.putstring ("RTUD(")
				buffer.generate_type_id (cl_type_i.associated_class_type.static_type_id)
				buffer.putchar (')')
			end
		end

end -- class CREATE_TYPE
