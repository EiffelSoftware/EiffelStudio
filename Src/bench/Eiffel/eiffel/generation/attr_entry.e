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

	generate_workbench_info (file: UNIX_FILE) is
			-- Generate access info.
		local
			skel: SKELETON;
		do
			file.putstring ("(long) ");
			skel := System.class_type_of_id (type_id).skeleton;
			skel.generate_workbench_offset (file, feature_id);
		end;

	generate_empty_info (file: UNIX_FILE) is
			-- Generate empty access-info
		do
			file.putstring ("(long) 0");
		end;

end
