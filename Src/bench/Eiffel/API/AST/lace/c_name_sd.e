class C_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_c
		end

feature

	is_c: BOOLEAN is
			-- Is the language name "C" ?
		do
			Result := True;
		end

end
