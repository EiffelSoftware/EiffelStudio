indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class C_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_c
		end

feature -- Properties

	is_c: BOOLEAN is
			-- Is the language name "C" ?
		do
			Result := True;
		end

end -- class C_NAME_SD
