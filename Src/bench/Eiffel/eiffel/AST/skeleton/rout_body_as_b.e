deferred class ROUT_BODY_AS_B

inherit

	ROUT_BODY_AS;

	AST_EIFFEL_B
		redefine
			byte_node
		end

feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte associated to the routine body (compound)
		do
			-- Do nothing
		end;

feature -- test for empty body

	empty : BOOLEAN is
			-- Is body empty?
		do
			Result := True  -- redefined in INTERNAL_AS_B
		end

end -- class ROUT_BODY_AS_B
