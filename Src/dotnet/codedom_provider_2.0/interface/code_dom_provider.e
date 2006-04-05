indexing
	description: "[
			Root class of Eiffel Codedom Provider dll
			COM visible.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE191-4048-440e-A0F2-B00252DCE7F7") end,
		create {CLASS_INTERFACE_ATTRIBUTE}.make ({CLASS_INTERFACE_TYPE}.none) end
	assembly_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (False) end

class
	CODE_DOM_PROVIDER

inherit
	SYSTEM_DLL_CODE_DOM_PROVIDER
		redefine
			file_extension,
			language_options,
			create_generator,
			create_generator_text_writer,
			create_compiler,
			create_generator_string,
			create_parser
		end

create 
	default_create

feature -- Access

	file_extension: SYSTEM_STRING is
			-- Get the file name extension to use when creating source code files.
			-- Files passed to codeDomGenerator.
		once
			Result := "es"
		end

	language_options: SYSTEM_DLL_LANGUAGE_OPTIONS is
			-- Get a language features identifier.
		once
			Result := {SYSTEM_DLL_LANGUAGE_OPTIONS}.Case_insensitive
		end
		
feature -- Basic Operations

	create_generator: CODE_GENERATOR is
			-- Create an instance of the Eiffel for .NET code code_generator.
		do
			load_assemblies
			create Result
		end

	create_generator_text_writer (output: SYSTEM_DLL_INDENTED_TEXT_WRITER): CODE_GENERATOR is
			-- Create a new code code_generator using the specified text writer `output'.
		require else
			non_void_output: output /= Void		
		do
			load_assemblies
			create Result.make_with_text_writer (output)
		ensure then
			non_void_result: Result /= Void
		end

	create_generator_string (file_name: SYSTEM_STRING): CODE_GENERATOR is
			-- Create a new code generator using the specified `file_name' for output.
		require else
			non_void_file_name: file_name /= Void
			not_empty_file_name: file_name.length > 0
		do
			load_assemblies
			create Result.make_with_filename (file_name)
		ensure then
			non_void_result: Result /= Void
		end

	create_compiler: CODE_COMPILER is
			-- Create an instance of the Eiffel for .NET code compiler.
		do
			load_assemblies
			create Result
		ensure then
			non_void_result: Result /= Void
		end

	create_parser: CODE_PARSER is
			-- Create a new code parser.
		do
			load_assemblies
			create Result
		end

feature {NONE} -- Implementation

	installer: CODE_INSTALLER is
			-- Installer
			--| Referenced here so that it is in system
		do
			create Result
		end

	load_assemblies is
			-- Force loading of base, cache browser and codedom in internal
			-- to workaround .NET bug where an assembly might not be returned
			-- by {APP_DOMAIN}.GetAssemblies
		local
			l_int: CODE_INTERNAL
			l_object: SYSTEM_OBJECT
			l_string: STRING
			l_metadata_access: CODE_SHARED_METADATA_ACCESS
		once
			create l_int
			create l_string.make_empty
			l_object := l_string
			l_int.load_eiffel_types_from_assembly (l_object.get_type.assembly)
			create l_metadata_access
			l_object := l_metadata_access
			l_int.load_eiffel_types_from_assembly (l_object.get_type.assembly)
			l_object := Current
			l_int.load_eiffel_types_from_assembly (l_object.get_type.assembly)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_DOM_PROVIDER

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