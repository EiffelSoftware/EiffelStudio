-- Record the features using loops

class OPTIMIZE_UNIT

inherit
	COMPARABLE
		undefine
			is_equal
		end;
	ANY

creation
	make

feature

	class_id: INTEGER;

	body_index: INTEGER;

feature

	make (c_id, b_index: INTEGER) is
		do
			class_id := c_id;
			body_index := b_index;
		end;

	class_c: CLASS_C is
		do
		end;

	feature_i: FEATURE_I is
		do
		end;

feature -- Comparable

	infix "<" (other: OPTIMIZE_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := class_id < other.class_id or else
			(class_id = other.class_id and then body_index < other.body_index);
		end;

end
