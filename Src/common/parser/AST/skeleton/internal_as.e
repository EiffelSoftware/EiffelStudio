class INTERNAL_AS

inherit

	ROUT_BODY_AS
		redefine
			type_check, byte_node
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Initialization

	set is
			-- Yacc initialization
		do
			compound ?= yacc_arg (0);
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check compound
		do
			if compound /= Void then
				compound.type_check;
			end;
		end;

	byte_node: STD_BYTE_CODE is
			-- Byte code associated to `compound'
		do
			!!Result;
			if compound /= Void then
				Result.set_compound (compound.byte_node);
			end;
		end;

end
