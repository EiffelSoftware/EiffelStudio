indexing

	description: 
		"Shared text format items.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_TEXT_ITEMS

inherit

	SHARED_FILTER

feature {NONE} -- Filter marks

	ti_After_class_declaration: FILTER_ITEM is
			-- Mark of the end of class declaration
		once
			!!Result.make (f_Class_declaration);
			Result.set_after
		end;
	
	ti_After_class_end: FILTER_ITEM is
			-- Mark of the end of class end
		once
			!!Result.make (f_Class_end);
			Result.set_after
		end;
	
	ti_After_class_header: FILTER_ITEM is
			-- Mark of the end of class header
		once
			!!Result.make (f_Class_header);
			Result.set_after
		end;
	
	ti_After_creators: FILTER_ITEM is
			-- Mark of the end of creators
		once
			!!Result.make (f_Creators);
			Result.set_after
		end;
	
	ti_After_features: FILTER_ITEM is
			-- Mark of the end of features
		once
			!!Result.make (f_Features);
			Result.set_after
		end;
	
	ti_After_feature_clause: FILTER_ITEM is
			-- Mark of the end of feature clause
		once
			!!Result.make (f_Feature_clause);
			Result.set_after
		end;
	
	ti_After_feature_declaration: FILTER_ITEM is
			-- Mark of the end of feature declaration
		once
			!!Result.make (f_Feature_declaration);
			Result.set_after
		end;
	
	ti_After_formal_generics: FILTER_ITEM is
			-- Mark of the end of formal generics
		once
			!!Result.make (f_Formal_generics);
			Result.set_after
		end;
	
	ti_After_indexing: FILTER_ITEM is
			-- Mark of the end of indexing
		once
			!!Result.make (f_Indexing);
			Result.set_after
		end;
	
	ti_After_inheritance: FILTER_ITEM is
			-- Mark of the end of inheritance
		once
			!!Result.make (f_Inheritance);
			Result.set_after
		end;
	
	ti_After_invariant: FILTER_ITEM is
			-- Mark of the end of invariant
		once
			!!Result.make (f_Invariant);
			Result.set_after
		end;
	
	ti_After_obsolete: FILTER_ITEM is
			-- Mark of the end of obsolete
		once
			!!Result.make (f_Obsolete);
			Result.set_after
		end;
	
	ti_Before_class_declaration: FILTER_ITEM is
			-- Mark of the beginning of class declaration
		once
			!!Result.make (f_Class_declaration);
			Result.set_before
		end;
	
	ti_Before_class_end: FILTER_ITEM is
			-- Mark of the beginning of class end
		once
			!!Result.make (f_Class_end);
			Result.set_before
		end;

	ti_Before_class_header: FILTER_ITEM is
			-- Mark of the beginning of class header
		once
			!!Result.make (f_Class_header);
			Result.set_before
		end;
	
	ti_Before_creators: FILTER_ITEM is
			-- Mark of the beginning of creators
		once
			!!Result.make (f_Creators);
			Result.set_before
		end;
	
	ti_Before_features: FILTER_ITEM is
			-- Mark of the beginning of features
		once
			!!Result.make (f_Features);
			Result.set_before
		end;
	
	ti_Before_feature_clause: FILTER_ITEM is
			-- Mark of the beginning of feature clause
		once
			!!Result.make (f_Feature_clause);
			Result.set_before
		end;
	
	ti_Before_feature_declaration: FILTER_ITEM is
			-- Mark of the beginning of feature declaration
		once
			!!Result.make (f_Feature_declaration);
			Result.set_before
		end;
	
	ti_Before_formal_generics: FILTER_ITEM is
			-- Mark of the beginning of formal generics
		once
			!!Result.make (f_Formal_generics);
			Result.set_before
		end;
	
	ti_Before_indexing: FILTER_ITEM is
			-- Mark of the beginning of indexing
		once
			!!Result.make (f_Indexing);
			Result.set_before
		end;
	
	ti_Before_inheritance: FILTER_ITEM is
			-- Mark of the beginning of inheritance
		once
			!!Result.make (f_Inheritance);
			Result.set_before
		end;
	
	ti_Before_invariant: FILTER_ITEM is
			-- Mark of the beginning of invariant
		once
			!!Result.make (f_Invariant);
			Result.set_before
		end;
	
	ti_Before_obsolete: FILTER_ITEM is
			-- Mark of the beginning of obsolete
		once
			!!Result.make (f_Obsolete);
			Result.set_before
		end;
	
