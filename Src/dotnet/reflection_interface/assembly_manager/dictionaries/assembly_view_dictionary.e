indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.AssemblyViewDictionary"

class
	ASSEMBLY_VIEW_DICTIONARY
	
inherit
	VIEW_DICTIONARY
	
feature -- Access

--	Alignment: INTEGER is 5
--			-- Alignment in list view
--		indexing
--			external_name: "Alignment"
--		end
				
	Close_button_label: STRING is "Close"
			-- Close button label
		indexing
			external_name: "CloseButtonLabel"
		end
		
	List_view_border_style: INTEGER is 1
			-- List view border style
		indexing
			external_name: "ListViewBorderStyle"
		end
		
	Title: STRING is "Assembly view"
			-- Window title
		indexing
			external_name: "Title"
		end
		
	Types_label_text: STRING is "Types: "
			-- Types label text
		indexing
			external_name: "TypesLabelText"
		end

--	View: INTEGER is 3
--			-- View property for list view
--		indexing
--			external_name: "View"
--		end
	
end -- class ASSEMBLY_VIEW_DICTIONARY