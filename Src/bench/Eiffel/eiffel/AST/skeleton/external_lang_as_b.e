class EXTERNAL_LANG_AS_B

inherit

	EXTERNAL_LANG_AS
		redefine
			language_name, extension
		end;

	AST_EIFFEL_B

	EXTERNAL_CONSTANTS

feature -- Attributes

	language_name: STRING_AS_B;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	extension: EXTERNAL_EXTENSION_AS_B
			-- Parsed external extension

feature -- Properties

	need_encapsulation: BOOLEAN is
			-- Is an encapsulation needed?
		do
			Result := extension /= Void and then extension.need_encapsulation
		end

feature

	extension_i (external_as: EXTERNAL_AS): EXTERNAL_EXT_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			if extension /= Void then
				Result := extension.extension_i (external_as)
			end
		end

end -- class EXTERNAL_LANG_AS_B
