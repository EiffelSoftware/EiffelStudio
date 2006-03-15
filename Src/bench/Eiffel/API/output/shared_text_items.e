indexing
	description	: "Shared text format items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class SHARED_TEXT_ITEMS

inherit
	SHARED_FILTER

feature {NONE} -- Keywords

	ti_and_keyword: STRING is "and"
			-- "and" keyword

	ti_and_then_keyword: STRING is "and then"
			-- "and then" keyword

	ti_Agent_keyword: STRING is "agent"
			-- "agent" keyword

	ti_Alias_keyword: STRING is "alias"
			-- "alias" keyword

	ti_All_keyword: STRING is "all"
			-- "all" keyword

	ti_As_keyword: STRING is "as"
			-- "as" keyword

	ti_Assign_keyword: STRING is "assign"
			-- "as" keyword

	ti_Check_keyword: STRING is "check"
			-- "check" keyword

	ti_Class_keyword: STRING is "class"
			-- "class" keyword

	ti_convert_keyword: STRING is "convert"
			-- "convert" keyword

	ti_Create_keyword: STRING is "create"
			-- "create" keyword

	ti_Debug_keyword: STRING is "debug"
			-- "debug" keyword

	ti_Deferred_keyword: STRING is "deferred"
			-- "deferred" keyword

	ti_Do_keyword: STRING is "do"
			-- "do" keyword

	ti_Else_keyword: STRING is "else"
			-- "else" keyword

	ti_Elseif_keyword: STRING is "elseif"
			-- "elseif" keyword

	ti_End_keyword: STRING is "end"
			-- "end" keyword

	ti_Ensure_keyword: STRING is "ensure"
			-- "ensure" keyword

	ti_ensure_then_keyword: STRING is "ensure then"
			-- "ensure then" keyword

	ti_Expanded_keyword: STRING is "expanded"
			-- "expanded" keyword

	ti_Export_keyword: STRING is "export"
			-- "export" keyword

	ti_External_keyword: STRING is "external"
			-- "external" keyword

	ti_False_keyword: STRING is "False"
			-- "false" keyword

	ti_Feature_keyword: STRING is "feature"
			-- "feature" keyword

	ti_From_keyword: STRING is "from"
			-- "from" keyword

	ti_Frozen_keyword: STRING is "frozen"
			-- "frozen" keyword

	ti_If_keyword: STRING is "if"
			-- "if" keyword

	ti_implies_keyword: STRING is "implies"
			-- "implies" keyword

	ti_Indexing_keyword: STRING is "indexing"
			-- "indexing" keyword

	ti_Infix_keyword: STRING is "infix"
			-- "infix" keyword

	ti_Inherit_keyword: STRING is "inherit"
			-- "inherit" keyword

	ti_Inspect_keyword: STRING is "inspect"
			-- "inspect" keyword

	ti_Interface_keyword: STRING is "interface"
			-- "interface" keyword (used in the short form)

	ti_Invariant_keyword: STRING is "invariant"
			-- "invariant" keyword

	ti_Is_keyword: STRING is "is"
			-- "is" keyword

	ti_Like_keyword: STRING is "like"
			-- "like" keyword

	ti_Local_keyword: STRING is "local"
			-- "local" keyword

	ti_Loop_keyword: STRING is "loop"
			-- "loop" keyword

	ti_not_keyword: STRING is "not"
			-- "not" keyword

	ti_Obsolete_keyword: STRING is "obsolete"
			-- "obsolete" keyword

	ti_Old_keyword: STRING is "old"
			-- "old" keyword

	ti_Once_keyword: STRING is "once"
			-- "once" keyword

	ti_or_keyword: STRING is "or"
			-- "or" keyword

	ti_or_else_keyword: STRING is "or else"
			-- "or else" keyword

	ti_Precursor_keyword: STRING is "Precursor"
			-- "precursor" keyword

	ti_Prefix_keyword: STRING is "prefix"
			-- "prefix" keyword

	ti_Redefine_keyword: STRING is "redefine"
			-- "redefine" keyword

	ti_Reference_keyword: STRING is "reference"
			-- "reference" keyword

	ti_Rename_keyword: STRING is "rename"
			-- "rename" keyword

	ti_Require_keyword: STRING is "require"
			-- "require" keyword

	ti_require_else_keyword: STRING is "require else"
			-- "require else" keyword

	ti_Rescue_keyword: STRING is "rescue"
			-- "rescue" keyword

	ti_Retry_keyword: STRING is "retry"
			-- "retry" keyword

	ti_Select_keyword: STRING is "select"
			-- "select" keyword

	ti_Separate_keyword: STRING is "separate"
			-- "separate" keyword

	ti_Strip_keyword: STRING is "strip"
			-- "strip" keyword

	ti_Then_keyword: STRING is "then"
			-- "then" keyword

	ti_True_keyword: STRING is "True"
			-- "true" keyword

	ti_Undefine_keyword: STRING is "undefine"
			-- "undefine" keyword

	ti_Unique_keyword: STRING is "unique"
			-- "unique" keyword

	ti_Until_keyword: STRING is "until"
			-- "until" keyword

	ti_Variant_keyword: STRING is "variant"
			-- "variant" keyword

	ti_void: STRING is "Void"
			-- `Void' feature.

	ti_When_keyword: STRING is "when"
			-- "when" keyword

	ti_xor_keyword: STRING is "xor"
			-- "xor" keyword

feature {NONE} -- Symbol names

	ti_Assign: STRING is ":="
			-- ":=" characters

	ti_Colon: STRING is ":"
			-- ":" character

	ti_Comma: STRING is ","
			-- "," character

	ti_Constraint: STRING is "->"
			-- "->" characters

	ti_Dashdash: STRING is "--"
			-- "--" characters

	ti_Dollar: STRING is "$"
			-- "$" character

	ti_Dot: STRING is "."
			-- "." character

	ti_Dotdot: STRING is ".."
			-- ".." characters

	ti_Double_quote: STRING is "%""
			-- '"' character

	ti_Empty: STRING is ""
			-- Empty character

	ti_Equal: STRING is "="
			-- "=" character

	ti_Exclamation: STRING is "!"
			-- "!" character

	ti_Greater_than: STRING is ">"
			-- ">" character

	ti_Greater_equal: STRING is ">="
			-- ">=" characters

	ti_L_array: STRING is "<<"
			-- "<<" characters

	ti_L_bracket: STRING is "["
			-- "[" character

	ti_L_curly: STRING is "{"
			-- "{" character

	ti_L_parenthesis: STRING is "("
			-- "(" character

	ti_Less_than: STRING is "<"
			-- "<" character

	ti_Less_equal: STRING is "<="
			-- "<=" characters

	ti_Question: STRING is "?"
			-- "'" characters

	ti_Quote: STRING is "%'"
			-- "'" characters

	ti_R_array: STRING is ">>"
			-- ">>" characters

	ti_R_bracket: STRING is "]"
			-- "]" character

	ti_R_curly: STRING is "}"
			-- "}" character

	ti_R_parenthesis: STRING is ")"
			-- ")" character

	ti_Reverse_assign: STRING is "?="
			-- "?=" characters

	ti_Semi_colon: STRING is ";"
			-- ";" character

	ti_Tilda: STRING is "~"
			-- "~" character

feature {NONE} -- Basic text

	ti_Padded_debug_mark: STRING is "    "
			-- Breakpoint item

	ti_New_line: STRING is "%N"
			-- "%N" character

	ti_Current: STRING is "Current"
			-- Breakpoint item

	ti_Result: STRING is "Result"
			-- Breakpoint item

	ti_Space: STRING is " "
			-- " " character

	ti_Tab1: STRING is "%T"
			-- 1 tab character

	ti_Tab2: STRING is "%T%T"
			-- 2 tab characters

	ti_Tab3: STRING is "%T%T%T"
			-- 3 tab characters

	ti_Tab4: STRING is "%T%T%T%T"
			-- 4 tab characters

	ti_Tab5: STRING is "%T%T%T%T%T"
			-- 5 tab characters

feature {NONE} -- Difference items

	ti_Added: STRING is " + "
			-- Added text item

	ti_Modified: STRING is " | "
			-- Modified text item

	ti_No_diff: STRING is "   "
			-- Modified text item

	ti_Removed: STRING is " - "
			-- Removed text item

feature {NONE} -- Feature signature items

	ti_Argument_index: STRING is "arg #"
			-- Index in argument list. Used for "like" <parameter>.

	ti_Generic_index: STRING is "Generic #"
			-- Index in formal generic parameter list.

	ti_Open_arg: STRING is "Open argument"
			-- Index in open arguments parameter list.

feature {NONE} -- Standard classes

	ti_Unevaluable_type: STRING is "Unevaluable type"

	ti_None_class: STRING is "NONE"
			-- `NONE' class.

	ti_Bit_class: STRING is "BIT";
			-- `BIT' class.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SHARED_TEXT_ITEMS
