indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class INCLUDE_PATH_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_include_path
		end

feature -- Properties

	is_include_path: BOOLEAN is
			-- Is the language name "Include_path" ?
		do
			Result := True;
		end

end -- class INCLUDE_PATH_NAME_SD
