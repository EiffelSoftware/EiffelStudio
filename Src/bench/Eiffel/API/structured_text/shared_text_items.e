indexing

	description:
		"Shared text format items."
	date: "$Date$"
	revision: "$Revision $"

class SHARED_TEXT_ITEMS

inherit

	SHARED_FILTER

feature {NONE} -- Filter marks

	ti_After_class_declaration: FILTER_ITEM is
			-- Mark of the end of class declaration
		once
			!!Result.make (f_Class_declaration)
			Result.set_after
		end

	ti_After_class_end: FILTER_ITEM is
			-- Mark of the end of class end
		once
			!!Result.make (f_Class_end)
			Result.set_after
		end

	ti_After_class_header: FILTER_ITEM is
			-- Mark of the end of class header
		once
			!!Result.make (f_Class_header)
			Result.set_after
		end

	ti_After_cluster_declaration: FILTER_ITEM is
			-- Mark of the end of cluster declaration
		once
			!!Result.make (f_Cluster_declaration)
			Result.set_after
		end

	ti_After_cluster_header: FILTER_ITEM is
			-- Mark of the end of cluster header
		once
			!!Result.make (f_Cluster_header)
			Result.set_after
		end

	ti_After_creators: FILTER_ITEM is
			-- Mark of the end of creators
		once
			!!Result.make (f_Creators)
			Result.set_after
		end

	ti_After_features: FILTER_ITEM is
			-- Mark of the end of features
		once
			!!Result.make (f_Features)
			Result.set_after
		end

	ti_After_feature_clause: FILTER_ITEM is
			-- Mark of the end of feature clause
		once
			!!Result.make (f_Feature_clause)
			Result.set_after
		end

	ti_After_feature_declaration: FILTER_ITEM is
			-- Mark of the end of feature declaration
		once
			!!Result.make (f_Feature_declaration)
			Result.set_after
		end

	ti_After_formal_generics: FILTER_ITEM is
			-- Mark of the end of formal generics
		once
			!!Result.make (f_Formal_generics)
			Result.set_after
		end

	ti_After_indexing: FILTER_ITEM is
			-- Mark of the end of indexing
		once
			!!Result.make (f_Indexing)
			Result.set_after
		end

	ti_After_inheritance: FILTER_ITEM is
			-- Mark of the end of inheritance
		once
			!!Result.make (f_Inheritance)
			Result.set_after
		end

	ti_After_invariant: FILTER_ITEM is
			-- Mark of the end of invariant
		once
			!!Result.make (f_Invariant)
			Result.set_after
		end

	ti_After_obsolete: FILTER_ITEM is
			-- Mark of the end of obsolete
		once
			!!Result.make (f_Obsolete)
			Result.set_after
		end

	ti_Before_class_declaration: FILTER_ITEM is
			-- Mark of the beginning of class declaration
		once
			!!Result.make (f_Class_declaration)
			Result.set_before
		end

	ti_Before_class_end: FILTER_ITEM is
			-- Mark of the beginning of class end
		once
			!!Result.make (f_Class_end)
			Result.set_before
		end

	ti_Before_class_header: FILTER_ITEM is
			-- Mark of the beginning of class header
		once
			!!Result.make (f_Class_header)
			Result.set_before
		end

	ti_Before_cluster_declaration: FILTER_ITEM is
			-- Mark of the beginning of cluster declaration
		once
			!!Result.make (f_Cluster_declaration)
			Result.set_before
		end

	ti_Before_cluster_header: FILTER_ITEM is
			-- Mark of the beginning of cluster header
		once
			!!Result.make (f_Cluster_header)
			Result.set_before
		end

	ti_Before_creators: FILTER_ITEM is
			-- Mark of the beginning of creators
		once
			!!Result.make (f_Creators)
			Result.set_before
		end

	ti_Before_features: FILTER_ITEM is
			-- Mark of the beginning of features
		once
			!!Result.make (f_Features)
			Result.set_before
		end

	ti_Before_feature_clause: FILTER_ITEM is
			-- Mark of the beginning of feature clause
		once
			!!Result.make (f_Feature_clause)
			Result.set_before
		end

	ti_Before_feature_declaration: FILTER_ITEM is
			-- Mark of the beginning of feature declaration
		once
			!!Result.make (f_Feature_declaration)
			Result.set_before
		end

	ti_Before_formal_generics: FILTER_ITEM is
			-- Mark of the beginning of formal generics
		once
			!!Result.make (f_Formal_generics)
			Result.set_before
		end

	ti_Before_indexing: FILTER_ITEM is
			-- Mark of the beginning of indexing
		once
			!!Result.make (f_Indexing)
			Result.set_before
		end

	ti_Before_inheritance: FILTER_ITEM is
			-- Mark of the beginning of inheritance
		once
			!!Result.make (f_Inheritance)
			Result.set_before
		end

	ti_Before_invariant: FILTER_ITEM is
			-- Mark of the beginning of invariant
		once
			!!Result.make (f_Invariant)
			Result.set_before
		end

	ti_Before_obsolete: FILTER_ITEM is
			-- Mark of the beginning of obsolete
		once
			!!Result.make (f_Obsolete)
			Result.set_before
		end

