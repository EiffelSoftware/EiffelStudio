-- Creation with an hardwired dynamic type.

class CREATE_TYPE 

inherit
	CREATE_INFO
	
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
			gen_file: INDENT_FILE;
		do
			cl_type_i ?= context.real_type (type);
			gen_type_i ?= cl_type_i;

			gen_file := context.generated_file;

			if gen_type_i /= Void then
				gen_file.putstring ("typres");
			else
				if context.workbench_mode then
					gen_file.putstring ("RTUD(");
					gen_file.putstring (cl_type_i.associated_class_type.id.generated_id);
					gen_file.putchar (')');
				else
					gen_file.putint (cl_type_i.type_id - 1);
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		local
			cl_type_i: CL_TYPE_I;
			gen_type : GEN_TYPE_I
		do
			ba.append (Bc_ctype);
			cl_type_i ?= context.real_type (type);
			gen_type  ?= cl_type_i;
			ba.append_short_integer (cl_type_i.type_id - 1);

			if gen_type /= Void then
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1);
		end;

feature -- Generic conformance

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= context.real_type (type)

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generated_type_id : STRING is

		local
			cl_type_i : CL_TYPE_I;
			gen_type  : GEN_TYPE_I
		do
			cl_type_i ?= context.real_type (type);
			gen_type  ?= cl_type_i;

			!!Result.make (0);

			if gen_type /= Void then
				Result.append ("typres");
			else
				if context.workbench_mode then
					Result.append ("RTUD(")
					Result.append (cl_type_i.associated_class_type.id.generated_id)
					Result.append_character (')')
				else
					Result.append_integer (cl_type_i.type_id - 1);
				end
			end
		end;

	type_to_create : CL_TYPE_I is
		do
			Result ?= context.real_type (type)
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			type.trace;
			io.error.new_line;
		end
end
