indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class MAKE_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_make
		end

feature -- Properties

	is_make: BOOLEAN is
			-- Is the language name "Make" ?
		do
			Result := true;
		end;

end -- class MAKE_NAME_SD
