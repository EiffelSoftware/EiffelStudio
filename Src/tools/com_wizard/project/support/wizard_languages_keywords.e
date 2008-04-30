indexing
	description: "Languages Keywords"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_LANGUAGES_KEYWORDS

feature -- IDL keywords

	In: STRING is "in"

	Out_keyword: STRING is "out"

	Inout: STRING is "in, out"

	Retval: STRING is "retval"

	Out_retval: STRING is "out, retval"

feature -- Eiffel keywords 

	Is_keyword: STRING is "is"

	If_keyword: STRING is "if"
	
	Do_keyword: STRING is "do"
	
	Alias_keyword: STRING is "alias"

	Agent_keyword: STRING is "agent"

	Attribute_keyword: STRING is "attribute"

	Note_keyword: STRING is "note"

	Deferred_keyword: STRING is "deferred"

	Require_keyword: STRING is "require"

	Create_keyword: STRING is "create"

	Once_keyword: STRING is "once"
	
	End_keyword: STRING is "end"
	
	Class_keyword: STRING is "class"
	
	Convert_keyword: STRING is "convert"

	Inherit_keyword: STRING is "inherit"

	Rename_keyword: STRING is "rename"

	Redefine_keyword: STRING is "redefine"

	Undefine_keyword: STRING is "undefine"

	Export_keyword: STRING is "export"

	Select_keyword: STRING is "select"

	Like_keyword: STRING is "like "

	Ensure_keyword: STRING is "ensure"

	Local_keyword: STRING is "local"

	Result_keyword: STRING is "Result"

	Current_keyword: STRING is "Current"

	As_keyword: STRING is "as"

	Or_keyword: STRING is "or"

	Then_keyword: STRING is "then"

	Feature_keyword: STRING is "feature"

	Indexing_keyword: STRING is "indexing"
	
	Creation_keyword: STRING is "creation"

	External_keyword: STRING is "external"

	Else_keyword: STRING is "else"

	All_keyword: STRING is "all"

	And_keyword: STRING is "and"

	Check_keyword: STRING is "check"

	Debug_keyword: STRING is "debug"

	Elseif_keyword: STRING is "elseif"

	Expanded_keyword: STRING is "expanded"

	From_keyword: STRING is "from"

	Frozen_keyword: STRING is "frozen"

	Implies_keyword: STRING is "implies"

	Infix_keyword: STRING is "infix"

	Inspect_keyword: STRING is "inspect"

	Invariant_keyword: STRING is "invariant"

	Loop_keyword: STRING is "loop"

	Not_keyword: STRING is "not"

	Obsolete_keyword: STRING is "obsolete"

	Old_keyword: STRING is "old"

	Prefix_keyword: STRING is "prefix"

	Reference_keyword: STRING is "reference"

	Rescue_keyword: STRING is "rescue"

	Retry_keyword: STRING is "retry"

	Separate_keyword: STRING is "separate"

	Until_keyword: STRING is "until"

	Variant_keyword: STRING is "variant"

	When_keyword: STRING is "when"

	Xor_keyword: STRING is "xor"

	Bit_keyword: STRING is "BIT"

	True_keyword: STRING is "True"

	False_keyword: STRING is "False"

	Precursor_keyword: STRING is "Precursor"

	Strip_keyword: STRING is "Strip"

	Unique_keyword: STRING is "Unique"

feature -- C keywords

	Begin_comment: STRING is "/*"

	End_comment: STRING is "*/"

	Static_cast: STRING is "static_cast"

	Reinterpret_cast: STRING is "reinterpret_cast"

	Else_if: STRING is "else if"

	Switch: STRING is "switch"

	Case: STRING is "case"

	For: STRING is "for"

	Int: STRING is "int"

	New: STRING is "new"

	Const: STRING is "const"

	Hash_if_def: STRING is "#ifdef"

	Hash_if_ndef: STRING is "#ifndef"

	Hash_else: STRING is "#else"

	Hash_end_if: STRING is "#endif"

	Hash_define: STRING is "#define"

	While: STRING is "while"

	This: STRING is "this"

	Delete: STRING is "delete"

	Define: STRING is "define"

	Endif: STRING is "endif"

	Ifndef: STRING is "ifndef"

	Return: STRING is "return"

	Struct: STRING is "struct"

	Union: STRING is "union"

	Enum: STRING is "enum"

	Extern: STRING is "extern"

	Import: STRING is "%Simport"

	Include_clause: STRING is "%Sinclude"

	C_class_keyword: STRING is "class"

	Calloc: STRING is "calloc"

	Free: STRING is "free"

	Sizeof: STRING is "sizeof"

	Break: STRING is "break"

	C_binary_or: STRING is "|"

	Null: STRING is "NULL"

	Typedef: STRING is "typedef"

	C_true: STRING is "TRUE"

	Assert: STRING is "assert"

	String_copy_function: STRING is "strcpy"

	Get_current_directory_function: STRING is "getcwd"

	String_length_function: STRING is "strlen"

	Unicode_string_copy_function: STRING is "lstrcpy"

	Non_unicode_string_copy_function: STRING is "mbstowcs"

	Malloc: STRING is "malloc"

	Memcpy: STRING is "memcpy"

	Eof_word: STRING is "EOF"

feature -- Lace keywords

	System_keyword: STRING is "system";

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
end -- class WIZARD_LANGUAGES_KEYWORDS

