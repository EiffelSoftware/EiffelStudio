indexing

	description:

		"Token values"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	derivation: "See notice at bottom of file"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_TOKENS

feature	-- Access

	Unknown_token: INTEGER is -1
			-- Pseudo-token representing the start of the expression

			-- Token Numbers.
			-- Those in the range 0 to 100 are tokens that can be followed
			-- by a name or expression; those in the range 101 to 200 are tokens that can be
			-- followed by an binary operator.
	
	Eof_token: INTEGER is 0
			-- Pseudo-token representing the end of the expression

	Union_token: INTEGER is 1
			-- "union" or "|" token

	Slash_token: INTEGER is 2
			-- Forwards "/"

	At_token: INTEGER is 3
			-- At token, "@"

	Left_square_bracket_token: INTEGER is 4
			-- Left square bracket

	Left_parenthesis_token: INTEGER is 5
			--  Left parenthesis

	Equals_token: INTEGER is 6
			-- Equals token ("=")

	Comma_token: INTEGER is 7
			-- Comma token

	Slash_slash_token: INTEGER is 8
			-- Double forwards slash, "//"

	Or_token: INTEGER is 9
			-- Operator "or"

	And_token: INTEGER is 10
			-- Operator "and"

	Greater_than_token: INTEGER is 11
			-- Operator ">"

	Less_than_token: INTEGER is 12
			-- Operator "<"

	Greater_equal_token: INTEGER is 13
			-- Operator ">="

	Less_equal_token: INTEGER is 14
			-- Operator "<="

	Plus_token: INTEGER is 15
			-- Operator "+"

	Minus_token: INTEGER is 16
			-- Binary minus operator

	Multiply_token: INTEGER is 17
			-- Multiply operator, "*" when used in an operator context

	Division_token: INTEGER is 18
			-- Operator "div"

	Modulus_token: INTEGER is 19
			-- Operator "mod"

	Is_token: INTEGER is 20
			-- Operator "is"

	Dollar_token: INTEGER is 21
			-- "$" symbol
	
	Not_equal_token: INTEGER is 22
			--	Operator "!="

	Intersect_token: INTEGER is 23
			-- Operator "intersect"
	
	Except_token: INTEGER is 24
			-- Operator "except"
	
	Return_token: INTEGER is 25
			-- Keyword "return"
	
	Then_token: INTEGER is 26
		-- Keyword "then"		
		
	Else_token: INTEGER is 27
			-- Keyword "else"
		
	To_token: INTEGER is 29
			--  Operator "to"
		
	In_token: INTEGER is 30
			-- Keyword "in"

	Some_token: INTEGER is 31
			-- Keyword "some"

	Every_token: INTEGER is 32
			-- Keyword "every"

	Satisfies_token: INTEGER is 33
			-- Keyword "satisfies"

	Function_token: INTEGER is 34
			-- Token representing the name of a function and the following "(" symbol

	Axis_token:	INTEGER is 35
			-- Token representing the name of an axis and the following "::" symbol

	If_token: INTEGER is 36
			-- Keyword "if"

	Precedes_token: INTEGER is 37
			-- Operator "<<"

	Follows_token: INTEGER is 38
			-- Operator ">>"

	Colon_colon_token: INTEGER is 39
			-- "::" symbol

	Colon_star_token: INTEGER is 40
			-- ":*" symbol

	Instance_of_token: INTEGER is 41
			-- operator "instance of"

	Cast_as_token: INTEGER is 42
			-- operator "cast as"

	Treat_as_token: INTEGER is 43
			-- operator "treat as"

		-- "Fortran" style comparison operators eq, ne, etc
	
	Fortran_equal_token: INTEGER is 44
			-- operator "eq"

	Fortran_not_equal_token: INTEGER is 45
			-- operator "ne"

	Fortran_greater_than_token: INTEGER is 46
			-- operator "gt"

	Fortran_less_than_token: INTEGER is 47
			-- operator "lt"

	Fortran_greater_equal_token: INTEGER is 48
			-- operator "ge"

	Fortran_less_equal_token: INTEGER is 49
			-- operator "le"

	Integer_division_token: INTEGER is 50
			-- operator "idiv"

	Castable_as_token: INTEGER is 51
			-- operator "castable as"

	Assign_token: INTEGER is 52
			-- ":=" symbol (XQuery only)

	Left_curly_token: INTEGER is 53
			-- "{" symbol (XQuery only)

	Keyword_curly_token: INTEGER is 54
			-- composite token: <keyword "{"> (XQuery only)

	Element_qname_token: INTEGER is 55
			-- composite token <'element' QNAME> (XQuery only)

	Attribute_qname_token: INTEGER is 56
			-- composite token <'attribute' QNAME> (XQuery only)

	Pi_qname_token: INTEGER is 57
			-- composite token <'pi' QNAME> (XQuery only)

	Typeswitch_token: INTEGER is 58
			-- Keyword "typeswitch"

	Case_token: INTEGER is 59
			-- Keyword "case"

	Default_token: INTEGER is 60
			-- Keyword "default"

	Node_kind_token: INTEGER is 61
			-- Node kind, e.g. "node()" or "comment()"

	Suffix_token: INTEGER is 112
			-- "*:local-name" token


		-- The following tokens are used only in the query prolog. They are categorized
		-- as operators on the basis that a following name is treated as a name rather than
		-- an operator.

	Xquery_version_token: INTEGER is 70
			-- "xquery version"

	Declare_namespace_token: INTEGER is 71
			-- "declare namespace"

	Declare_default_token: INTEGER is 72
			-- "declare default"

	Declare_base_uri_token: INTEGER is 74
			-- "declare base-uri"

	Declare_xml_space_token: INTEGER is 75
			-- "declare xmlspace"

	Import_schema_token: INTEGER is 76
			-- "import schema"

	Import_module_token: INTEGER is 77
			-- "import module"

	Declare_variable_token: INTEGER is 78
			-- "declare variable"

	Declare_function_token: INTEGER is 79
			-- "declare function"

	Module_namespace_token: INTEGER is 80
			-- "module namespace"

	Semicolon_token: INTEGER is 80
			-- semicolon separator

	Last_operator: INTEGER is 100
			-- Constant identifying the token number of the last token to be classified as an operator

		-- Tokens that set "operator" context, so an immediately following "div" is recognized
		-- as an operator, not as an element name


	Name_token: INTEGER is 101
			-- Name token (a QName, in general)

	String_literal_token: INTEGER is 102
			-- String literal

	Right_square_bracket_token: INTEGER is 103
			-- Right square bracket

	Right_parenthesis_token: INTEGER is 104
			-- Right parenthesis

	Dot_token: INTEGER is 105
			-- "." symbol

	Dot_dot_token: INTEGER is 106
			-- ".." symbol

	Star_token: INTEGER is 107
			-- "*" symbol when used as a wildcard

	Prefix_token: INTEGER is 108
			-- "prefix:*" token;
			-- e.g. prefix:*

	Number_token: INTEGER is 109
			-- Numeric literal

	For_token: INTEGER is 111
			-- "for" keyword

	Question_mark_token: INTEGER is 113
			-- "?" symbol

	Right_curly_token: INTEGER is 115
			-- "}" symbol (XQuery only)

	Let_token: INTEGER is 116
			-- "let" keyword (XQuery only)

	Tag_token: INTEGER is 117
			-- "<" at the start of a tag (XQuery only);
			-- The pseudo-XML syntax that follows is read character-by-character by the XQuery parser

	Unary_minus_token: INTEGER is 199
			-- Unary minus sign;
			-- not actually a token, but we
			-- use token numbers to identify operators.	
	
	token_name (a_token: INTEGER): STRING is
			-- Name of `a_token'
		require
			valid_token: is_valid_token(a_token)
		do
			Result := tokens.item (a_token)
		ensure
			may_be_void: True -- as valid_token pre-condition is only sufficient to index the array
		end

feature -- Status report

	is_valid_token (a_token: INTEGER): BOOLEAN is
			-- Is `a_token' a valid token?
		do
			Result := a_token > Eof_token and a_token <= Unary_minus_token
		end
	
