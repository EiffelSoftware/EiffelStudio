-- Melted class descriptors. 
-- A melted descriptor contains the byte code for all the class types associated 
-- with a given class.

class MELTED_DESC 

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
		-- Id of the associated class (CLASS_C)

	set_class_id (i: INTEGER) is
		-- Assign `i' to `class_id'.
		do
			class_id := i;
		end;

end
