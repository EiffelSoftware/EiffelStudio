class EXTERNAL_LANG_AS_B

inherit

	EXTERNAL_LANG_AS
		redefine
			language_name, extension,
			c_extension, cpp_extension,
			dll_extension, macro_extension
		end;

	AST_EIFFEL_B
		undefine
			is_equivalent
		end;

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
			Result := extension /= Void
		end

feature

	extension_i (external_as: EXTERNAL_AS): EXTERNAL_EXT_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			if extension /= Void then
				Result := extension.extension_i (external_as)
			end
		end

feature

	c_extension: C_EXTENSION_AS_B is
			-- AST for parsed standard C extension
		do
			!! Result
		end
 
	cpp_extension: CPP_EXTENSION_AS_B is
			-- AST for parsed C++ extension
		do
			!! Result
		end
 
	dll_extension: C_DLL_EXTENSION_AS_B is
			-- AST for parsed DLL extension
		do
			!! Result
		end
 
	macro_extension: C_MACRO_EXTENSION_AS_B is
			-- AST for parsed macro extension
		do
			!! Result
		end
 
end -- class EXTERNAL_LANG_AS_B
