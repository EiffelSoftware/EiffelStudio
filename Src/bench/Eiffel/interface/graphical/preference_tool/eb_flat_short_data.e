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
			Result := Class_resources.feature_clause_order.actual_value
		end

	excluded_indexing_items: ARRAY [STRING] is
			-- Excluded indexing items as saved in preference file.
		do
			Result := Class_resources.excluded_indexing_items.actual_value
		end

end -- class EB_FLAT_SHORT_DATA