feature {NONE} -- Implementation

	tokens: ARRAY [STRING] is
			-- Strings are used to represent tokens in error messages
		once
			create Result.make (0, 199)
			
			Result.put ("<eof>", Eof_token)
			Result.put ("|", Union_token)
			Result.put ("/", Slash_token)
			Result.put ("@", At_token)
			Result.put ("[", Left_square_bracket_token)
			Result.put ("(", Left_parenthesis_token)
			Result.put ("=", Equals_token)
			Result.put (",", Comma_token)
			Result.put ("//", Slash_slash_token)
			Result.put ("or", Or_token)
			Result.put ("and", And_token)
			Result.put (">", Greater_than_token)
			Result.put ("<", Less_than_token)
			Result.put (">=", Greater_equal_token)
			Result.put ("<=", Less_equal_token)
			Result.put ("+", Plus_token)
			Result.put ("-", Minus_token)
			Result.put ("*", Multiply_token)
			Result.put ("div", Division_token)
			Result.put ("mod", Modulus_token)
			Result.put ("is", Is_token)
			Result.put ("$", Dollar_token)
			Result.put ("!=", Not_equal_token)
			Result.put ("intersect", Intersect_token)
			Result.put ("except", Except_token)
			Result.put ("return", Return_token)
			Result.put ("then", Then_token)
			Result.put ("else", Else_token)
			Result.put ("to", To_token)
			Result.put ("in", In_token)
			Result.put ("some", Some_token)
			Result.put ("every", Every_token)
			Result.put ("satisfies", Satisfies_token)
			Result.put ("<function>(", Function_token)
			Result.put ("<axis>", Axis_token)
			Result.put ("if(", If_token)
			Result.put ("<<", Precedes_token)
			Result.put (">>", Follows_token)
			Result.put ("::", Colon_colon_token)
			Result.put (":*", Colon_star_token)
			Result.put ("instance of", Instance_of_token)
			Result.put ("cast as", Cast_as_token)
			Result.put ("treat as", Treat_as_token)
			Result.put ("eq", Fortran_equal_token)
			Result.put ("ne", Fortran_not_equal_token)
			Result.put ("gt", Fortran_greater_than_token)
			Result.put ("ge", Fortran_greater_equal_token)
			Result.put ("lt", Fortran_less_than_token)
			Result.put ("le", Fortran_less_equal_token)
			Result.put ("idiv", Integer_division_token)
			Result.put ("castable as", Castable_as_token)
			Result.put (":=", Assign_token)
			Result.put ("typeswitch", Typeswitch_token)
			Result.put ("case", Case_token)
			Result.put ("default", Default_token)
			Result.put ("<name>", Name_token)
			Result.put ("<string-literal>", String_literal_token)
			Result.put ("]", Right_square_bracket_token)
			Result.put (")", Right_parenthesis_token)
			Result.put (".", Dot_token)
			Result.put ("..", Dot_dot_token)
			Result.put ("*", Star_token)
			Result.put ("<prefix:*>", Prefix_token)
			Result.put ("<numeric-literal>", Number_token)
			Result.put ("<node-type>()", Node_kind_token)
			Result.put ("for", For_token)
			Result.put ("<*:local-name>", Suffix_token)
			Result.put ("?", Question_mark_token)
			Result.put ("{", Left_curly_token)
			Result.put ("}", Right_curly_token)
			Result.put ("let", Let_token)
			Result.put ("xquery version", Xquery_version_token)
			Result.put ("declare namespace", Declare_namespace_token)
			Result.put ("declare base-uri", Declare_base_uri_token)
			Result.put ("declare default", Declare_default_token)
			Result.put ("declare xmlspace", Declare_xml_space_token)
			Result.put ("import schema", Import_schema_token)
			Result.put ("import module", Import_module_token)
			Result.put ("declare variable", Declare_variable_token)
			Result.put ("declare function", Declare_function_token)
			Result.put ("module namespace", Module_namespace_token)
			Result.put (";", Semicolon_token)
			Result.put ("-", Unary_minus_token)
		end
	
end
		
