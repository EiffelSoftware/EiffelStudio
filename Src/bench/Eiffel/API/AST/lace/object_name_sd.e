class OBJECT_NAME_SD

inherit

	LANGUAGE_NAME_SD
		redefine
			is_object
		end

feature

	is_object: BOOLEAN is
			-- Is the language name "Object" ?
		do
			Result := True;
		end

end
