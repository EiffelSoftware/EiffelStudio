indexing
	description: "external methods for class MT_RELATIONSHIP."

class 
	MT_RELATIONSHIP_EXTERNAL 

feature {NONE} -- Implementation MT_RELATIONSHIP

	c_get_relationship_from_name (name: POINTER): INTEGER is
			-- Use GetRelationship.
		external
			"C"
		end -- c_get_relationship_from_name

	c_check_relationship (rid, oid: INTEGER)  is
			-- Use Mt_CheckRelationship.
		external
			"C"
		end -- c_check_relationship

	c_get_max_cardinality (relationship_oid: INTEGER): INTEGER is
		external
			"C"
		alias
			"c_get_max_cardinality_relationship"
		end

	c_remove_all_succs_ignerr (rid, oid, sts: INTEGER) is
			-- Remove all successors of oid-object through rid-
			-- relationship.
			-- Ignore the error sts.
		external
			"C"
		end

	c_remove_all_succs_ignore_nosuccessors (rid, oid: INTEGER) is
			-- Remove all successors of oid-object through rid-
			-- relationship.
			-- Ignore the error MATISSE_NOSUCCESSORS.
		external
			"C"
		end
		
	c_get_relationship_class_name (rid: INTEGER): POINTER is
		external
			"C"
		end

end -- class MT_RELATIONSHIP_EXTERNAL
