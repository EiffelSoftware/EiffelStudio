indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.TypeViewDictionary"

class
	TYPE_VIEW_DICTIONARY
	
inherit
	VIEW_DICTIONARY
	
feature -- Access

	Access_comment: STRING is "-- Access"
		indexing
			description: "Comment for access feature clause"
			external_name: "AccessComment"
		end

	Argument_string: STRING is "Argument"
		indexing
			description: "Argument string"
			external_name: "ArgumentString"
		end
		
	Basic_operations_comment: STRING is "-- Basic Operations"
		indexing
			description: "Comment for basic operations feature clause"
			external_name: "BasicOperationsComment"
		end

	Binary_operators_comment: STRING is "-- Binary Operators"
		indexing
			description: "Comment for binary operators clause"
			external_name: "BinaryOperatorsComment"
		end
		
	Cancel_button_label: STRING is "Cancel"
		indexing
			description: "Cancel button label"
			external_name: "CancelButtonLabel"
		end
	
	Check_validity_message: STRING is "Checking changes validity..."
		indexing
			description: "Message to the user while verifying validity of the class"
			external_name: "CheckValidityMessage"
		end
	
	Class_name: STRING is "Class Name"
		indexing
			description: "Class name string"
			external_name: "ClassName"
		end
		
	Class_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Class color"
			external_name: "ClassColor"
		once
			Result := Result.get_Blue
		end

	Closing_curl_bracket: STRING is "}"
		indexing
			description: "Closing curl bracket"
			external_name: "ClosingCurlBracket"
		end

	Closing_round_bracket: STRING is ")"
		indexing
			description: "Closing round bracket"
			external_name: "ClosingRoundBracket"
		end
	
	Colon: STRING is ":"
		indexing
			description: "Colon"
			external_name: "Colon"
		end
		
	Comment_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Comment color"
			external_name: "CommentColor"
		once
			Result := Result.get_Dark_Red
		end

	Editable_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Color for editable text fields"
			external_name: "EditableColor"
		once
			Result := Result.get_Ivory
		end
	
	Eiffel_generation: STRING is "Updating Eiffel class..."
		indexing
			description: "Message to the user during Eiffel regeneration (after changes in type view and XML generation)"
			external_name: "EiffelGeneration"
		end
		
	Element_change_comment: STRING is "-- Element Change"
		indexing
			description: "Comment for element change feature clause"
			external_name: "ElementChangeComment"
		end
	
	Error: STRING is "Error"
		indexing
			description: "Error string"
			external_name: "Error"
		end
		
	Feature_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Feature color"
			external_name: "FeatureColor"
		once
			Result := Result.get_Dark_Green
		end

	Feature_keyword: STRING is "feature"
		indexing
			description: "Feature keyword"
			external_name: "FeatureKeyword"
		end		

	Feature_string: STRING is "Feature"
		indexing
			description: "Feature string"
			external_name: "FeatureString"
		end	
		
	Implementation_comment: STRING is "-- Implementation"
		indexing
			description: "Comment for implementation clause"
			external_name: "ImplementationComment"
		end

	Initialization_comment: STRING is "-- Initialization"
		indexing
			description: "Comment for initialization feature clause"
			external_name: "InitializationComment"
		end

	Keyword_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Keyword color"
			external_name: "KeywordColor"
		once
			Result := Result.get_Dark_Blue
		end
		
	None_class: STRING is "NONE"
		indexing
			description: "Class `NONE' as a string"
			external_name: "NoneClass"
		end
		
	Ok_button_label: STRING is "OK"
		indexing
			description: "OK button label"
			external_name: "OkButtonLabel"
		end

	Opening_curl_bracket: STRING is "{"
		indexing
			description: "Opening curl bracket"
			external_name: "OpeningCurlBracket"
		end

	Opening_round_bracket: STRING is "("
		indexing
			description: "Opening round bracket"
			external_name: "OpeningRoundBracket"
		end
		
	Red_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Red color"
			external_name: "RedColor"
		once
			Result := Result.get_Red
		end

	Space: STRING is " "
		indexing
			description: "Space as a string"
			external_name: "Space"
		end
		
	Specials_comment: STRING is "-- Specials"
		indexing
			description: "Comment for specials clause"
			external_name: "SpecialsComment"
		end
		
	Text_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Color for type view text"
			external_name: "TextColor"
		once
			Result := Result.get_Black
		end
		
	Title: STRING is "Type view"
		indexing
			description: "Window title"
			external_name: "Title"
		end

	Unary_operators_comment: STRING is "-- Unary Operators"
		indexing
			description: "Comment for unary operators clause"
			external_name: "UinaryOperatorsComment"
		end
		
	White_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "White color"
			external_name: "WhiteColor"
		once
			Result := Result.get_White
		end
		
end -- class TYPE_VIEW_DICTIONARY