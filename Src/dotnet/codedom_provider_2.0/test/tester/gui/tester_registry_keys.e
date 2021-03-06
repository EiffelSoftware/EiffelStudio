note
	description: "Keys that hold graphical settings saved in between sessions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_REGISTRY_KEYS

feature -- Access

	Tester_hive_path: STRING = "Software\ISE\Eiffel Codedom Provider\Tester"

	Codedom_provider_key: STRING = "CodedomProvider"

	Generated_file_folder_key: STRING = "GeneratedFileFolder"
	
	Generated_filename_key: STRING = "GeneratedFilename"

	Saved_serialized_folder_key: STRING = "SavedSerializedFileFolder"

	X_key: STRING = "X"

	Y_key: STRING = "Y"

	Width_key: STRING = "Width"
			
	Height_key: STRING = "Height"

	Saved_filename_key: STRING = "SavedFilenameKey"

	Blank_lines_key: STRING = "BlankLines"
	
	Else_at_closing_key: STRING = "ElseAtClosing"

	Identifier_key: STRING = "Identifier"

	Type_key: STRING = "Type"

	Indent_string_key: STRING = "IndentString"

	Source_filename_key: STRING = "SourceFilename"

	Source_key: STRING = "Source"

	Generate_executable_key: STRING = "GenerateExecutable"

	Generate_in_memory_key: STRING = "GenerateInMemory"
	
	Include_debug_key: STRING = "IncludeDebug"
	
	Compiler_options_key: STRING = "CompilerOptions"

	Main_class_key: STRING = "MainClass"

	Output_assembly_key: STRING = "OutputAssembly"

	Resource_key: STRING = "Resource"

	Referenced_assemblies_key: STRING = "ReferencedAssemblies"

	Parsed_file_key: STRING = "ParsedFile"

	Serialized_filename_key: STRING = "SerializedFilename";

note
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

