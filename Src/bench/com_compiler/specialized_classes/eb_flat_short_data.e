indexing
	description: "Shared attributes specific to the flat/short form."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FLAT_SHORT_DATA

inherit
	EB_DEVELOPMENT_TOOL_DATA
	
	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Access

	feature_clause_order: ARRAY [STRING] is
			-- Feature clause order as saved in preference file.
		do
			Result := << "Initialization", "Access", "Measurement",
						"Comparison", "Status report", "Status setting",
						"Cursor movement", "Element change", "Removal",
						"Resizing", "Transformation", "Conversion",
						"Duplication", "Miscellaneous",
						"Basic operations", "Obsolete", "Inapplicable",
						"Implementation", "*" >>
		end

	excluded_indexing_items: ARRAY [STRING] is
			-- Excluded indexing items as saved in preference file.
		do
			Result := << "revision", "date", "status" >>
		end

end -- class EB_FLAT_SHORT_DATA
