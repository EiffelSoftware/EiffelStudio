-- Polymorphic unit associated to an attribute

class ATTR_UNIT

inherit

	POLY_UNIT

feature

	feature_id: INTEGER;
			-- Feature id of the associated attribute

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i
		end;

	new_poly_table (pattern_id: INTEGER): ATTR_UNIT_TABLE is
			-- New associated polymorhic table
		do
			!!Result.make
		end;

	entry (class_type: CLASS_TYPE): ATTR_ENTRY is
			-- Attribute entry in an attribute offset table
		do
			!!Result;
			Result.set_type_id (class_type.type_id);
			Result.set_feature_id (feature_id);
			Result.set_type (feature_type (class_type));
		end;

end
