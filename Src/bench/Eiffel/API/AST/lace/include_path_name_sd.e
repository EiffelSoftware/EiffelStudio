class INCLUDE_PATH_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_include_path
		end

feature

	is_include_path: BOOLEAN is
			-- Is the language name "Include_path" ?
		do
			Result := True;
		end

end