feature {NONE} -- Keywords

	ti_Alias_keyword: KEYWORD_TEXT is
			-- "alias" keyword
		once
			!!Result.make ("alias")
		end

	ti_All_keyword: KEYWORD_TEXT is
			-- "all" keyword
		once
			!!Result.make ("all")
		end

	ti_As_keyword: KEYWORD_TEXT is
			-- "as" keyword
		once
			!!Result.make ("as")
		end

	ti_Check_keyword: KEYWORD_TEXT is
			-- "check" keyword
		once
			!!Result.make ("check")
		end

	ti_Class_keyword: KEYWORD_TEXT is
			-- "class" keyword
		once
			!!Result.make ("class")
		end

	ti_Create_keyword: KEYWORD_TEXT is
			-- "create" keyword
		once
			!! Result.make ("create")
		end

	ti_Debug_keyword: KEYWORD_TEXT is
			-- "debug" keyword
		once
			!!Result.make ("debug")
		end

	ti_Deferred_keyword: KEYWORD_TEXT is
			-- "deferred" keyword
		once
			!!Result.make ("deferred")
		end

	ti_Do_keyword: KEYWORD_TEXT is
			-- "do" keyword
		once
			!!Result.make ("do")
		end

	ti_Else_keyword: KEYWORD_TEXT is
			-- "else" keyword
		once
			!!Result.make ("else")
		end

	ti_Elseif_keyword: KEYWORD_TEXT is
			-- "elseif" keyword
		once
			!!Result.make ("elseif")
		end

	ti_End_keyword: KEYWORD_TEXT is
			-- "end" keyword
		once
			!!Result.make ("end")
		end

	ti_Ensure_keyword: KEYWORD_TEXT is
			-- "ensure" keyword
		once
			!!Result.make ("ensure")
		end

	ti_Expanded_keyword: KEYWORD_TEXT is
			-- "expanded" keyword
		once
			!!Result.make ("expanded")
		end

	ti_Export_keyword: KEYWORD_TEXT is
			-- "export" keyword
		once
			!!Result.make ("export")
		end

	ti_External_keyword: KEYWORD_TEXT is
			-- "external" keyword
		once
			!!Result.make ("external")
		end

	ti_False_keyword: KEYWORD_TEXT is
			-- "false" keyword
		once
			!!Result.make ("False")
		end

	ti_Feature_keyword: KEYWORD_TEXT is
			-- "feature" keyword
		once
			!!Result.make ("feature")
		end

	ti_From_keyword: KEYWORD_TEXT is
			-- "from" keyword
		once
			!!Result.make ("from")
		end

	ti_Frozen_keyword: KEYWORD_TEXT is
			-- "frozen" keyword
		once
			!!Result.make ("frozen")
		end

	ti_If_keyword: KEYWORD_TEXT is
			-- "if" keyword
		once
			!!Result.make ("if")
		end

	ti_Indexing_keyword: KEYWORD_TEXT is
			-- "indexing" keyword
		once
			!!Result.make ("indexing")
		end

	ti_Infix_keyword: KEYWORD_TEXT is
			-- "infix" keyword
		once
			!!Result.make ("infix")
		end

	ti_Inherit_keyword: KEYWORD_TEXT is
			-- "inherit" keyword
		once
			!!Result.make ("inherit")
		end

	ti_Inspect_keyword: KEYWORD_TEXT is
			-- "inspect" keyword
		once
			!!Result.make ("inspect")
		end

	ti_Interface_keyword: KEYWORD_TEXT is
			-- "interface" keyword (used in the short form)
		once
			!!Result.make ("interface")
		end

	ti_Invariant_keyword: KEYWORD_TEXT is
			-- "invariant" keyword
		once
			!!Result.make ("invariant")
		end

	ti_Is_keyword: KEYWORD_TEXT is
			-- "is" keyword
		once
			!!Result.make ("is")
		end

	ti_Like_keyword: KEYWORD_TEXT is
			-- "like" keyword
		once
			!!Result.make ("like")
		end

	ti_Local_keyword: KEYWORD_TEXT is
			-- "local" keyword
		once
			!!Result.make ("local")
		end

	ti_Loop_keyword: KEYWORD_TEXT is
			-- "loop" keyword
		once
			!!Result.make ("loop")
		end

	ti_Obsolete_keyword: KEYWORD_TEXT is
			-- "obsolete" keyword
		once
			!!Result.make ("obsolete")
		end

	ti_Old_keyword: KEYWORD_TEXT is
			-- "old" keyword
		once
			!!Result.make ("old")
		end

	ti_Once_keyword: KEYWORD_TEXT is
			-- "once" keyword
		once
			!!Result.make ("once")
		end

	ti_Precursor_keyword: KEYWORD_TEXT is
			-- "precursor" keyword
		once
			!!Result.make ("Precursor")
		end

	ti_Prefix_keyword: KEYWORD_TEXT is
			-- "prefix" keyword
		once
			!!Result.make ("prefix")
		end

	ti_Redefine_keyword: KEYWORD_TEXT is
			-- "redefine" keyword
		once
			!!Result.make ("redefine")
		end

	ti_Rename_keyword: KEYWORD_TEXT is
			-- "rename" keyword
		once
			!!Result.make ("rename")
		end

	ti_Require_keyword: KEYWORD_TEXT is
			-- "require" keyword
		once
			!!Result.make ("require")
		end

	ti_Rescue_keyword: KEYWORD_TEXT is
			-- "rescue" keyword
		once
			!!Result.make ("rescue")
		end

	ti_Retry_keyword: KEYWORD_TEXT is
			-- "retry" keyword
		once
			!!Result.make ("retry")
		end

	ti_Select_keyword: KEYWORD_TEXT is
			-- "select" keyword
		once
			!!Result.make ("select")
		end

	ti_Separate_keyword: KEYWORD_TEXT is
			-- "separate" keyword
		once
			!!Result.make ("separate")
		end

	ti_Strip_keyword: KEYWORD_TEXT is
			-- "strip" keyword
		once
			!!Result.make ("strip")
		end

	ti_Then_keyword: KEYWORD_TEXT is
			-- "then" keyword
		once
			!!Result.make ("then")
		end

	ti_True_keyword: KEYWORD_TEXT is
			-- "true" keyword
		once
			!!Result.make ("True")
		end

	ti_Undefine_keyword: KEYWORD_TEXT is
			-- "undefine" keyword
		once
			!!Result.make ("undefine")
		end

	ti_Unique_keyword: KEYWORD_TEXT is
			-- "unique" keyword
		once
			!!Result.make ("unique")
		end

	ti_Until_keyword: KEYWORD_TEXT is
			-- "until" keyword
		once
			!!Result.make ("until")
		end

	ti_Variant_keyword: KEYWORD_TEXT is
			-- "variant" keyword
		once
			!!Result.make ("variant")
		end

	ti_When_keyword: KEYWORD_TEXT is
			-- "when" keyword
		once
			!!Result.make ("when")
		end

