indexing
	description: "[
			Root class of Eiffel CodeDOMProvider.dll
			COM visible.
		]"

	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE191-4048-440e-A0F2-B00252DCE7F7") end,
		create {CLASS_INTERFACE_ATTRIBUTE}.make (feature {CLASS_INTERFACE_TYPE}.none) end
	assembly_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (False) end

class
	ECD_PROVIDER

inherit
	SYSTEM_DLL_CODE_DOM_PROVIDER
		undefine
			finalize, equals, get_hash_code, to_string
		redefine
			file_extension,
			language_options,
			create_generator,
			create_generator_text_writer,
			create_compiler,
			create_generator_string,
			create_parser
		end
	
	ANY

create 
	default_create

feature -- Access

	file_extension: SYSTEM_STRING is
			-- Get the file name extension to use when creating source code files.
			-- Files passed to codeDomGenerator.
		once
			Result := ".es"
		end

	language_options: SYSTEM_DLL_LANGUAGE_OPTIONS is
			-- Get a language features identifier.
		once
			Result := feature {SYSTEM_DLL_LANGUAGE_OPTIONS}.case_insensitive
		end
		
feature -- Basic Operations

	create_generator: ECD_CODE_GENERATOR is
			-- Create an instance of the Eiffel for .NET code code_generator.
		do
			create Result
		end

	create_generator_text_writer (output: SYSTEM_DLL_INDENTED_TEXT_WRITER): ECD_CODE_GENERATOR is
			-- Create a new code code_generator using the specified text writer `output'.
		require else
			non_void_output: output /= Void		
		do
			create Result.make_with_text_writer (output)
		ensure then
			non_void_result: Result /= Void
		end

	create_generator_string (file_name: SYSTEM_STRING): ECD_CODE_GENERATOR is
			-- Create a new code generator using the specified `file_name' for output.
		require else
			non_void_file_name: file_name /= Void
			not_empty_file_name: file_name.length > 0
		do
			create Result.make_with_filename (file_name)
		ensure then
			non_void_result: Result /= Void
		end

	create_compiler: ECD_COMPILER is
			-- Create an instance of the Eiffel for .NET code compiler.
		do
			create Result
		ensure then
			non_void_result: Result /= Void
		end

	create_parser: ECD_PARSER is
			-- Create a new code parser.
		do
			create Result
		end

feature {NONE} -- Implementation

	installer: ECD_INSTALLER is
			-- Installer
			--| Referenced here so that it is in system
		do
			create Result
		end

end -- class ECD_PROVIDER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------