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

	type_id: TYPE_ID;
			-- Id of the associated class type

	set_type_id (i: TYPE_ID) is
			-- Assign `i' to `type_id'.
		do
			type_id := i;
		end;

end
