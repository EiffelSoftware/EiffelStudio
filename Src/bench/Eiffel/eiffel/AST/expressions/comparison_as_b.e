-- Binary comparison operation

deferred class COMPARISON_AS

inherit

	BINARY_AS
		redefine
			balanced
		end

feature

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True;
		end;

end
