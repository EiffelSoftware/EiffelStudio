class YES_SD

inherit

	YES_OR_NO_SD
		redefine
			is_yes
		end

feature

	is_yes: BOOLEAN is
			-- Is the option value `yes' ?
		do
			Result := True;
		end

end
