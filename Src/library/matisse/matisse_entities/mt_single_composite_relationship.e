indexing
	description: "MATISSE-Eiffel Binding: representing single cardinality CompositeRelationship";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SINGLE_COMPOSITE_RELATIONSHIP

inherit
	MT_COMPOSITE_RELATIONSHIP
		undefine
			is_equal
		end
		
	MT_SINGLE_RELATIONSHIP

creation
	make_from_oid	

end -- class MT_SINGLE_COMPOSITE_RELATIONSHIP
