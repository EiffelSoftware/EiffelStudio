-- Byte code description of melted routine id array

class MELTED_ROUTID_ARRAY

inherit

	CHARACTER_ARRAY;
	IDABLE
		rename
			id as class_id
		end

creation

	make

feature

	class_id: INTEGER;
			-- Id of the associated class type

	set_class_id (i: INTEGER) is
			-- Assign `i' to `class_id'.
		do
			class_id := i;
		end;

end
