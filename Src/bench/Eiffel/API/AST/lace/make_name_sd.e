class MAKE_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_make
		end

feature

	is_make: BOOLEAN is
			-- Is the language name "Make" ?
		do
			Result := true;
		end;

end