feature {NONE} -- Symbol names

	ti_Assign: SYMBOL_TEXT is
			-- ":=" characters
		once
			!!Result.make (":=")
		end

	ti_Colon: SYMBOL_TEXT is
			-- ":" character
		once
			!!Result.make (":")
		end

	ti_Comma: SYMBOL_TEXT is
			-- "," character
		once
			!!Result.make (",")
		end

	ti_Constraint: SYMBOL_TEXT is
			-- "->" characters
		once
			!!Result.make ("->")
		end

	ti_Dashdash: SYMBOL_TEXT is
			-- "--" characters
		once
			!!Result.make ("--")
		end

	ti_Dollar: SYMBOL_TEXT is
			-- "$" character
		once
			!!Result.make ("$")
		end

	ti_Dot: SYMBOL_TEXT is
			-- "." character
		once
			!!Result.make (".")
		end

	ti_Dotdot: SYMBOL_TEXT is
			-- ".." characters
		once
			!!Result.make ("..")
		end

	ti_Double_quote: SYMBOL_TEXT is
			-- '"' character
		once
			!!Result.make ("%"")
		end

	ti_Empty: SYMBOL_TEXT is
			-- Empty character
		once
			!!Result.make ("")
		end

	ti_Equal: SYMBOL_TEXT is
			-- "=" character
		once
			!!Result.make ("=")
		end

	ti_Exclamation: SYMBOL_TEXT is
			-- "!" character
		once
			!!Result.make ("!")
		end

	ti_Greater_than: SYMBOL_TEXT is
			-- ">" character
		once
			!!Result.make (">")
		end

	ti_Greater_equal: SYMBOL_TEXT is
			-- ">=" characters
		once
			!!Result.make (">=")
		end

	ti_L_array: SYMBOL_TEXT is
			-- "<<" characters
		once
			!!Result.make ("<<")
		end

	ti_L_bracket: SYMBOL_TEXT is
			-- "[" character
		once
			!!Result.make ("[")
		end

	ti_L_curly: SYMBOL_TEXT is
			-- "{" character
		once
			!!Result.make ("{")
		end

	ti_L_parenthesis: SYMBOL_TEXT is
			-- "(" character
		once
			!!Result.make ("(")
		end

	ti_Less_than: SYMBOL_TEXT is
			-- "<" character
		once
			!!Result.make ("<")
		end

	ti_Less_equal: SYMBOL_TEXT is
			-- "<=" characters
		once
			!!Result.make ("<=")
		end

	ti_Question: SYMBOL_TEXT is
			-- "'" characters
		once
			!!Result.make ("?")
		end

	ti_Quote: SYMBOL_TEXT is
			-- "'" characters
		once
			!!Result.make ("%'")
		end

	ti_R_array: SYMBOL_TEXT is
			-- ">>" characters
		once
			!!Result.make (">>")
		end

	ti_R_bracket: SYMBOL_TEXT is
			-- "]" character
		once
			!!Result.make ("]")
		end

	ti_R_curly: SYMBOL_TEXT is
			-- "}" character
		once
			!!Result.make ("}")
		end

	ti_R_parenthesis: SYMBOL_TEXT is
			-- ")" character
		once
			!!Result.make (")")
		end

	ti_Reverse_assign: SYMBOL_TEXT is
			-- "?=" characters
		once
			!!Result.make ("?=")
		end

	ti_Semi_colon: SYMBOL_TEXT is
			-- ";" character
		once
			!!Result.make (";")
		end

	ti_Tilda: SYMBOL_TEXT is
			-- "~" character
		once
			!!Result.make ("~")
		end

feature {NONE} -- Basic text

	ti_Padded_debug_mark: PADDED_ITEM is
			-- Breakpoint item
		once
			!! Result
		end

	ti_New_line: NEW_LINE_ITEM is
			-- "%N" character
		once
			!! Result.make
		end

	ti_Current: BASIC_TEXT is
			-- Breakpoint item
		once
			!! Result.make ("Current")
		end

	ti_Result: BASIC_TEXT is
			-- Breakpoint item
		once
			!! Result.make ("Result")
		end

	ti_Space: BASIC_TEXT is
			-- " " character
		once
			!!Result.make (" ")
		end

	ti_Tab1: INDENT_TEXT is
			-- 1 tab character
		once
			!!Result.make (1)
		end

	ti_Tab2: INDENT_TEXT is
			-- 2 tab characters
		once
			!!Result.make (2)
		end

	ti_Tab3: INDENT_TEXT is
			-- 3 tab characters
		once
			!!Result.make (3)
		end

	ti_Tab4: INDENT_TEXT is
			-- 4 tab characters
		once
			!!Result.make (4)
		end

	ti_Tab5: INDENT_TEXT is
			-- 5 tab characters
		once
			!!Result.make (5)
		end

feature {NONE} -- Difference items

	ti_Added: DIFFERENCE_TEXT_ITEM is
			-- Added text item
		once
			!! Result.make (" + ")
		end

	ti_Modified: DIFFERENCE_TEXT_ITEM is
			-- Modified text item
		once
			!! Result.make (" | ")
		end

	ti_No_diff: DIFFERENCE_TEXT_ITEM is
			-- Modified text item
		once
			!! Result.make ("   ")
		end

	ti_Removed: DIFFERENCE_TEXT_ITEM is
			-- Removed text item
		once
			!! Result.make (" - ")
		end

end -- class SHARED_TEXT_ITEMS
