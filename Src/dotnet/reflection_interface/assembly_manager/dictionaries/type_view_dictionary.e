indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.TypeViewDictionary"

class
	TYPE_VIEW_DICTIONARY
	
inherit
	VIEW_DICTIONARY
	
feature -- Access

	Access: INTEGER is 2
			-- Constant corresponding to access feature clause
		indexing
			external_name: "Access"
		end	

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

	Basic_operations: INTEGER is 4
			-- Constant corresponding to basic operations feature clause
		indexing
			external_name: "BasicOperations"
		end		

	Basic_operations_comment: STRING is "-- Basic Operations"
			-- Comment for basic operations feature clause
		indexing
			external_name: "BasicOperationsComment"
		end

	Binary_operators: INTEGER is 6
			-- Constant corresponding to binary operators feature clause
		indexing
			external_name: "BinaryOperators"
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
		
	Class_color: SYSTEM_DRAWING_COLOR is
			-- Class color
		indexing
			external_name: "ClassColor"
		once
			Result := Result.Blue
		end

	Closing_curl_bracket: STRING is "}"
			-- Closing round bracket
		indexing
			external_name: "ClosingCurlBracket"
		end
		
	Comment_color: SYSTEM_DRAWING_COLOR is
			-- Comment color
		indexing
			external_name: "CommentColor"
		once
			Result := Result.DarkRed
		end

	Element_change: INTEGER is 3
			-- Constant corresponding to element change feature clause
		indexing
			external_name: "ElementChange"
		end

	Element_change_comment: STRING is "-- Element Change"
			-- Comment for element change feature clause
		indexing
			external_name: "ElementChangeComment"
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

	Implementation: INTEGER is 8
			-- Constant corresponding to implementation feature clause
		indexing
			external_name: "Implementation"
		end	

	Implementation_comment: STRING is "-- Implementation"
			-- Comment for implementation clause
		indexing
			external_name: "ImplementationComment"
		end

	Initialization: INTEGER is 1
			-- Constant corresponding to initialization feature clause
		indexing
			external_name: "Initialization"
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
			-- Opening round bracket
		indexing
			external_name: "OpeningCurlBracket"
		end
	
	Red_color: SYSTEM_DRAWING_COLOR is
			-- Red color
		indexing
			external_name: "RedColor"
		once
			Result := Result.Red
		end

	Specials: INTEGER is 7
			-- Constant corresponding to specials feature clause
		indexing
			external_name: "Specials"
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

	Unary_operators: INTEGER is 5
			-- Constant corresponding to unary operators feature clause
		indexing
			external_name: "UnaryOperators"
		end

	Unary_operators_comment: STRING is "-- Unary Operators"
			-- Comment for unary operators clause
		indexing
			external_name: "UinaryOperatorsComment"
		end

	White_color: SYSTEM_DRAWING_COLOR is
			-- White color
		indexing
			external_name: "WhiteColor"
		once
			Result := Result.White
		end
		
end -- class TYPE_VIEW_DICTIONARY