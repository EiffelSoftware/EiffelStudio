-- Representation for an attribute entry in an instance of ATTR_TABLE

class ATTR_ENTRY

inherit
	ENTRY

feature

	feature_id: INTEGER;
			-- Feature id of the attribute

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'.
		do
			feature_id := i;
		end;

feature -- previously in ATTR_UNIT

	new_poly_table: ATTR_TABLE is
			-- New associated polymorhic table
		do
			!!Result
		end;

	entry (class_type: CLASS_TYPE): ATTR_ENTRY is
			-- Attribute entry in an attribute offset table
		do
			!!Result;
			Result.set_type_id (class_type.type_id);
			Result.set_feature_id (feature_id);
			Result.set_type (feature_type (class_type));
		end;

feature -- from ATTR_ENTRY

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for an offset entry
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1);
				-- Offset encoding
			System.class_type_of_id (type_id).skeleton.make_offset_byte_code
					(ba, feature_id);
		end;

	used: BOOLEAN is True;
			-- Is an attribute entry used ?

	workbench_offset: INTEGER is
			-- Offset of attribute in object structure
		local
			skel: SKELETON
		do
			skel := System.class_type_of_id (type_id).skeleton;
			skel.search_feature_id (feature_id);
			Result := skel.workbench_offset
		end;

end
