-- Binary comparison operation

deferred class COMPARISON_AS

inherit

	BINARY_AS
		redefine
			balanced, operator_is_special, operator_is_keyword
		end

feature

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True;
		end;

	operator_is_special: BOOLEAN is true;
	
	operator_is_keyword: BOOLEAN is false;

end
