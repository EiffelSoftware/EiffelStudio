indexing
	description: "Common application constants"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_APP_CONSTANTS

feature {NONE} -- Access

	Filter_output_file_name: STRING is "com_filter.output"

	Return_value_variable_name: STRING is "return_value"

	-- Constant for input parser
	
	Feature_indicator: STRING is "#feature#"

	Description_indicator: STRING is "description:"

	Type_indicator: STRING is "#type#"

	Comment_indicator: STRING is "#--#"

	Class_header_indicator: STRING is "#class#"

	Infix_feature_indicator: STRING is "#infix#"

	Prefix_feature_indicator: STRING is "#prefix#"

	Constant_indicator: STRING is " is "

	Current_type: STRING is "Current"

	Like_word: STRING is "like"

	Empty_string: STRING is ""

	Colon_character: CHARACTER is ':'

	Space_character: CHARACTER is ' '

	Open_parenthesis_char: CHARACTER is '('

	Close_parenthesis_char: CHARACTER is ')'

	Comma_character: CHARACTER is ','

	Semicolon_character: CHARACTER is ';'

	Double_quote_character: CHARACTER is '%"'

end -- class EI_APP_CONSTANTS
