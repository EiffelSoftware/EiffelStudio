class BIN_POWER_AS

inherit

	ARITHMETIC_AS
		redefine
			balanced
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_power";
		end;

	balanced: BOOLEAN is
			-- Is the operation balanced ?
		do
			-- Do nothing
		end;

end -- class BIN_POWER_AS
