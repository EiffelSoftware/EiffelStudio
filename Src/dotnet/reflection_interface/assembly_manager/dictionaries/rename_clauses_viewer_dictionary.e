indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.RenameClausesViewerDictionary"

class
	RENAME_CLAUSES_VIEWER_DICTIONARY
	
inherit
	DIALOG_DICTIONARY

feature -- Access
	
	Add_button_label: STRING is "Add"
		indexing
			description: "Add button label"
			external_name: "AddButtonLabel"
		end

	Alignment: INTEGER is 5
		indexing
			description: "Alignment in list view"
			external_name: "Alignment"
		end

	As_keyword: STRING is "as"
		indexing
			description: "As keyword"
			external_name: "AsKeyword"
		end
		
	Cancel_button_label: STRING is "Cancel"
		indexing
			description: "Cancel button label"
			external_name: "CancelButtonLabel"
		end
		
	Class_label_text: STRING is "Class: "
		indexing
			description: "Text of class label"
			external_name: "ClassLabelText"
		end

	Closing_bracket: STRING is ")"
		indexing
			description: "Closing bracket"
			external_name: "ClosingBracket"
		end
	
	Colon: STRING is ":"
		indexing
			description: "Colon"
			external_name: "Colon"
		end

	External_name_keyword: STRING is "External name"
		indexing
			description: "External name keyword"
			external_name: "ExternalNameKeyword"
		end
		
	Inverted_comma: STRING is "%""
		indexing
			description: "Inverted comma"
			external_name: "ExternalName"
		end

	List_height: INTEGER is 
		indexing
			description: "Rename list height"
			external_name: "ListHeight"
		once
			Result := Window_height - 12 * Margin - 6 * Label_height - 2 * Button_height
		end

	List_view_border_style: INTEGER is 1
		indexing
			description: "List view border style"
			external_name: "ListViewBorderStyle"
		end

	New_clause: STRING is "-- New clause"
		indexing
			description: "New clause"
			external_name: "NewClause"
		end
		
	Ok_button_label: STRING is "OK"
		indexing
			description: "OK button label"
			external_name: "OkButtonLabel"
		end

	Opening_bracket: STRING is "("
		indexing
			description: "Opening bracket"
			external_name: "OpeningBracket"
		end
		
	Panel_border_style: INTEGER is 0
		indexing
			description: "Panel border style: none"
			external_name: "PanelBorderStyle"
		end
		
	Parent_label_text: STRING is "Parent: " 
		indexing
			description: "Text of parent label"
			external_name: "ParentLabelText"
		end

	Red_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "Red color"
			external_name: "RedColor"
		once
			Result := Result.Red
		end

	Rename_clause_text: STRING is "Rename clause: "
		indexing
			description: "Rename clause label text"
			external_name: "RenameClauseText"
		end
		
	Rename_clauses_text: STRING is "Rename clauses: "
		indexing
			description: "Rename clauses label text"
			external_name: "RenameClausesText"
		end
		
	Space: STRING is " "
		indexing
			description: "Space"
			external_name: "Space"
		end
		
	Title: STRING is "Inheritance clauses viewer"
		indexing
			description: "Window title"
			external_name: "Title"
		end

	View: INTEGER is 3
		indexing
			description: "View property for list view"
			external_name: "View"
		end

	Window_height: INTEGER is 400
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end

	Window_width: INTEGER is 650
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end
		
end -- class RENAME_CLAUSES_VIEWER_DICTIONARY
