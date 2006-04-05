indexing
	description: "Keys that hold graphical settings saved in between sessions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_REGISTRY_KEYS

feature -- Access

	Tester_hive_path: STRING is "Software\ISE\Eiffel Codedom Provider\Tester"

	Codedom_provider_key: STRING is "CodedomProvider"

	Generated_file_folder_key: STRING is "GeneratedFileFolder"
	
	Generated_filename_key: STRING is "GeneratedFilename"

	Saved_serialized_folder_key: STRING is "SavedSerializedFileFolder"

	X_key: STRING is "X"

	Y_key: STRING is "Y"

	Width_key: STRING is "Width"
			
	Height_key: STRING is "Height"

	Saved_filename_key: STRING is "SavedFilenameKey"

	Blank_lines_key: STRING is "BlankLines"
	
	Else_at_closing_key: STRING is "ElseAtClosing"

	Identifier_key: STRING is "Identifier"

	Type_key: STRING is "Type"

	Indent_string_key: STRING is "IndentString"

	Source_filename_key: STRING is "SourceFilename"

	Source_key: STRING is "Source"

	Generate_executable_key: STRING is "GenerateExecutable"

	Generate_in_memory_key: STRING is "GenerateInMemory"
	
	Include_debug_key: STRING is "IncludeDebug"
	
	Compiler_options_key: STRING is "CompilerOptions"

	Main_class_key: STRING is "MainClass"

	Output_assembly_key: STRING is "OutputAssembly"

	Resource_key: STRING is "Resource"

	Referenced_assemblies_key: STRING is "ReferencedAssemblies"

	Parsed_file_key: STRING is "ParsedFile"

	Serialized_filename_key: STRING is "SerializedFilename";

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
end -- class TESTER_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------