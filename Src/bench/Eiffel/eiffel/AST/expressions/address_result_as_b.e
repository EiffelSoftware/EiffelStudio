class ADDRESS_RESULT_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node
		end

feature

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an adress access on Current
		do
			context.put (context.feature_type);
		end;

	byte_node: HECTOR_B is
			-- Byte code for current node
		local
			result_access: RESULT_B;
		do
			!!result_access;
			!!Result.make (result_access);
		end;

end
