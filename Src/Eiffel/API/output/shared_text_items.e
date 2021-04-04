note
	description: "Shared text format items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class SHARED_TEXT_ITEMS

inherit
	SHARED_FILTER

feature -- Keywords

	ti_across_keyword: STRING = "across"
			-- "across" keyword

	ti_and_keyword: STRING = "and"
			-- "and" keyword

	ti_and_then_keyword: STRING = "and then"
			-- "and then" keyword

	ti_Agent_keyword: STRING = "agent"
			-- "agent" keyword

	ti_Alias_keyword: STRING = "alias"
			-- "alias" keyword

	ti_All_keyword: STRING = "all"
			-- "all" keyword

	ti_As_keyword: STRING = "as"
			-- "as" keyword

	ti_Assign_keyword: STRING = "assign"
			-- "assign" keyword

	ti_attached_keyword: STRING = "attached"
			-- "attached" keyword

	ti_Attribute_keyword: STRING = "attribute"
			-- "attribute" keyword

	ti_Check_keyword: STRING = "check"
			-- "check" keyword

	ti_Class_keyword: STRING = "class"
			-- "class" keyword

	ti_convert_keyword: STRING = "convert"
			-- "convert" keyword

	ti_Create_keyword: STRING = "create"
			-- "create" keyword

	ti_Debug_keyword: STRING = "debug"
			-- "debug" keyword

	ti_Deferred_keyword: STRING = "deferred"
			-- "deferred" keyword

	ti_detachable_keyword: STRING = "detachable"
			-- "attached" keyword

	ti_Do_keyword: STRING = "do"
			-- "do" keyword

	ti_Else_keyword: STRING = "else"
			-- "else" keyword

	ti_Elseif_keyword: STRING = "elseif"
			-- "elseif" keyword

	ti_End_keyword: STRING = "end"
			-- "end" keyword

	ti_Ensure_keyword: STRING = "ensure"
			-- "ensure" keyword

	ti_ensure_then_keyword: STRING = "ensure then"
			-- "ensure then" keyword

	ti_Expanded_keyword: STRING = "expanded"
			-- "expanded" keyword

	ti_Export_keyword: STRING = "export"
			-- "export" keyword

	ti_External_keyword: STRING = "external"
			-- "external" keyword

	ti_False_keyword: STRING = "False"
			-- "false" keyword

	ti_Feature_keyword: STRING = "feature"
			-- "feature" keyword

	ti_From_keyword: STRING = "from"
			-- "from" keyword

	ti_Frozen_keyword: STRING = "frozen"
			-- "frozen" keyword

	ti_If_keyword: STRING = "if"
			-- "if" keyword

	ti_implies_keyword: STRING = "implies"
			-- "implies" keyword

	ti_Indexing_keyword: STRING = "indexing"
			-- "indexing" keyword

	ti_Infix_keyword: STRING = "infix"
			-- "infix" keyword

	ti_Inherit_keyword: STRING = "inherit"
			-- "inherit" keyword

	ti_Inspect_keyword: STRING = "inspect"
			-- "inspect" keyword

	ti_Interface_keyword: STRING = "interface"
			-- "interface" keyword (used in the short form)

	ti_Invariant_keyword: STRING = "invariant"
			-- "invariant" keyword

	ti_Is_keyword: STRING = "is"
			-- "is" keyword

	ti_Like_keyword: STRING = "like"
			-- "like" keyword

	ti_Local_keyword: STRING = "local"
			-- "local" keyword

	ti_Loop_keyword: STRING = "loop"
			-- "loop" keyword

	ti_not_keyword: STRING = "not"
			-- "not" keyword

	ti_note_keyword: STRING = "note"
			-- "note" keyword

	ti_Obsolete_keyword: STRING = "obsolete"
			-- "obsolete" keyword

	ti_Old_keyword: STRING = "old"
			-- "old" keyword

	ti_Once_keyword: STRING = "once"
			-- "once" keyword

	ti_or_keyword: STRING = "or"
			-- "or" keyword

	ti_or_else_keyword: STRING = "or else"
			-- "or else" keyword

	ti_Precursor_keyword: STRING = "Precursor"
			-- "precursor" keyword

	ti_Prefix_keyword: STRING = "prefix"
			-- "prefix" keyword

	ti_Redefine_keyword: STRING = "redefine"
			-- "redefine" keyword

	ti_Reference_keyword: STRING = "reference"
			-- "reference" keyword

	ti_Rename_keyword: STRING = "rename"
			-- "rename" keyword

	ti_Require_keyword: STRING = "require"
			-- "require" keyword

	ti_require_else_keyword: STRING = "require else"
			-- "require else" keyword

	ti_Rescue_keyword: STRING = "rescue"
			-- "rescue" keyword

	ti_Retry_keyword: STRING = "retry"
			-- "retry" keyword

	ti_Select_keyword: STRING = "select"
			-- "select" keyword

	ti_Separate_keyword: STRING = "separate"
			-- "separate" keyword

	ti_Some_keyword: STRING = "some"
			-- "some" keyword

	ti_Strip_keyword: STRING = "strip"
			-- "strip" keyword

	ti_Then_keyword: STRING = "then"
			-- "then" keyword

	ti_True_keyword: STRING = "True"
			-- "true" keyword

	ti_Undefine_keyword: STRING = "undefine"
			-- "undefine" keyword

	ti_Unique_keyword: STRING = "unique"
			-- "unique" keyword

	ti_Until_keyword: STRING = "until"
			-- "until" keyword

	ti_Variant_keyword: STRING = "variant"
			-- "variant" keyword

	ti_void: STRING = "Void"
			-- `Void' feature.

	ti_When_keyword: STRING = "when"
			-- "when" keyword

	ti_xor_keyword: STRING = "xor"
			-- "xor" keyword

feature -- Symbol names

	ti_Assign: STRING = ":="
			-- ":=" characters

	ti_Colon: STRING = ":"
			-- ":" character

	ti_Comma: STRING = ","
			-- "," character

	ti_Constraint: STRING = "->"
			-- "->" characters

	ti_Dashdash: STRING = "--"
			-- "--" characters

	ti_Dollar: STRING = "$"
			-- "$" character.

	ti_at: STRING = "@"
			-- "@" character.

	ti_Dot: STRING = "."
			-- "." character.

	ti_Dotdot: STRING = ".."
			-- ".." characters

	ti_Double_quote: STRING = "%""
			-- '"' character

	ti_Empty: STRING = ""
			-- Empty character

	ti_Equal: STRING = "="
			-- "=" character

	ti_Exclamation: STRING = "!"
			-- "!" character

	ti_Greater_than: STRING = ">"
			-- ">" character

	ti_Greater_equal: STRING = ">="
			-- ">=" characters

	ti_L_array: STRING = "<<"
			-- "<<" characters

	ti_L_bracket: STRING = "["
			-- "[" character

	ti_L_curly: STRING = "{"
			-- "{" character

	ti_L_parenthesis: STRING = "("
			-- "(" character

	ti_Less_than: STRING = "<"
			-- "<" character

	ti_Less_equal: STRING = "<="
			-- "<=" characters

	ti_Question: STRING = "?"
			-- "'" characters

	ti_Quote: STRING = "'"
			-- "'" characters

	ti_R_array: STRING = ">>"
			-- ">>" characters

	ti_R_bracket: STRING = "]"
			-- "]" character

	ti_R_curly: STRING = "}"
			-- "}" character

	ti_R_parenthesis: STRING = ")"
			-- ")" character

	ti_Reverse_assign: STRING = "?="
			-- "?=" characters

	ti_Semi_colon: STRING = ";"
			-- ";" character

	ti_Tilda: STRING = "~"
			-- "~" character

	ti_For_all: STRING_32 = "∀"
			-- "∀" symbol.

	ti_There_exists: STRING_32 = "∃"
			-- "∃" symbol.

	ti_Broken_bar: STRING_32 = "¦"
			-- "¦" symbol.

feature -- Basic text

	ti_Padded_debug_mark: STRING = "    "
			-- Breakpoint item

	ti_New_line: STRING = "%N"
			-- "%N" character

	ti_Current: STRING = "Current"
			-- Breakpoint item

	ti_Result: STRING = "Result"
			-- Breakpoint item

	ti_Space: STRING = " "
			-- " " character

	ti_Tab1: STRING = "%T"
			-- 1 tab character

	ti_Tab2: STRING = "%T%T"
			-- 2 tab characters

	ti_Tab3: STRING = "%T%T%T"
			-- 3 tab characters

	ti_Tab4: STRING = "%T%T%T%T"
			-- 4 tab characters

	ti_Tab5: STRING = "%T%T%T%T%T"
			-- 5 tab characters

feature -- Difference items

	ti_Added: STRING = " + "
			-- Added text item

	ti_Modified: STRING = " | "
			-- Modified text item

	ti_No_diff: STRING = "   "
			-- Modified text item

	ti_Removed: STRING = " - "
			-- Removed text item

feature -- Feature signature items

	ti_Argument_index: STRING = "arg #"
			-- Index in argument list. Used for "like" <parameter>.

	ti_Generic_index: STRING = "Generic #"
			-- Index in formal generic parameter list.

feature -- Standard classes

	ti_None_class: STRING = "NONE"
			-- `NONE' class.

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
