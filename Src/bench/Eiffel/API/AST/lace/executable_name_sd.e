class EXECUTABLE_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_executable
		end

feature

	is_executable: BOOLEAN is
			-- Is the language name "Executable" ?
		do
			Result := True;
		end

end
