indexing
	description: "MATISSE-Eiffel Binding: representing multiple cardinality CompositeRelationship";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_MULTI_COMPOSITE_RELATIONSHIP

inherit
	MT_COMPOSITE_RELATIONSHIP
		undefine
			is_equal
		end
	
	MT_MULTI_RELATIONSHIP

creation

	make_from_oid
		
end -- class MT_MULTI_COMPOSITE_RELATIONSHIP
