class ASSERT_LIST_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node
		end

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			assertions ?= yacc_arg (0);
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check assertion list
		do
			if assertions /= Void then
				assertions.type_check;
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte node associated to the assertion list
		do
			if assertions /= Void then
				Result := assertions.byte_node;
			end;
		end;

end
