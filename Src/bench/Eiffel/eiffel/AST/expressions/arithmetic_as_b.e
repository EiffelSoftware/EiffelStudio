-- Binary arithmetic operation

deferred class ARITHMETIC_AS

inherit

	BINARY_AS
		redefine
			balanced, balanced_result
		end

feature

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True;
		end;

	balanced_result: BOOLEAN is
			-- is the result of the infix operation subject to the
			-- balancing rule ?
		do
			Result := True;
		end;

end
