-- A void register is a special entity which can be propagated to
-- avoid an expression from being put in a register. This is mainly
-- used to avoid assignments in Result at the end of a function.

class VOID_REGISTER 

inherit

	REGISTRABLE
		rename
			context as unused_context
		redefine
			is_temporary, print_register
		end;

feature

	unused_context: BYTE_CONTEXT is
			-- Not needed
		do
		end;

	c_type: VOID_I is
			-- Void C type
		once
			!!Result;
		end;

	register_name: STRING is
			-- Do nothing
		do
		end;

	print_register is
			-- Do nothing
		do
		end; -- print_register

	is_temporary: BOOLEAN is true;
			-- No register is a temporary value.

end
