-- Creation with an hardwired dynamic type.

class CREATE_TYPE 

inherit

	CREATE_INFO
	
feature 

	type: TYPE_I;
			-- Type to create

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

feature -- C code generation

	analyze is
			-- Do nothing
		do
		end;
	
	generate is
			-- Generate the creation type
		local
			type_i: TYPE_I;
			cl_type_i: CL_TYPE_I;
			gen_file: INDENT_FILE;
		do
			type_i := context.constrained_type (type);
			type_i := context.instantiation_of (type_i);
				-- The following RAA cannot fail.
			cl_type_i ?= type_i;

			gen_file := context.generated_file;
			if context.workbench_mode then
				gen_file.putstring ("RTUD(");
				gen_file.putstring (cl_type_i.associated_class_type.id.generated_id);
				gen_file.putchar (')');
			else
				gen_file.putint (cl_type_i.type_id - 1);
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		local
			cl_type_i: CL_TYPE_I;
		do
			ba.append (Bc_ctype);
			cl_type_i ?= context.real_type (type);
			ba.append_short_integer (cl_type_i.type_id - 1);
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
