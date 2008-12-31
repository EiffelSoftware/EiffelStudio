note
	description: "Languages Keywords"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_LANGUAGES_KEYWORDS

feature -- IDL keywords

	In: STRING = "in"

	Out_keyword: STRING = "out"

	Inout: STRING = "in, out"

	Retval: STRING = "retval"

	Out_retval: STRING = "out, retval"

feature -- Eiffel keywords 

	Is_keyword: STRING = "is"

	If_keyword: STRING = "if"
	
	Do_keyword: STRING = "do"
	
	Alias_keyword: STRING = "alias"

	Agent_keyword: STRING = "agent"

	Attribute_keyword: STRING = "attribute"

	Note_keyword: STRING = "note"

	Deferred_keyword: STRING = "deferred"

	Require_keyword: STRING = "require"

	Create_keyword: STRING = "create"

	Once_keyword: STRING = "once"
	
	End_keyword: STRING = "end"
	
	Class_keyword: STRING = "class"
	
	Convert_keyword: STRING = "convert"

	Inherit_keyword: STRING = "inherit"

	Rename_keyword: STRING = "rename"

	Redefine_keyword: STRING = "redefine"

	Undefine_keyword: STRING = "undefine"

	Export_keyword: STRING = "export"

	Select_keyword: STRING = "select"

	Like_keyword: STRING = "like "

	Ensure_keyword: STRING = "ensure"

	Local_keyword: STRING = "local"

	Result_keyword: STRING = "Result"

	Current_keyword: STRING = "Current"

	As_keyword: STRING = "as"

	Or_keyword: STRING = "or"

	Then_keyword: STRING = "then"

	Feature_keyword: STRING = "feature"

	Indexing_keyword: STRING = "indexing"
	
	Creation_keyword: STRING = "creation"

	External_keyword: STRING = "external"

	Else_keyword: STRING = "else"

	All_keyword: STRING = "all"

	And_keyword: STRING = "and"

	Check_keyword: STRING = "check"

	Debug_keyword: STRING = "debug"

	Elseif_keyword: STRING = "elseif"

	Expanded_keyword: STRING = "expanded"

	From_keyword: STRING = "from"

	Frozen_keyword: STRING = "frozen"

	Implies_keyword: STRING = "implies"

	Infix_keyword: STRING = "infix"

	Inspect_keyword: STRING = "inspect"

	Invariant_keyword: STRING = "invariant"

	Loop_keyword: STRING = "loop"

	Not_keyword: STRING = "not"

	Obsolete_keyword: STRING = "obsolete"

	Old_keyword: STRING = "old"

	Prefix_keyword: STRING = "prefix"

	Reference_keyword: STRING = "reference"

	Rescue_keyword: STRING = "rescue"

	Retry_keyword: STRING = "retry"

	Separate_keyword: STRING = "separate"

	Until_keyword: STRING = "until"

	Variant_keyword: STRING = "variant"

	When_keyword: STRING = "when"

	Xor_keyword: STRING = "xor"

	Bit_keyword: STRING = "BIT"

	True_keyword: STRING = "True"

	False_keyword: STRING = "False"

	Precursor_keyword: STRING = "Precursor"

	Strip_keyword: STRING = "Strip"

	Unique_keyword: STRING = "Unique"

feature -- C keywords

	Begin_comment: STRING = "/*"

	End_comment: STRING = "*/"

	Static_cast: STRING = "static_cast"

	Reinterpret_cast: STRING = "reinterpret_cast"

	Else_if: STRING = "else if"

	Switch: STRING = "switch"

	Case: STRING = "case"

	For: STRING = "for"

	Int: STRING = "int"

	New: STRING = "new"

	Const: STRING = "const"

	Hash_if_def: STRING = "#ifdef"

	Hash_if_ndef: STRING = "#ifndef"

	Hash_else: STRING = "#else"

	Hash_end_if: STRING = "#endif"

	Hash_define: STRING = "#define"

	While: STRING = "while"

	This: STRING = "this"

	Delete: STRING = "delete"

	Define: STRING = "define"

	Endif: STRING = "endif"

	Ifndef: STRING = "ifndef"

	Return: STRING = "return"

	Struct: STRING = "struct"

	Union: STRING = "union"

	Enum: STRING = "enum"

	Extern: STRING = "extern"

	Import: STRING = "%Simport"

	Include_clause: STRING = "%Sinclude"

	C_class_keyword: STRING = "class"

	Calloc: STRING = "calloc"

	Free: STRING = "free"

	Sizeof: STRING = "sizeof"

	Break: STRING = "break"

	C_binary_or: STRING = "|"

	Null: STRING = "NULL"

	Typedef: STRING = "typedef"

	C_true: STRING = "TRUE"

	Assert: STRING = "assert"

	String_copy_function: STRING = "strcpy"

	Get_current_directory_function: STRING = "getcwd"

	String_length_function: STRING = "strlen"

	Unicode_string_copy_function: STRING = "lstrcpy"

	Non_unicode_string_copy_function: STRING = "mbstowcs"

	Malloc: STRING = "malloc"

	Memcpy: STRING = "memcpy"

	Eof_word: STRING = "EOF"

feature -- Lace keywords

	System_keyword: STRING = "system";

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
end -- class WIZARD_LANGUAGES_KEYWORDS

