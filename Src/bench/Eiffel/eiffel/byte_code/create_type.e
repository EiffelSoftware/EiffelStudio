-- Creation with an hardwired dynamic type.

class CREATE_TYPE 

inherit
	CREATE_INFO
		redefine
			generate_cid, generate_reverse
		end
	
feature -- Access

	type: TYPE_I;
			-- Type to create

feature -- Update 

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- C code generation

	analyze is

		do
			if is_generic then
				context.mark_current_used
			end
		end;
	
	generate is
			-- Generate the creation type
		local
			cl_type_i: CL_TYPE_I;
			gen_type_i: GEN_TYPE_I;
			buffer: GENERATION_BUFFER;
		do
			cl_type_i ?= context.creation_type (type);
			gen_type_i ?= cl_type_i;

			buffer := context.buffer;

			if gen_type_i /= Void then
				buffer.putstring ("typres");
			else
				if context.workbench_mode then
					buffer.putstring ("RTUD(");
					buffer.generate_type_id (cl_type_i.associated_class_type.static_type_id)
					buffer.putchar (')');
				else
					buffer.putint (cl_type_i.type_id - 1);
				end;
			end;
		end;

feature -- IL code generation

	generate_il is
			-- Generate IL code for a hardcoded creation type.
		local
			cl_type_i: CL_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)
			il_generator.create_object (cl_type_i)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		local
			cl_type_i: CL_TYPE_I;
			gen_type : GEN_TYPE_I
		do
			ba.append (Bc_ctype);
			cl_type_i ?= context.creation_type (type);
			gen_type  ?= cl_type_i;
			ba.append_short_integer (cl_type_i.type_id - 1);

			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1);
		end;

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

		local
			cl_type_i : CL_TYPE_I;
			gen_type  : GEN_TYPE_I
		do
			cl_type_i ?= context.creation_type (type);
			gen_type  ?= cl_type_i;

			if gen_type /= Void then
				buffer.putstring ("typres");
			else
				if context.workbench_mode then
					buffer.putstring ("RTUD(")
					buffer.generate_type_id (cl_type_i.associated_class_type.static_type_id)
					buffer.putchar (')')
				else
					buffer.putint (cl_type_i.type_id - 1);
				end
			end
		end;

	type_to_create : CL_TYPE_I is
		do
			Result ?= context.creation_type (type)
		end;

feature -- Assignment attempt

	generate_reverse (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			cl_type_i : CL_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)

			if context.workbench_mode then
				buffer.putstring ("RTUD(")
				buffer.generate_type_id (cl_type_i.associated_class_type.static_type_id)
				buffer.putchar (')')
			else
				buffer.putint (cl_type_i.type_id - 1)
			end
		end

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			type.trace;
			io.error.new_line;
		end
end
