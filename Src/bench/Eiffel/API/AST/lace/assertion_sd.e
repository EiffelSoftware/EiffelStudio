class ASSERTION_SD

inherit

	OPTION_SD
		redefine
			is_assertion
		end

feature

	option_name: STRING is
		once
			Result := "assertion"
		end;

	is_assertion: BOOLEAN is
			-- Is the option an assertion one ?
		do
			Result := True;
		end

end