feature {NONE} -- Keywords

	ti_Alias_keyword: BASIC_TEXT is
			-- "alias" keyword
		once
			!!Result.make ("alias");
			Result.set_is_keyword
		end;
	
	ti_All_keyword: BASIC_TEXT is
			-- "all" keyword
		once
			!!Result.make ("all");
			Result.set_is_keyword
		end;
	
	ti_As_keyword: BASIC_TEXT is
			-- "as" keyword
		once
			!!Result.make ("as");
			Result.set_is_keyword
		end;
	
	ti_Check_keyword: BASIC_TEXT is
			-- "check" keyword
		once
			!!Result.make ("check");
			Result.set_is_keyword
		end;
	
	ti_Class_keyword: BASIC_TEXT is
			-- "class" keyword
		once
			!!Result.make ("class");
			Result.set_is_keyword
		end;
	
	ti_Creation_keyword: BASIC_TEXT is
			-- "creation" keyword
		once
			!!Result.make ("creation");
			Result.set_is_keyword
		end;
	
	ti_Debug_keyword: BASIC_TEXT is
			-- "debug" keyword
		once
			!!Result.make ("debug");
			Result.set_is_keyword
		end;
	
	ti_Deferred_keyword: BASIC_TEXT is
			-- "deferred" keyword
		once
			!!Result.make ("deferred");
			Result.set_is_keyword
		end;
	
	ti_Do_keyword: BASIC_TEXT is
			-- "do" keyword
		once
			!!Result.make ("do");
			Result.set_is_keyword
		end;
	
	ti_Else_keyword: BASIC_TEXT is
			-- "else" keyword
		once
			!!Result.make ("else");
			Result.set_is_keyword
		end;
	
	ti_Elseif_keyword: BASIC_TEXT is
			-- "elseif" keyword
		once
			!!Result.make ("elseif");
			Result.set_is_keyword
		end;
	
	ti_End_keyword: BASIC_TEXT is
			-- "end" keyword
		once
			!!Result.make ("end");
			Result.set_is_keyword
		end;
	
	ti_Ensure_keyword: BASIC_TEXT is
			-- "ensure" keyword
		once
			!!Result.make ("ensure");
			Result.set_is_keyword
		end;
	
	ti_Expanded_keyword: BASIC_TEXT is
			-- "expanded" keyword
		once
			!!Result.make ("expanded");
			Result.set_is_keyword
		end;
	
	ti_Export_keyword: BASIC_TEXT is
			-- "export" keyword
		once
			!!Result.make ("export");
			Result.set_is_keyword
		end;
	
	ti_External_keyword: BASIC_TEXT is
			-- "external" keyword
		once
			!!Result.make ("external");
			Result.set_is_keyword
		end;
	
	ti_False_keyword: BASIC_TEXT is
			-- "false" keyword
		once
			!!Result.make ("false");
			Result.set_is_keyword
		end;
	
	ti_Feature_keyword: BASIC_TEXT is
			-- "feature" keyword
		once
			!!Result.make ("feature");
			Result.set_is_keyword
		end;
	
	ti_From_keyword: BASIC_TEXT is
			-- "from" keyword
		once
			!!Result.make ("from");
			Result.set_is_keyword
		end;
	
	ti_Frozen_keyword: BASIC_TEXT is
			-- "frozen" keyword
		once
			!!Result.make ("frozen");
			Result.set_is_keyword
		end;
	
	ti_If_keyword: BASIC_TEXT is
			-- "if" keyword
		once
			!!Result.make ("if");
			Result.set_is_keyword
		end;
	
	ti_Indexing_keyword: BASIC_TEXT is
			-- "indexing" keyword
		once
			!!Result.make ("indexing");
			Result.set_is_keyword
		end;
	
	ti_Infix_keyword: BASIC_TEXT is
			-- "infix" keyword
		once
			!!Result.make ("infix");
			Result.set_is_keyword
		end;
	
	ti_Inherit_keyword: BASIC_TEXT is
			-- "inherit" keyword
		once
			!!Result.make ("inherit");
			Result.set_is_keyword
		end;
	
	ti_Inspect_keyword: BASIC_TEXT is
			-- "inspect" keyword
		once
			!!Result.make ("inspect");
			Result.set_is_keyword
		end;
	
	ti_Interface_keyword: BASIC_TEXT is
			-- "interface" keyword (used in the short form)
		once
			!!Result.make ("interface");
			Result.set_is_keyword
		end;
	
	ti_Invariant_keyword: BASIC_TEXT is
			-- "invariant" keyword
		once
			!!Result.make ("invariant");
			Result.set_is_keyword
		end;
	
	ti_Is_keyword: BASIC_TEXT is
			-- "is" keyword
		once
			!!Result.make ("is");
			Result.set_is_keyword
		end;
	
	ti_Like_keyword: BASIC_TEXT is
			-- "like" keyword
		once
			!!Result.make ("like");
			Result.set_is_keyword
		end;
	
	ti_Local_keyword: BASIC_TEXT is
			-- "local" keyword
		once
			!!Result.make ("local");
			Result.set_is_keyword
		end;
	
	ti_Loop_keyword: BASIC_TEXT is
			-- "loop" keyword
		once
			!!Result.make ("loop");
			Result.set_is_keyword
		end;
	
	ti_Obsolete_keyword: BASIC_TEXT is
			-- "obsolete" keyword
		once
			!!Result.make ("obsolete");
			Result.set_is_keyword
		end;

	ti_Old_keyword: BASIC_TEXT is
			-- "old" keyword
		once
			!!Result.make ("old");
			Result.set_is_keyword
		end;
	
	ti_Once_keyword: BASIC_TEXT is
			-- "once" keyword
		once
			!!Result.make ("once");
			Result.set_is_keyword
		end;
	
	ti_Prefix_keyword: BASIC_TEXT is
			-- "prefix" keyword
		once
			!!Result.make ("prefix");
			Result.set_is_keyword
		end;
	
	ti_Redefine_keyword: BASIC_TEXT is
			-- "redefine" keyword
		once
			!!Result.make ("redefine");
			Result.set_is_keyword
		end;
	
	ti_Rename_keyword: BASIC_TEXT is
			-- "rename" keyword
		once
			!!Result.make ("rename");
			Result.set_is_keyword
		end;
	
	ti_Require_keyword: BASIC_TEXT is
			-- "require" keyword
		once
			!!Result.make ("require");
			Result.set_is_keyword
		end;
	
	ti_Rescue_keyword: BASIC_TEXT is
			-- "rescue" keyword
		once
			!!Result.make ("rescue");
			Result.set_is_keyword
		end;
	
	ti_Retry_keyword: BASIC_TEXT is
			-- "retry" keyword
		once
			!!Result.make ("retry");
			Result.set_is_keyword
		end;
	
	ti_Select_keyword: BASIC_TEXT is
			-- "select" keyword
		once
			!!Result.make ("select");
			Result.set_is_keyword
		end;
	
	ti_Strip_keyword: BASIC_TEXT is
			-- "strip" keyword
		once
			!!Result.make ("strip");
			Result.set_is_keyword
		end;
	
	ti_Then_keyword: BASIC_TEXT is
			-- "then" keyword
		once
			!!Result.make ("then");
			Result.set_is_keyword
		end;
	
	ti_True_keyword: BASIC_TEXT is
			-- "true" keyword
		once
			!!Result.make ("true");
			Result.set_is_keyword
		end;
	
	ti_Undefine_keyword: BASIC_TEXT is
			-- "undefine" keyword
		once
			!!Result.make ("undefine");
			Result.set_is_keyword
		end;
	
	ti_Unique_keyword: BASIC_TEXT is
			-- "unique" keyword
		once
			!!Result.make ("unique");
			Result.set_is_keyword
		end;
	
	ti_Until_keyword: BASIC_TEXT is
			-- "until" keyword
		once
			!!Result.make ("until");
			Result.set_is_keyword
		end;
	
	ti_Variant_keyword: BASIC_TEXT is
			-- "variant" keyword
		once
			!!Result.make ("variant");
			Result.set_is_keyword
		end;
	
	ti_When_keyword: BASIC_TEXT is
			-- "when" keyword
		once
			!!Result.make ("when");
			Result.set_is_keyword
		end;
	
