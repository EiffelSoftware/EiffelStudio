-- Enlarged access to Result

class
	RESULT_BL 

inherit
	RESULT_B
		redefine
			used, generate, parent, set_parent,
			free_register, print_register, propagate,
			type, print_register_by_name
		end;

creation
	make

feature 

	parent: NESTED_BL;
			-- Parent of access

	type: TYPE_I;
			-- Result type

	make (t: TYPE_I) is
			-- Initialization
		require
			good_argument: t /= Void
		do
			type := t;
		end;
	
	set_parent (p: NESTED_BL) is
			-- Set `parent' to `p'
		do
			parent := p;
		end;

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' the "Result" entity ?
		do
			Result := r.is_result;
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
		end;

	print_register is
			-- Print "Result"
		local
			type_i: TYPE_I;
		do
			if context.result_used then
					-- Once function have their result recorded into the GC,
					-- so it's useless to use an l[] variable.
				if c_type.is_pointer then
					print_register_by_name;
				else
					buffer.putstring (register_name);
				end;
			else
				type_i := real_type (context.byte_code.result_type);
				type_i.c_type.generate_cast (buffer);
				buffer.putchar ('0');
			end;
		end;

	print_register_by_name is
			-- Print "Result" in once functions, regardless of the type of
			-- the result, otherwise call the standard function.
			-- The reason is that once function record their Result variable
			-- into the GC, so there is no need to use an l[] function.
		do
			if not context.byte_code.is_once then
				{RESULT_B} Precursor;
			else
				buffer.putstring (register_name);
			end;
		end;

end
