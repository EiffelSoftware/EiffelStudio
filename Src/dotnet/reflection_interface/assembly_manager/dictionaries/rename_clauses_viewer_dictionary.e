indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.RenameClausesViewerDictionary"

class
	RENAME_CLAUSES_VIEWER_DICTIONARY
	
inherit
	DIALOG_DICTIONARY

feature -- Access
	
	Add_button_label: STRING is "Add"
			-- Add button label
		indexing
			external_name: "AddButtonLabel"
		end

--	Alignment: INTEGER is 5
--			-- Alignment in list view
--		indexing
--			external_name: "Alignment"
--		end

	As_keyword: STRING is "as"
			-- As keyword
		indexing
			external_name: "AsKeyword"
		end
		
	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
		end
		
	Class_label_text: STRING is "Class: "
			-- Text of class label
		indexing
			external_name: "ClassLabelText"
		end

	Closing_bracket: STRING is ")"
			-- Closing bracket
		indexing
			external_name: "ClosingBracket"
		end
	
	Colon: STRING is ":"
			-- Colon
		indexing
			external_name: "Colon"
		end

	External_name_keyword: STRING is "External name"
			-- External name
		indexing
			external_name: "ExternalNameKeyword"
		end
		
	Inverted_comma: STRING is "%""
			-- Inverted comma
		indexing
			external_name: "ExternalName"
		end

--	List_height: INTEGER is 
--			-- Rename list height
--		indexing
--			external_name: "ListHeight"
--		once
--			Result := Window_height - 14 * Margin - 6 * Label_height - 2 * Button_height
--		end

--	List_view_border_style: INTEGER is 1
--			-- List view border style
--		indexing
--			external_name: "ListViewBorderStyle"
--		end

	New_clause: STRING is "-- New clause"
			-- New clause
		indexing
			external_name: "NewClause"
		end
		
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end

	Opening_bracket: STRING is "("
			-- Opening bracket
		indexing
			external_name: "OpeningBracket"
		end
		
--	Panel_border_style: INTEGER is 0
--			-- Panel border style: none
--		indexing
--			external_name: "PanelBorderStyle"
--		end
		
	Parent_label_text: STRING is "Parent: " 
			-- Text of parent label
		indexing
			external_name: "ParentLabelText"
		end

	Red_color: SYSTEM_DRAWING_COLOR is
			-- Red color
		indexing
			external_name: "RedColor"
		once
			Result := Result.Red
		end

	Rename_clause_text: STRING is "Rename clause: "
			-- Rename clause label text
		indexing
			external_name: "RenameClauseText"
		end
		
	Rename_clauses_text: STRING is "Rename clauses: "
			-- Rename clauses label text
		indexing
			external_name: "RenameClausesText"
		end
		
	Space: STRING is " "
			-- Space
		indexing
			external_name: "Space"
		end
		
	Title: STRING is "Inheritance clauses viewer"
			-- Window title
		indexing
			external_name: "Title"
		end

--	View: INTEGER is 3
--			-- View property for list view
--		indexing
--			external_name: "View"
--		end

end -- class RENAME_CLAUSES_VIEWER_DICTIONARY
