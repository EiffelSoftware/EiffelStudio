class BIN_IMPLIES_AS

inherit

	BINARY_AS
		redefine
			bit_balanced
		end;

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_implies";
		end;

	bit_balanced: BOOLEAN is
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?
		do
			Result := True;
		end;

end