feature {NONE} -- Special characters

	ti_Assign: BASIC_TEXT is
			-- ":=" characters
		once
			!!Result.make (":=");
			Result.set_is_special
		end;

	ti_Colon: BASIC_TEXT is
			-- ":" character
		once
			!!Result.make (":");
			Result.set_is_special
		end;

	ti_Comma: BASIC_TEXT is
			-- "," character
		once
			!!Result.make (",");
			Result.set_is_special
		end;

	ti_Constraint: BASIC_TEXT is
			-- "->" characters
		once
			!!Result.make ("->");
			Result.set_is_special
		end;

	ti_Creation_mark: BASIC_TEXT is
			-- "!!" characters
		once
			!!Result.make ("!!");
			Result.set_is_special
		end;

	ti_Dashdash: BASIC_TEXT is
			-- "--" characters
		once
			!!Result.make ("--");
			Result.set_is_special
		end;

	ti_Dollar: BASIC_TEXT is
			-- "$" character
		once
			!!Result.make ("$");
			Result.set_is_special
		end;

	ti_Dot: BASIC_TEXT is
			-- "." character
		once
			!!Result.make (".");
			Result.set_is_special
		end;

	ti_Dotdot: BASIC_TEXT is
			-- ".." characters
		once
			!!Result.make ("..");
			Result.set_is_special
		end;

	ti_Double_quote: BASIC_TEXT is
			-- '"' character
		once
			!!Result.make ("%"");
			Result.set_is_special
		end;

	ti_Equal: BASIC_TEXT is
			-- "=" character
		once
			!!Result.make ("=");
			Result.set_is_special
		end;

	ti_Exclamation: BASIC_TEXT is
			-- "!" character
		once
			!!Result.make ("!");
			Result.set_is_special
		end;

	ti_Greater_than: BASIC_TEXT is
			-- ">" character
		once
			!!Result.make (">");
			Result.set_is_special
		end;

	ti_Greater_equal: BASIC_TEXT is
			-- ">=" characters
		once
			!!Result.make (">=");
			Result.set_is_special
		end;

	ti_L_array: BASIC_TEXT is
			-- "<<" characters
		once
			!!Result.make ("<<");
			Result.set_is_special
		end;

	ti_L_bracket: BASIC_TEXT is
			-- "[" character
		once
			!!Result.make ("[");
			Result.set_is_special
		end;

	ti_L_curly: BASIC_TEXT is
			-- "{" character
		once
			!!Result.make ("{");
			Result.set_is_special
		end;

	ti_L_parenthesis: BASIC_TEXT is
			-- "(" character
		once
			!!Result.make ("(");
			Result.set_is_special
		end;

	ti_Less_than: BASIC_TEXT is
			-- "<" character
		once
			!!Result.make ("<");
			Result.set_is_special
		end;

	ti_Less_equal: BASIC_TEXT is
			-- "<=" characters
		once
			!!Result.make ("<=");
			Result.set_is_special
		end;

	ti_New_line: NEW_LINE_ITEM is
			-- "%N" character
		once
			!! Result.make
		end;

	ti_Padded_debug_mark: BASIC_TEXT is
			-- Breakpoint item 
		once
			!! Result.make ("    ")
		end;

	ti_Quote: BASIC_TEXT is
			-- "'" characters
		once
			!!Result.make ("%'");
			Result.set_is_special
		end;

	ti_R_array: BASIC_TEXT is
			-- ">>" characters
		once
			!!Result.make (">>");
			Result.set_is_special
		end;

	ti_R_bracket: BASIC_TEXT is
			-- "]" character
		once
			!!Result.make ("]");
			Result.set_is_special
		end;

	ti_R_curly: BASIC_TEXT is
			-- "}" character
		once
			!!Result.make ("}");
			Result.set_is_special
		end;

	ti_R_parenthesis: BASIC_TEXT is
			-- ")" character
		once
			!!Result.make (")");
			Result.set_is_special
		end;

	ti_Reverse_assign: BASIC_TEXT is
			-- "?=" characters
		once
			!!Result.make ("?=");
			Result.set_is_special
		end;

	ti_Semi_colon: BASIC_TEXT is
			-- ";" character
		once
			!!Result.make (";");
			Result.set_is_special
		end;

feature {NONE} -- Basic text

	ti_Breakpoint: BREAKPOINT_ITEM is
			-- Breakpoint item 
		once
			!! Result
		end;

	ti_Current: BASIC_TEXT is
			-- Breakpoint item 
		once
			!! Result.make ("Current")
		end;

	ti_Result: BASIC_TEXT is
			-- Breakpoint item 
		once
			!! Result.make ("Result")
		end;

	ti_Space: BASIC_TEXT is
			-- " " character
		once
			!!Result.make (" ")
		end;

	ti_Tab1: INDENT_TEXT is
			-- 1 tab character
		once
			!!Result.make (1)
		end;

	ti_Tab2: INDENT_TEXT is
			-- 2 tab characters
		once
			!!Result.make (2)
		end;

	ti_Tab3: INDENT_TEXT is
			-- 3 tab characters
		once
			!!Result.make (3)
		end;

	ti_Tab4: INDENT_TEXT is
			-- 4 tab characters
		once
			!!Result.make (4)
		end;

	ti_Tab5: INDENT_TEXT is
			-- 5 tab characters
		once
			!!Result.make (5);
		end;

end -- class SHARED_TEXT_ITEMS
