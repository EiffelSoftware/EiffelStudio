indexing
        description: "Lexical interface class for the resource script language"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_SCRIPT_LEX 
	
inherit
	L_INTERFACE
		redefine 
			build
		end

	LEX_CONSTANTS
		undefine
			consistent, copy, is_equal, setup
		end

feature {NONE}

	build (doc: INPUT) is
			-- Create lexical analyzer and set `doc'
			-- to be the input document.
		do
			make_extended (255)
			obtain_analyzer
			make_analyzer
			doc.set_lexical (analyzer)
		end

	obtain_analyzer is
			-- Create lexical analyzer for the resource sript language
		do
			error_list.do_not_display_message
			ignore_case
			keywords_ignore_case
			build_expressions
			build_keywords
			set_separator_type (Blanks)
		end

	build_expressions is
			-- Define regular expressions
			-- for the resource sript language
		do
			put_expression (blank_string, Blanks, "Blanks")
			put_expression (identifier_string, Identifier, "Identifier")
			put_expression ("'#' *('a'..'z')", Precompile_directives, "Precompile_directives")
			put_expression (" %"#pragma%" -> %"\n%" ", Nothing, "NOTHING")
                        	
			put_expression ("%"EXSTYLE=%"", Special_identifier, "Special_identifier")

			put_expression ("(%"||%" | '|' | %"OR%")", Or_op, "Or_op")

			put_expression ("(%"&&%" | '&' | %"AND%")", And_op,"And_op")

			put_expression ("'='", Equal_op, "Equal_op")
			put_expression ("%"<>%"", Not_equal, "Not_equal")
			put_expression ("'<'", Lt, "Lt")
			put_expression ("'>'", Gt, "Gt")
			put_expression ("%"<=%"", Le, "Le")
			put_expression ("%">=%"", Ge, "Ge")

			put_expression ("'+'", Add, "Add")
			put_expression ("'-'", Minus_op, "Minus_op")

			put_expression ("'*'", Mult, "Mult")
			put_expression ("'/'", Div, "Div")

			put_expression (" %"NOT%" | '~' | '!' ", Unary_not, "Unary_not")

			put_expression ("%"BEGIN%" | '{' ", Begin_block, "Begin_block")
			put_expression ("%"END%" | '}' ", End_block, "End_block")

			put_expression ("','", Ponctuation, "Ponctuation")

			put_expression (" '(' | ')' ", Parenthesis, "Parenthesis")

			put_expression (attributes_string, Attributes, "Attributes")

			put_expression (" %"EDITTEXT%" | %"COMBOBOX%" | %"LISTBOX%" ", Specific_control_statement, "Specific_control_statement")
		end 				

	identifier_string: STRING is
			-- contain the regular expression of identifiers
		once
			!! Result.make (150)

			Result.append (" *(('a'..'z') | '_' | '.' | ('0'..'9')) | ")
			Result.append (" ('%"' *(($. - '\t' - '\n' - '\r' - '%"') | (%"\%"\%"%")) '%"') |")
			Result.append (" ('<' *(('a'..'z') | '_' | '.' | ('0'..'9')) '>') |")
			Result.append (" ('\'' *(('a'..'z') | '_' | '.' | ('0'..'9')) '\'') |")
			Result.append ("$Z")
		end

	attributes_string: STRING is
			-- contain the list of the LOAD_AND_MEM_ATTRIBUTES
		once
			!! Result.make (120)
			
			Result.append ("%"PRELOAD%" | %"LOADONCALL%" |")
			Result.append ("%"FIXED%" | %"MOVEABLE%" |")
			Result.append ("%"DISCARDABLE%" | %"PURE%" | %"IMPURE%" ")
		end

	blank_string: STRING is
			-- contain the blank character of the language
		once
			!! Result.make (120)

			Result.append (" +('\t'|'\n'|' ') |")
			Result.append (" (%"//%" -> %"\n%") |")
			Result.append (" (%"/*%" -> %"*/%")")
		end

	build_keywords is
			-- Define keywords (special symbols)
			-- for the resource sript language
		do
			put_keyword ("#define", Precompile_directives)
			put_keyword ("#elif", Precompile_directives)
			put_keyword ("#else", Precompile_directives)
			put_keyword ("#endif", Precompile_directives)
			put_keyword ("#if", Precompile_directives)
			put_keyword ("#ifdef", Precompile_directives)
			put_keyword ("#ifndef", Precompile_directives)
			put_keyword ("#include", Precompile_directives)
			put_keyword ("#undef", Precompile_directives)
			put_keyword ("#pragma", Precompile_directives)
			put_keyword ("defined", Identifier)
			put_keyword ("(", Parenthesis)
			put_keyword (")", Parenthesis)

			put_keyword ("ACCELERATORS", Identifier)
			put_keyword ("ANICURSOR", Identifier)
			put_keyword ("ANIICON", Identifier)
			put_keyword ("BITMAP", Identifier)
			put_keyword ("BUTTON", Identifier)
			put_keyword ("CAPTION", Identifier)
			put_keyword ("CHARACTERISTICS", Identifier)
			put_keyword ("CLASS", Identifier)
			put_keyword ("CONTROL", Identifier)
			put_keyword ("CURSOR", Identifier)
			put_keyword ("DIALOG", Identifier)
			put_keyword ("DIALOGEX", Identifier)
			put_keyword ("DLGINIT", Identifier)
			put_keyword ("EXSTYLE=", Special_identifier)
			put_keyword ("FILEFLAGS", Identifier)
			put_keyword ("FILEFLAGSMASK", Identifier)
			put_keyword ("FILEOS", Identifier)
			put_keyword ("FILESUBTYPE", Identifier)
			put_keyword ("FILETYPE", Identifier)
			put_keyword ("FILEVERSION", Identifier)
			put_keyword ("FONT", Identifier)
			put_keyword ("ICON", Identifier)
			put_keyword ("LANGUAGE", Identifier)
			put_keyword ("MENU", Identifier)
			put_keyword ("MENUEX", Identifier)
			put_keyword ("MENUITEM", Identifier)
			put_keyword ("MESSAGETABLE", Identifier)
			put_keyword ("POPUP", Identifier)
			put_keyword ("PRODUCTVERSION", Identifier)
			put_keyword ("RCDATA", Identifier)
			put_keyword ("SEPARATOR", Identifier)
			put_keyword ("STRINGTABLE", Identifier)
			put_keyword ("STYLE", Identifier)
			put_keyword ("TEXTINCLUDE", Identifier)
			put_keyword ("TOOLBAR", Identifier)
			put_keyword ("VERSION", Identifier)
			put_keyword ("VERSIONINFO", Identifier)

			put_keyword ("%"StringFileInfo%"", Identifier)
			put_keyword ("%"VarFileInfo%"", Identifier)
			put_keyword ("%"Translation%"", Identifier)

			put_keyword (",", Ponctuation)
		end
 
end -- class RESOURCE_SCRIPT_LEX

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
