-- Byte code description of melted feature table

class MELTED_FEATURE_TABLE 

inherit

	CHARACTER_ARRAY;
	IDABLE
		rename
			id as type_id,
			set_id as set_type_id
		end;
	SHARED_WORKBENCH

creation

	make
	
feature 

	type_id: INTEGER;
			-- Id of the associated class type

	set_type_id (i: INTEGER) is
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

	associated_class_type: CLASS_TYPE is
			-- Associated class type of the current melted feature
			-- table
		do
			Result := System.class_type_of_id (type_id);
		end;

end
