-- Records position of possible breakpoints within debuggable byte code,
-- with respect to the AST nodes.

class AST_POSITION

inherit

	COMPARABLE
		undefine
			is_equal
		end;
	ANY

creation

	make

feature -- Debugger

	infix "<" (other: like Current): BOOLEAN is
			-- Is current element less than `other'?
		do
			Result := position < other.position;
		end;
	
	position: INTEGER;
			-- Position within byte array since start of byte code
	
	ast_node: AST_EIFFEL;
			-- The AST node which is associated with the break-point (that is
			-- the ast node which follows the break-point at `position'.

	make (pos: INTEGER; node: AST_EIFFEL) is
			-- Initialization
		do
			position := pos;
			ast_node := node;
		end;

	shift (amount: INTEGER) is
			-- Shift `position' by `amount'
		do
			position := position + amount;
		end;

	set_stop (b: BOOLEAN) is
		do
			is_set := b;
		end;

	is_set: BOOLEAN;
		-- is a breakpoint set at this position

end
