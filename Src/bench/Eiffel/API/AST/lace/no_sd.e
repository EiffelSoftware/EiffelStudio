class NO_SD

inherit

	YES_OR_NO_SD
		redefine
			is_no
		end

feature

	is_no: BOOLEAN is
			-- is the option value `no' ?
		do
			Result := True;
		end

end
