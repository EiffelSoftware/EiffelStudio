indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.TypeViewDictionary"

class
	TYPE_VIEW_DICTIONARY
	
inherit
	VIEW_DICTIONARY
	
feature -- Access

	Access_comment: STRING is "-- Access"
			-- Comment for access feature clause
		indexing
			external_name: "AccessComment"
		end

	Align_left: INTEGER is 32
			-- Left alignment
		indexing
			external_name: "AlignLeft"
		end

	Alignment: INTEGER is 1
			-- Left alignment (in list view)
		indexing
			external_name: "Alignment"
		end
		
	Argument_string: STRING is "Argument"
		indexing
			description: "Argument string"
			external_name: "ArgumentString"
		end
		
	Basic_operations_comment: STRING is "-- Basic Operations"
			-- Comment for basic operations feature clause
		indexing
			external_name: "BasicOperationsComment"
		end

	Binary_operators_comment: STRING is "-- Binary Operators"
			-- Comment for binary operators clause
		indexing
			external_name: "BinaryOperatorsComment"
		end
		
	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
		end
	
	Check_validity_message: STRING is "ISE Assembly Manager will now check the validity of your changes. Please wait."
		indexing
			description: "Message to the user before starting verification of the class"
			external_name: "CheckValidityMessage"
		end
	
	Class_name: STRING is "Class Name"
		indexing
			description: "Class name string"
			external_name: "ClassName"
		end
		
	Class_color: SYSTEM_DRAWING_COLOR is
			-- Class color
		indexing
			external_name: "ClassColor"
		once
			Result := Result.Blue
		end

	Closing_curl_bracket: STRING is "}"
			-- Closing curl bracket
		indexing
			external_name: "ClosingCurlBracket"
		end

	Closing_round_bracket: STRING is ")"
			-- Closing round bracket
		indexing
			external_name: "ClosingRoundBracket"
		end
	
	Colon: STRING is ":"
		indexing
			description: "Colon"
			external_name: "Colon"
		end
		
	Comment_color: SYSTEM_DRAWING_COLOR is
			-- Comment color
		indexing
			external_name: "CommentColor"
		once
			Result := Result.DarkRed
		end

	Editable_color: SYSTEM_DRAWING_COLOR is
			-- Color for editable text fields
		indexing
			external_name: "EditableColor"
		once
			Result := Result.Ivory
		end
	
	Eiffel_generation_question: STRING is "Your changes have been saved in the Eiffel assembly cache. Would you like to regenerate Eiffel sources too?"
		indexing
			description: "Question to the user after saving changes in the XML files"
			external_name: "EiffelGenerationQuestion"
		end
		
	Element_change_comment: STRING is "-- Element Change"
			-- Comment for element change feature clause
		indexing
			external_name: "ElementChangeComment"
		end
	
	Enter_key: INTEGER is 13
		indexing
			description: "Enter key"
			external_name: "EnterKey"
		end

	Error: STRING is "Error"
		indexing
			description: "Error string"
			external_name: "Error"
		end
		
	Feature_color: SYSTEM_DRAWING_COLOR is
			-- Feature color
		indexing
			external_name: "FeatureColor"
		once
			Result := Result.DarkGreen
		end

	Feature_keyword: STRING is "feature"
			-- Feature keyword
		indexing
			external_name: "FeatureKeyword"
		end		

	Feature_string: STRING is "Feature"
			-- Feature string
		indexing
			external_name: "FeatureString"
		end	
		
	Implementation_comment: STRING is "-- Implementation"
			-- Comment for implementation clause
		indexing
			external_name: "ImplementationComment"
		end

	Initialization_comment: STRING is "-- Initialization"
			-- Comment for initialization feature clause
		indexing
			external_name: "InitializationComment"
		end

	Italic_style: INTEGER is 2
			-- Italic style
		indexing
			external_name: "ItalicStyle"
		end

	Keyword_color: SYSTEM_DRAWING_COLOR is
			-- Keyword color
		indexing
			external_name: "KeywordColor"
		once
			Result := Result.DarkBlue
		end

	List_view_border_style: INTEGER is 1
		indexing
			description: "List view border style"
			external_name: "ListViewBorderStyle"
		end
		
	None_class: STRING is "NONE"
			-- `NONE' class
		indexing
			external_name: "NoneClass"
		end
		
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end

	Opening_curl_bracket: STRING is "{"
			-- Opening curl bracket
		indexing
			external_name: "OpeningCurlBracket"
		end

	Opening_round_bracket: STRING is "("
			-- Opening round bracket
		indexing
			external_name: "OpeningRoundBracket"
		end
		
	Red_color: SYSTEM_DRAWING_COLOR is
			-- Red color
		indexing
			external_name: "RedColor"
		once
			Result := Result.Red
		end

	Space: STRING is " "
		indexing
			description: "Space as a string"
			external_name: "Space"
		end
		
	Specials_comment: STRING is "-- Specials"
			-- Comment for specials clause
		indexing
			external_name: "SpecialsComment"
		end
		
	Text_color: SYSTEM_DRAWING_COLOR is
			-- Text color
		indexing
			external_name: "TextColor"
		once
			Result := Result.Black
		end
		
	Title: STRING is "Type view"
			-- Window title
		indexing
			external_name: "Title"
		end

	Unary_operators_comment: STRING is "-- Unary Operators"
			-- Comment for unary operators clause
		indexing
			external_name: "UinaryOperatorsComment"
		end

	View: INTEGER is 2
		indexing
			description: "List view"
			external_name: "View"
		end
		
	White_color: SYSTEM_DRAWING_COLOR is
			-- White color
		indexing
			external_name: "WhiteColor"
		once
			Result := Result.White
		end
		
end -- class TYPE_VIEW_DICTIONARY