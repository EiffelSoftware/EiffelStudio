-- Creation type like an argument.

class CREATE_ARG 

inherit

	CREATE_INFO
	
feature 

	position: INTEGER;
			-- Position of the argument type to create in the argument
			-- list of the current treated feature

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		local
			type_i: TYPE_I;
			cl_type_i: CL_TYPE_I;
			gen_file: INDENT_FILE;
		do
			gen_file := context.generated_file;
			type_i := context.byte_code.arguments.item (position);
			type_i := context.constrained_type (type_i);
			type_i := context.instantiation_of (type_i);
				-- The following RAA cannot fail.
			cl_type_i ?= type_i;
			gen_file.putstring ("RTCA(arg");
			gen_file.putint (position);
			gen_file.putstring (", ");
			gen_file.putint (cl_type_i.type_id - 1);
			gen_file.putchar (')');
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an argument anchored type.
		local
			type_i: TYPE_I;
			cl_type_i: CL_TYPE_I;
		do
			ba.append (Bc_carg);
			type_i := context.byte_code.arguments.item (position);
			type_i := context.constrained_type (type_i);
			type_i := context.instantiation_of (type_i);
				-- The following RAA cannot fail.
			cl_type_i ?= type_i;
				-- Default creation type
			ba.append_short_integer (cl_type_i.type_id - 1);
				-- Argument position
			ba.append_short_integer (position);
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("  ");
			io.error.putint (position);
			io.error.new_line;
		end


end
