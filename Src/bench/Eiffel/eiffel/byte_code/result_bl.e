-- Enlarged access to Result

class RESULT_BL 

inherit

	RESULT_B
		redefine
			used, generate, parent, set_parent,
			free_register, print_register, propagate,
			type
		end

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
				if c_type.is_pointer then
					print_register_by_name;
				else
					generated_file.putstring (register_name);
				end;
			else
				type_i := real_type (context.byte_code.result_type);
				type_i.c_type.generate_cast (generated_file);
				generated_file.putchar ('0');
			end;
		end;

end
