indexing
	description	: "Shared attributes specific to the flat/short form."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FLAT_SHORT_DATA

inherit
	SHARED_RESOURCES

	FEATURE_CLAUSE_NAMES

feature -- Access

	feature_clause_order: ARRAY [STRING] is
		do
			Result := array_resource_value ("feature_clause_order", Default_feature_clause_order)
		end

	excluded_indexing_items: ARRAY [STRING] is
		do
			Result := array_resource_value ("excluded_indexing_items", <<"revision", "date", "status">>)
			Result.compare_objects
		end

end -- class EB_FLAT_SHORT_DATA

