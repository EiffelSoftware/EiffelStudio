class
	ADDRESS_CURRENT_AS_B

inherit
	ADDRESS_CURRENT_AS

	EXPR_AS_B
		redefine
			type_check, byte_node
		end

	SHARED_TYPES

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an adress access on Current
		do
			context.put (pointer_type);
		end;

	byte_node: HECTOR_B is
			-- Byte code for current node.
		local
			current_access: CURRENT_B;
		do
			!!current_access;
			!!Result.make (current_access);
		end;

end -- class ADDRESS_CURRENT_AS_B
